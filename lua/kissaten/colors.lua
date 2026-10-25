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

--- `colorblind`: palette color names per role. Chosen by simulating each
--- color vision deficiency (Machado et al. 2009, full severity) on every
--- style and maximizing the smallest OKLab distance between colors that must
--- be told apart (added/changed/deleted; error/warn/ok/info/hint). Same idea
--- as GitHub's colorblind themes: success turns blue, and for red-green,
--- danger becomes orange where red and green would collapse.
--- `light`/`dark` entries apply by background; the light style's deeper inks
--- need a different set to stay apart.
M.colorblind = {
  ["red-green"] = {
    git = { add = "blue", change = "teal", delete = "orange", conflict = "lavender", untracked = "maroon" },
    diff = { add = "blue", change = "teal", delete = "orange" },
    diag = {
      dark = { error = "red", warn = "yellow", ok = "blue", info = "lavender", hint = "sky" },
      light = { error = "pink", warn = "orange", ok = "blue", info = "cyan", hint = "maroon" },
    },
  },
  ["blue-yellow"] = {
    git = { add = "blue", change = "yellow", delete = "red", conflict = "purple", untracked = "green" },
    diff = { add = "blue", change = "yellow", delete = "red" },
    diag = { error = "red", warn = "yellow", ok = "blue", info = "teal", hint = "lavender" },
  },
}

--- The least color status roles (git, diff, diagnostics) keep under
--- `saturation`: below this their hues start to merge for everyone.
M.STATUS_SATURATION = 0.7

--- Diff backgrounds mix in a little more color in colorblind mode, so added
--- and deleted lines stay as far apart as they are for normal color vision.
M.COLORBLIND_DIFF_BOOST = 1.25

--- How much stronger write references are than reads (contrast factor).
M.WRITE_STRENGTH = 1.3

--- Mix `color` into `bg` until the mix has `ratio` contrast against `bg`
--- (a tint exactly as visible as a given neutral shade).
function M.tint_to(color, bg, ratio)
  local lo, hi = 0, 1
  for _ = 1, 20 do
    local mid = (lo + hi) / 2
    if Util.contrast(Util.blend(color, bg, mid), bg) < ratio then
      lo = mid
    else
      hi = mid
    end
  end
  return Util.blend(color, bg, hi)
end

--- `rainbow_variables`: how many distinct colors variables cycle through.
M.VARIABLE_COLORS = 12

--- The accents whose chroma and contrast the variable colors are tuned to.
local ACCENTS =
  { "red", "maroon", "orange", "yellow", "green", "teal", "cyan", "sky", "blue", "lavender", "purple", "pink" }

local function median(list)
  table.sort(list)
  local n = #list
  return n % 2 == 1 and list[(n + 1) / 2] or (list[n / 2] + list[n / 2 + 1]) / 2
end

