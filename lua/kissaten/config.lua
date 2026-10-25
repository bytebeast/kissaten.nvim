---@mod kissaten.config Configuration and validation
local M = {}

M.version = "1.0.0" -- x-release-please-version

M.styles = { "morning", "afternoon", "evening", "midnight", "graveyard" }

---@alias kissaten.Style "morning"|"afternoon"|"evening"|"midnight"|"graveyard"
---@alias kissaten.Background "dark"|"normal"|"transparent"

---@class kissaten.Config
M.defaults = {
  --- Dark style used by `:colorscheme kissaten`: afternoon | evening | midnight | graveyard
  ---@type kissaten.Style
  style = "evening",
  --- Style used when `vim.o.background == "light"`
  ---@type kissaten.Style
  light_style = "morning",

  transparent = false, -- don't paint the editor background
  terminal_colors = true, -- set vim.g.terminal_color_0..15 for :terminal
  dim_inactive = false, -- darken non-current windows

  --- "normal" keeps the tuned palette. "high" lifts comments, line numbers,
  --- punctuation and UI hints to stronger contrast (recommended for bright
  --- rooms, projectors, low-quality panels and low vision).
  ---@type "normal"|"high"
  contrast = "normal",

  --- Fade code comments toward the background so they recede behind code.
  ---   false            -> off (comments at ~4.5:1 contrast)
  ---   true             -> same as 0.5
  ---   0.5              -> fade amount from 0 (off) to 1 (faintest)
  ---   { fade = 0.7, docstrings = true }  -> table form; docstrings fade too unless false
  --- `fade` is measured in contrast, not raw opacity, so the same value looks
  --- the same in every style, and 1 stops at 1.6:1 so comments never vanish.
  ---@type boolean|number|{fade?: number, docstrings?: boolean}
  subtle_comments = false,

  --- Color vision support. Remaps the colors that carry meaning on their own
  --- (diff and git status, diagnostics) to pairs that stay distinct:
  ---   false          -> off
  ---   "red-green"    -> protanopia / deuteranopia (the common kinds)
  ---   "blue-yellow"  -> tritanopia
  ---@type false|"red-green"|"blue-yellow"
  colorblind = false,

  --- Color intensity, from 0 (greys) to 1 (full color). Lightness and
  --- contrast are kept, so every syntax color still meets WCAG AA.
  saturation = 1,

  --- UI accent: titles, picker matches, the normal-mode statusline, the
  --- selected tab. Any palette accent name: "blue" | "lavender" | "purple" |
  --- "pink" | "red" | "maroon" | "orange" | "yellow" | "green" | "teal" |
  --- "cyan" | "sky"
  accent = "blue",

  --- Rainbow delimiters and rainbow indent scopes:
  ---   "vivid"   full palette colors
  ---   "dimmed"  softer, so brackets don't compete with code
  ---   "mono"    shades of grey from bright to dim by nesting depth
  ---@type "vivid"|"dimmed"|"mono"
  rainbow = "vivid",

  --- Give every local variable and parameter its own color, as in
  --- JetBrains IDEs (semantic highlighting). Needs an LSP with semantic
  --- tokens. Colors are tuned per style, all meet WCAG AA, and follow
  --- `colorblind` (6 colors that type can tell apart instead of 12).
  rainbow_variables = false,

  --- Pickers (Telescope, snacks, fzf-lua) without border lines: prompt,
  --- list and preview are told apart by background shade and title badges.
  borderless = false,

  diagnostics = {
    --- How problems are marked in code: "undercurl" | "underline" | false
    underline = "undercurl",
    --- Virtual text: "tinted" (colored background) | "plain"
    virtual_text = "tinted",
  },
  --- Inlay hints: "tinted" (subtle background) | "plain"
  ---@type "tinted"|"plain"
  inlay_hints = "tinted",

  --- Per-category text attributes; any `nvim_set_hl` attribute works.
  --- `conditionals` (if/else/switch) and `loops` (for/while) follow
  --- `keywords` unless you set them.
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    -- conditionals = { bold = true },
    -- loops = { bold = true },
    virtual_text = {}, -- diagnostic virtual text, e.g. { italic = true }
    inlay_hints = { italic = true },
    --- LSP semantic modifiers (stack on the token's color):
    mutable = { underline = true }, -- `mut` bindings (rust-analyzer)
    readonly = {}, -- const / readonly / final, e.g. { italic = true }
    statics = {}, -- static members, e.g. { bold = true }
    globals = {}, -- global scope (clangd, LuaLS), e.g. { underdotted = true }
    functions = {},
    variables = {},
    parameters = {},
    types = {},
    strings = {},
    constants = {},
    --- Background treatment: "dark" | "normal" | "transparent"
    ---@type kissaten.Background
    sidebars = "dark",
    ---@type kissaten.Background
    floats = "dark",
  },

  --- Global attribute kill-switches (handy for fonts without italics, etc.)
  no_italic = false,
  no_bold = false,
  no_underline = false,

  --- Draw borders of floats in the accent color instead of a subtle one.
  bright_borders = false,
  --- Bold the mode section of the bundled lualine themes.
  lualine_bold = false,

  --- Change palette colors before anything is derived from them.
  ---@type fun(palette: kissaten.Palette, style: kissaten.Style)
  on_palette = function(palette, style) end,
  --- Change semantic roles (colors.syn.*, colors.diag.*, colors.git.*, ...).
  ---@type fun(colors: kissaten.Colors)
  on_colors = function(colors) end,
  --- Final say over any highlight group.
  ---@type fun(highlights: kissaten.Highlights, colors: kissaten.Colors)
  on_highlights = function(highlights, colors) end,

  --- Plugin integrations.
  ---  all  = true  -> enable every integration
  ---  auto = true  -> enable integrations for plugins lazy.nvim / vim.pack know about
  ---  <name> = true|false -> force one on or off (name or repo, e.g. telescope / "telescope.nvim")
  ---@type table<string, boolean|{enabled: boolean}>
  plugins = {
    all = nil, -- nil = auto-decide: all when no supported plugin manager is found
    auto = true,
  },
}

