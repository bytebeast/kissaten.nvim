---@mod kissaten.colors Palette -> semantic colors
---
--- Three layers keep the theme easy to change:
---   1. palette  (lua/kissaten/palettes/*.lua)  raw colors per style
---   2. colors   (this file)                    semantic roles: syn, ui, diag, git, diff
---   3. groups   (lua/kissaten/groups/*)        highlight groups that only read roles
--- Re-pointing one role (e.g. `colors.syn.parameter`) restyles every group,
--- language and plugin that uses it.
local Util = require("kissaten.util")

local M = {}

--- Faintest contrast `subtle_comments` will fade to (fade = 1).
M.SUBTLE_FLOOR = 1.6

--- Fade `color` toward `bg` by `fade` (0..1), measured in contrast: 0 keeps
--- the current contrast, 1 reaches `M.SUBTLE_FLOOR`.
function M.fade(color, bg, fade)
  if not (Util.is_hex(color) and Util.is_hex(bg)) then
    return color
  end
  local from = Util.contrast(color, bg)
  if from <= M.SUBTLE_FLOOR then
    return color
  end
  return Util.reduce_contrast(color, bg, from - fade * (from - M.SUBTLE_FLOOR))
end

---@param style kissaten.Style
---@return kissaten.Palette
function M.palette(style)
  local ok, palette = pcall(require, "kissaten.palettes." .. style)
  if not ok then
    Util.notify(("unknown style '%s', using 'evening'"):format(tostring(style)))
    palette = require("kissaten.palettes.evening")
  end
  return vim.deepcopy(palette)
end

---@param opts? kissaten.Config
---@return kissaten.Colors
function M.setup(opts)
  opts = require("kissaten.config").extend(opts)

  local p = M.palette(opts.style)
  opts.on_palette(p, opts.style)

  local light = p._background == "light"
  Util.bg, Util.fg = p.bg, p.fg

  ---@class kissaten.Colors: kissaten.Palette
  local c = p
  c.none = "NONE"
  c.style = opts.style
  c.light = light

  -- Accessibility: lift the low-contrast "chrome" colors, never the accents.
  if opts.contrast == "high" then
    c.comment = Util.ensure_contrast(c.comment, c.bg, 6.0, c.fg)
    c.overlay0 = Util.ensure_contrast(c.overlay0, c.bg, 3.6, c.fg)
    c.subtext = Util.ensure_contrast(c.subtext, c.bg, light and 8.0 or 9.0, c.fg)
    c.surface2 = Util.blend(c.surface2, c.overlay0, 0.75)
  end

  -- ── UI ──────────────────────────────────────────────────────────────────
  local function bg_for(kind)
    return kind == "transparent" and c.none or kind == "dark" and c.mantle or c.bg
  end

  ---@class kissaten.UiColors
  c.ui = {
    bg = opts.transparent and c.none or c.bg,
    bg_dim = c.mantle, -- inactive windows when dim_inactive = true
    bg_sidebar = opts.transparent and c.none or bg_for(opts.styles.sidebars),
    bg_float = opts.transparent and opts.styles.floats ~= "normal" and c.none or bg_for(opts.styles.floats),
    bg_popup = c.mantle, -- completion menus always get a solid background
    bg_statusline = opts.transparent and c.none or c.mantle,
    bg_cursorline = c.surface0,
    bg_visual = Util.blend(c.blue, c.bg, light and 0.18 or 0.22),
    bg_search = Util.blend(c.yellow, c.bg, light and 0.25 or 0.22),
    bg_cursearch = c.orange,
    bg_match = c.surface2,
    bg_sel = c.surface1, -- selected item in menus/lists
    fg = c.fg,
    fg_dim = c.subtext,
    fg_sidebar = c.subtext,
    fg_gutter = c.overlay0,
    fg_gutter_cur = c.orange,
    nontext = Util.blend(c.overlay0, c.bg, 0.85),
    whitespace = Util.blend(c.overlay0, c.bg, 0.7),
    indent = Util.blend(c.overlay0, c.bg, 0.45),
    indent_scope = Util.blend(c.lavender, c.bg, 0.65),
    border = light and c.surface2 or c.crust,
    border_float = opts.bright_borders and c.blue or Util.blend(c.blue, c.bg, 0.55),
    title = c.blue,
    accent = c.blue,
    pmenu_match = c.blue,
  }
  if opts.styles.floats == "normal" or opts.transparent then
    -- floats share the editor bg, so they need a visible border to read as floats
    c.ui.border_float = opts.bright_borders and c.blue or Util.blend(c.blue, c.bg, 0.7)
  end

  -- ── Syntax roles ───────────────────────────────────────────────────────
  -- Assigned for scanning speed: structure (keywords/functions) is cool,
  -- data (strings/numbers/types) is warm, and each role keeps >= 4.5:1.
  ---@class kissaten.SyntaxColors
  c.syn = {
    comment = c.comment,
    keyword = c.purple,
    keyword_flow = c.purple, -- if / for / while / return
    keyword_exception = c.red, -- try / catch / throw / raise
    keyword_import = c.pink, -- import / require / use / #include
    operator = c.sky,
    punct = c.subtext,
    punct_special = c.pink, -- `${`, `#{`, `{}` inside strings
    func = c.blue,
    func_builtin = c.cyan,
    macro = c.pink,
    type = c.yellow,
    type_builtin = Util.blend(c.yellow, c.orange, 0.75),
    constructor = c.yellow,
    variable = c.fg,
    variable_builtin = c.red, -- self, this, super
    parameter = c.maroon,
    property = c.teal,
    module = c.lavender,
    constant = c.orange,
    number = c.orange,
    boolean = c.orange,
    string = c.green,
    string_doc = Util.blend(c.green, c.comment, 0.6),
    string_special = c.teal, -- symbols, paths, URLs-in-strings
    regex = c.cyan,
    escape = c.pink,
    character = c.green,
    attribute = c.pink, -- decorators, annotations, attributes
    label = c.sky,
    tag = c.red,
    tag_attribute = c.teal,
    tag_delimiter = c.overlay0,
    preproc = c.pink,
    special = c.cyan,
    deprecated = c.overlay0,
  }

  -- Optional: let comments recede behind code (before on_colors, so user
  -- overrides of syn.comment still win). UI uses of `c.comment` (inlay hints,
  -- ghost text, statusline) keep their normal contrast.
  local subtle = require("kissaten.config").subtle_comments(opts)
  if subtle and subtle.fade > 0 then
    c.syn.comment = M.fade(c.syn.comment, c.bg, subtle.fade)
    if subtle.docstrings then
      c.syn.string_doc = M.fade(c.syn.string_doc, c.bg, subtle.fade)
    end
  end

  -- ── Diagnostics, git, diff ─────────────────────────────────────────────
  ---@class kissaten.DiagColors
  c.diag = {
    error = c.red,
    warn = c.yellow,
    info = c.sky,
    hint = c.teal,
    ok = c.green,
  }

  ---@class kissaten.GitColors
  c.git = {
    add = c.green,
    change = c.yellow,
    delete = c.red,
    conflict = c.orange,
    ignore = c.overlay0,
    untracked = c.lavender,
  }

  local diff_alpha = light and 0.22 or 0.18
  ---@class kissaten.DiffColors
  c.diff = {
    add = Util.blend(c.green, c.bg, diff_alpha),
    delete = Util.blend(c.red, c.bg, diff_alpha),
    change = Util.blend(c.blue, c.bg, light and 0.14 or 0.12),
    text = Util.blend(c.blue, c.bg, light and 0.3 or 0.32),
  }

  -- Rainbow order is chosen so neighbours never share a hue family.
  c.rainbow = { c.blue, c.yellow, c.green, c.teal, c.purple, c.orange, c.pink, c.cyan }

  -- ── Terminal ───────────────────────────────────────────────────────────
  local bright = light and function(x)
    return Util.shade(x, -0.06)
  end or function(x)
    return Util.brighten(x, 0.05)
  end
  ---@class kissaten.TerminalColors
  c.terminal = {
    black = light and c.subtext or c.surface1,
    black_bright = light and c.comment or c.overlay0,
    red = c.red,
    red_bright = bright(c.red),
    green = c.green,
    green_bright = bright(c.green),
    yellow = c.yellow,
    yellow_bright = bright(c.yellow),
    blue = c.blue,
    blue_bright = bright(c.blue),
    magenta = c.pink,
    magenta_bright = bright(c.purple),
    cyan = c.teal,
    cyan_bright = bright(c.cyan),
    white = light and c.surface2 or c.subtext,
    white_bright = light and c.crust or c.fg,
  }

  opts.on_colors(c)
  return c
end

return M
