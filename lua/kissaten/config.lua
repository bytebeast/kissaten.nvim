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

  --- Per-category text attributes; any `nvim_set_hl` attribute works.
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
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