---@type kissaten.Config?
M.options = nil

--- Palette colors that can serve as the UI `accent`.
M.accents =
  { "blue", "lavender", "purple", "pink", "red", "maroon", "orange", "yellow", "green", "teal", "cyan", "sky" }

local function one_of(list)
  return function(v)
    return vim.tbl_contains(list, v)
  end
end

local function is_table(v)
  return type(v) == "table"
end

local function table_or_nil(v)
  return v == nil or type(v) == "table"
end

--- Options checked by a simple rule: { dotted path, test, what's expected }.
--- An invalid value is reported once and replaced by its default.
-- stylua: ignore
local rules = {
  { "colorblind", function(v) return v == false or v == "red-green" or v == "blue-yellow" end, 'false, "red-green" or "blue-yellow"' },
  { "saturation", function(v) return type(v) == "number" and v == v and v >= 0 and v <= 1 end, "a number from 0 to 1" },
  { "accent", one_of(M.accents), "a palette accent (" .. table.concat(M.accents, ", ") .. ")" },
  { "rainbow", one_of({ "vivid", "dimmed", "mono" }), '"vivid", "dimmed" or "mono"' },
  { "borderless", function(v) return type(v) == "boolean" end, "boolean" },
  { "rainbow_variables", function(v) return type(v) == "boolean" end, "boolean" },
  { "diagnostics", is_table, "table" },
  { "diagnostics.underline", function(v) return v == false or v == "undercurl" or v == "underline" end, '"undercurl", "underline" or false' },
  { "diagnostics.virtual_text", one_of({ "tinted", "plain" }), '"tinted" or "plain"' },
  { "inlay_hints", one_of({ "tinted", "plain" }), '"tinted" or "plain"' },
  { "styles.conditionals", table_or_nil, "table of highlight attributes" },
  { "styles.loops", table_or_nil, "table of highlight attributes" },
  { "styles.virtual_text", is_table, "table of highlight attributes" },
  { "styles.inlay_hints", is_table, "table of highlight attributes" },
  { "styles.mutable", is_table, "table of highlight attributes" },
  { "styles.readonly", is_table, "table of highlight attributes" },
  { "styles.statics", is_table, "table of highlight attributes" },
  { "styles.globals", is_table, "table of highlight attributes" },
}

local function get(t, path)
  for key in path:gmatch("[^.]+") do
    if type(t) ~= "table" then
      return nil
    end
    t = t[key]
  end
  return t
end

local function set(t, path, value)
  local keys = vim.split(path, ".", { plain = true })
  for i = 1, #keys - 1 do
    if type(t[keys[i]]) ~= "table" then
      t[keys[i]] = {}
    end
    t = t[keys[i]]
  end
  t[keys[#keys]] = vim.deepcopy(value)
end

local function check(errors, name, ok, expected)
  if not ok then
    errors[#errors + 1] = ("%s: expected %s"):format(name, expected)
  end
end

--- Plain validation (no vim.validate, so the same code runs on 0.9 -> nightly).
---@return boolean ok, string[] errors
local function validate(opts)
  local e = {}
  local styles = table.concat(M.styles, ", ")
  check(e, "style", vim.tbl_contains(M.styles, opts.style), "one of " .. styles)
  check(e, "light_style", vim.tbl_contains(M.styles, opts.light_style), "one of " .. styles)
  check(e, "contrast", opts.contrast == "normal" or opts.contrast == "high", '"normal" or "high"')
  for _, k in ipairs({
    "transparent",
    "terminal_colors",
    "dim_inactive",
    "no_italic",
    "no_bold",
    "no_underline",
    "bright_borders",
    "lualine_bold",
  }) do
    check(e, k, type(opts[k]) == "boolean", "boolean")
  end
  check(e, "styles", type(opts.styles) == "table", "table")
  if type(opts.styles) == "table" then
    for _, k in ipairs({ "sidebars", "floats" }) do
      local v = opts.styles[k]
      check(e, "styles." .. k, v == "dark" or v == "normal" or v == "transparent", '"dark", "normal" or "transparent"')
    end
  end
  for _, k in ipairs({ "on_palette", "on_colors", "on_highlights" }) do
    check(e, k, type(opts[k]) == "function", "function")
  end
  check(e, "plugins", type(opts.plugins) == "table", "table")
  check(
    e,
    "subtle_comments",
    M.subtle_comments(opts) ~= nil or opts.subtle_comments == false or opts.subtle_comments == nil,
    "false, true, a number from 0 to 1, or { fade = 0..1, docstrings = boolean }"
  )
  for _, rule in ipairs(rules) do
    -- a non-table parent (e.g. `diagnostics = "x"`) is reported once, by its own rule
    local parent = rule[1]:match("^(.+)%.[^.]+$")
    if not parent or type(get(opts, parent)) == "table" then
      check(e, rule[1], rule[2](get(opts, rule[1])), rule[3])
    end
  end
  if #e > 0 then
    require("kissaten.util").notify("invalid configuration (using defaults for these):\n  " .. table.concat(e, "\n  "))
  end
  return #e == 0, e
end

--- Fix invalid values instead of erroring, so a typo never leaves you with
--- a broken editor.
local function sanitize(opts)
  local d = M.defaults
  if type(opts.styles) ~= "table" then
    opts.styles = vim.deepcopy(d.styles)
  end
  if not vim.tbl_contains(M.styles, opts.style) then
    opts.style = d.style
  end
  if not vim.tbl_contains(M.styles, opts.light_style) then
    opts.light_style = d.light_style
  end
  if opts.contrast ~= "normal" and opts.contrast ~= "high" then
    opts.contrast = d.contrast
  end
  for _, k in ipairs({ "sidebars", "floats" }) do
    local v = opts.styles[k]
    if v ~= "dark" and v ~= "normal" and v ~= "transparent" then
      opts.styles[k] = d.styles[k]
    end
  end
  for _, k in ipairs({ "on_palette", "on_colors", "on_highlights" }) do
    if type(opts[k]) ~= "function" then
      opts[k] = d[k]
    end
  end
  for _, k in ipairs({
    "transparent",
    "terminal_colors",
    "dim_inactive",
    "no_italic",
    "no_bold",
    "no_underline",
    "bright_borders",
    "lualine_bold",
  }) do
    if type(opts[k]) ~= "boolean" then
      opts[k] = d[k]
    end
  end
  if type(opts.plugins) ~= "table" then
    opts.plugins = vim.deepcopy(d.plugins)
  end
  if opts.subtle_comments ~= nil and opts.subtle_comments ~= false and not M.subtle_comments(opts) then
    opts.subtle_comments = d.subtle_comments
  end
  for _, rule in ipairs(rules) do
    if not rule[2](get(opts, rule[1])) then
      set(opts, rule[1], get(d, rule[1]))
    end
  end
  return opts
end

local function fade_ok(v)
  return type(v) == "number" and v == v and v >= 0 and v <= 1
end

--- Normalize `subtle_comments` into `{ fade, docstrings }`, or nil when it is
--- off or invalid.
---@param opts kissaten.Config
---@return {fade: number, docstrings: boolean}?
function M.subtle_comments(opts)
  local v = opts.subtle_comments
  if v == true then
    return { fade = 0.5, docstrings = true }
  elseif fade_ok(v) then
    return { fade = v, docstrings = true }
  elseif type(v) == "table" then
    local fade = v.fade == nil and 0.5 or v.fade
    local docstrings = v.docstrings == nil and true or v.docstrings
    if fade_ok(fade) and type(docstrings) == "boolean" then
      return { fade = fade, docstrings = docstrings }
    end
  end
  return nil
end

---@param options? kissaten.Config
function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})
  if not validate(M.options) then
    sanitize(M.options)
  end
end

---@param opts? kissaten.Config
---@return kissaten.Config
function M.extend(opts)
  local base = M.options or vim.deepcopy(M.defaults)
  if not opts then
    return base
  end
  local merged = vim.tbl_deep_extend("force", {}, base, opts)
  if not validate(merged) then
    sanitize(merged)
  end
  return merged
end

return M