--- `rainbow_variables` colors. Evenly spaced hues around the OKLab circle at
--- the palette's typical chroma and contrast, so per-variable colors sit at
--- the same visual weight as the theme's own accents. Two lightness tiers
--- alternate around the circle, so hue neighbours also differ in lightness.
--- Every color is matched to its contrast exactly (all >= 4.5:1).
---
--- With `colorblind`, hue alone can't carry 12 colors, so the set uses the
--- two hues that type still tells apart (blue vs. yellow for red-green, red
--- vs. teal for blue-yellow), each in three lightness steps: 6 colors.
---@param c kissaten.Colors|kissaten.Palette
---@param colorblind? false|"red-green"|"blue-yellow"
---@return string[]
function M.variable_colors(c, colorblind)
  local chromas, ratios = {}, {}
  for _, key in ipairs(ACCENTS) do
    local _, a, b = Util.to_oklab(c[key])
    chromas[#chromas + 1] = math.sqrt(a * a + b * b)
    ratios[#ratios + 1] = Util.contrast(c[key], c.bg)
  end
  local chroma, ratio = median(chromas), math.max(4.5, median(ratios))
  local fg_ratio = Util.contrast(c.fg, c.bg)
  -- the second tier goes toward the background where there's room (dark
  -- styles), otherwise away from it (the light style's inks sit near 4.5)
  local function tier(k) -- k = 0, 1, 2 steps away from the main tier
    if k == 0 then
      return ratio
    end
    local down = ratio * M.VARIABLE_TIER ^ k
    if down >= 4.5 then
      return down
    end
    return math.min(ratio / M.VARIABLE_TIER ^ k, fg_ratio * 0.95)
  end
  local L = Util.to_oklab(c.fg)
  local function color(hue, target)
    local h = math.rad(hue)
    return Util.match_contrast(Util.from_oklab(L, chroma * math.cos(h), chroma * math.sin(h)), c.bg, target)
  end
  local out = {}
  local axis = M.VARIABLE_CVD_HUES[colorblind or ""]
  if axis then
    -- three lightness steps spread over the whole readable range, from just
    -- above AA to just below the text color
    local lo, hi = 4.6, fg_ratio * 0.95
    for _, target in ipairs({ lo, math.sqrt(lo * hi), hi }) do
      for _, hue in ipairs(axis) do
        out[#out + 1] = color(hue, target)
      end
    end
    return out
  end
  local n = M.VARIABLE_COLORS
  for i = 0, n - 1 do
    out[i + 1] = color(M.VARIABLE_HUE_START + i * 360 / n, tier(i % 2))
  end
  return out
end
M.VARIABLE_HUE_START = 25
M.VARIABLE_TIER = 0.6
--- OKLab hues each color vision deficiency keeps apart.
M.VARIABLE_CVD_HUES = { ["red-green"] = { 260, 85 }, ["blue-yellow"] = { 25, 195 } }

--- rainbow-delimiters' default nesting order (outermost first).
M.BRACKET_ORDER = { "red", "yellow", "blue", "orange", "green", "violet", "cyan" }

--- `rainbow = "dimmed" | "mono"`.
---   dimmed: each color keeps its hue, faded to 70% of its contrast (never
---           below 3:1), so brackets stay readable but quieter than code.
---   mono:   no hue; a ladder from `subtext` (outermost) down toward
---           `comment`, so depth still reads as brightness.
---@param c kissaten.Colors
---@param mode "dimmed"|"mono"
function M.rainbow_mode(c, mode)
  local function dim(color)
    local from = Util.contrast(color, c.bg)
    return Util.reduce_contrast(color, c.bg, math.max(3, from * 0.7))
  end
  local function shade(i, n)
    return Util.blend(c.comment, c.subtext, (i - 1) / math.max(1, n - 1))
  end
  for i, name in ipairs(M.BRACKET_ORDER) do
    c.brackets[name] = mode == "mono" and shade(i, #M.BRACKET_ORDER) or dim(c.brackets[name])
  end
  for i, color in ipairs(c.scopes) do
    c.scopes[i] = mode == "mono" and shade(i, #c.scopes) or dim(color)
  end
end

--- `saturation`: scale every palette color's chroma in OKLab, then restore
--- each color's original contrast against the (new) background, so the
--- contrast hierarchy - and every AA guarantee - is exactly as tuned.
---@param p kissaten.Palette
---@param amount number 0..1
function M.desaturate(p, amount)
  local bg = p.bg
  local new_bg = Util.desaturate(bg, amount)
  for key, color in pairs(p) do
    if key:sub(1, 1) ~= "_" and Util.is_hex(color) then
      p[key] = key == "bg" and new_bg
        or Util.match_contrast(Util.desaturate(color, amount), new_bg, Util.contrast(color, bg))
    end
  end
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
  -- status colors (git, diff, diagnostics) carry meaning by hue, so they
  -- keep more color than `saturation` asks for: at least STATUS_SATURATION,
  -- and all of it when `colorblind` is on
  local s = p -- palette the status roles read from
  if opts.saturation < 1 then
    local status = opts.colorblind and 1 or math.max(opts.saturation, M.STATUS_SATURATION)
    s = vim.deepcopy(p)
    M.desaturate(p, opts.saturation)
    if status < 1 then
      M.desaturate(s, status)
    end
    -- match the status colors to the background the user actually sees
    for key, color in pairs(s) do
      if key:sub(1, 1) ~= "_" and Util.is_hex(color) and key ~= "bg" then
        s[key] = Util.match_contrast(color, p.bg, Util.contrast(color, s.bg))
      end
    end
  end

  local light = p._background == "light"
  Util.bg, Util.fg = p.bg, p.fg
  Util.tint_scale = p._tint or 1

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
  -- Near-black styles (midnight, graveyard) have no room for a "darker"
  -- float: mantle sits within ~1.05:1 of the editor, so popups would bleed
  -- into it. There, floats and popups sit a step *above* the editor instead.
  local near_black = not light and Util.contrast(c.mantle, c.bg) < 1.06
  local float_shade = near_black and c.surface0 or c.mantle

  local function bg_for(kind, dark)
    return kind == "transparent" and c.none or kind == "dark" and dark or c.bg
  end

  ---@class kissaten.UiColors
  c.ui = {
    bg = opts.transparent and c.none or c.bg,
    bg_dim = c.mantle, -- inactive windows when dim_inactive = true
    -- sidebars stay below the editor: lifting them would hide their cursorline
    bg_sidebar = opts.transparent and c.none or bg_for(opts.styles.sidebars, c.mantle),
    bg_float = opts.transparent and opts.styles.floats ~= "normal" and c.none
      or bg_for(opts.styles.floats, float_shade),
    bg_popup = float_shade, -- completion menus always get a solid background
    bg_statusline = opts.transparent and c.none or c.mantle,
    bg_cursorline = c.surface0,
    bg_visual = Util.tint(c.blue, c.bg, light and 0.18 or 0.22),
    bg_search = Util.tint(c.yellow, c.bg, light and 0.25 or 0.22),
    bg_cursearch = c.orange,
    bg_match = c.surface2,
    -- selected item in menus/lists; a step further on lifted near-black floats
    bg_sel = near_black and c.surface2 or c.surface1,
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
  }
  -- `accent`: titles, matches, badges and the normal-mode statusline.
  local accent = c[opts.accent] or c.blue
  c.ui.accent = accent
  c.ui.title = accent
  c.ui.pmenu_match = accent
  c.ui.border_float = opts.bright_borders and accent or Util.blend(accent, c.bg, 0.55)
  if opts.styles.floats == "normal" or opts.transparent then
    -- floats share the editor bg, so they need a visible border to read as floats
    c.ui.border_float = opts.bright_borders and accent or Util.blend(accent, c.bg, 0.7)
  end
  -- Statusline mode colors (lualine, mini.statusline). Normal mode is the
  -- accent; a mode that would share the accent's color takes blue (the
  -- color normal mode gave up), so no two modes ever look the same.
  -- Like status colors, modes keep their hue under `saturation`.
  local modes = { insert = "green", visual = "purple", replace = "red", command = "orange", terminal = "teal" }
  c.ui.modes = { normal = s[opts.accent] or s.blue }
  for mode, name in pairs(modes) do
    c.ui.modes[mode] = s[name == opts.accent and "blue" or name]
  end

  -- Symbol references under the cursor (LSP document highlight,
  -- vim-illuminate): reads on a neutral shade, writes on a pink tint a little
  -- stronger, like JetBrains' "identifier under caret" read/write colors.
  -- Pink stays clear of search (yellow), selection (blue) and diff tints,
  -- and the extra strength keeps writes apart with color blindness too.
  c.ui.bg_read = c.surface1
  c.ui.bg_write = M.tint_to(c.pink, c.bg, Util.contrast(c.surface1, c.bg) * M.WRITE_STRENGTH)

  -- `rainbow_variables`: like status colors, per-variable colors carry
  -- meaning, so they read from the status palette (hue kept under saturation)
  if opts.rainbow_variables then
    local base = { bg = c.bg, fg = c.fg }
    for _, key in ipairs(ACCENTS) do
      base[key] = s[key]
    end
    c.variables = M.variable_colors(base, opts.colorblind)
  end

  -- `borderless`: picker panels told apart by shade instead of lines (the
  -- Kanagawa recipe): prompt a step lighter than the editor, list on the
  -- usual float shade, preview the deepest. Always solid, even with
  -- `transparent`, since without lines the shade is all that frames them.
  c.ui.picker = {
    prompt = light and Util.blend(c.surface1, c.surface2, 0.35) or c.surface0,
    list = c.mantle,
    preview = c.crust,
    sel = c.ui.bg_sel,
  }
  if near_black then
    -- near-black styles have no room below the editor: lift prompt and list
    c.ui.picker.prompt, c.ui.picker.list = c.surface1, c.surface0
  end

  -- Text on a colored badge (mode indicators, picker titles, the selected
  -- tab). On dark styles the deepest background; on the light style the
  -- paper itself, the only base that reaches 4.5:1 on every accent there.
  c.ui.on_badge = light and c.bg or c.crust

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
    error = s.red,
    warn = s.yellow,
    info = s.sky,
    hint = s.teal,
    ok = s.green,
  }

  ---@class kissaten.GitColors
  c.git = {
    add = s.green,
    change = s.yellow,
    delete = s.red,
    conflict = s.orange,
    ignore = c.overlay0,
    untracked = s.lavender,
  }

  -- diff backgrounds: hue per kind, mixed into the background
  local hue = { add = s.green, delete = s.red, change = s.blue }
  local boost = 1

  local cb = opts.colorblind and M.colorblind[opts.colorblind]
  if cb then
    local pick = function(t)
      local names = t[light and "light" or "dark"] or t
      local out = {}
      for role, name in pairs(names) do
        out[role] = s[name]
      end
      return out
    end
    c.diag = vim.tbl_extend("force", c.diag, pick(cb.diag))
    c.git = vim.tbl_extend("force", c.git, pick(cb.git))
    hue = pick(cb.diff)
    boost = M.COLORBLIND_DIFF_BOOST
  end

  local diff_alpha = (light and 0.22 or 0.18) * boost
  ---@class kissaten.DiffColors
  c.diff = {
    add = Util.tint(hue.add, c.bg, diff_alpha),
    delete = Util.tint(hue.delete, c.bg, diff_alpha),
    change = Util.tint(hue.change, c.bg, (light and 0.14 or 0.12) * boost),
    text = Util.tint(hue.change, c.bg, (light and 0.3 or 0.32) * boost),
  }

  -- Rainbow order is chosen so neighbours never share a hue family.
  c.rainbow = { c.blue, c.yellow, c.green, c.teal, c.purple, c.orange, c.pink, c.cyan }

  -- Brackets (rainbow-delimiters, in its own nesting order) and rainbow
  -- indent scopes follow `rainbow`; headings keep `c.rainbow`.
  c.brackets = {
    red = c.red,
    yellow = c.yellow,
    blue = c.blue,
    orange = c.orange,
    green = c.green,
    violet = c.purple,
    cyan = c.cyan,
  }
  c.scopes = vim.list_extend({}, c.rainbow)
  if opts.rainbow ~= "vivid" then
    M.rainbow_mode(c, opts.rainbow)
  end

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
