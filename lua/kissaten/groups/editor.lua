---@mod kissaten.groups.editor Built-in UI groups (:h highlight-groups)
local Util = require("kissaten.util")

local M = {}

---@type kissaten.HighlightsFn
function M.get(c, opts)
  local ui = c.ui
  local d = c.diag
  local tbg = opts.transparent and c.none or c.bg

  -- stylua: ignore
  return {
    Normal                = { fg = ui.fg, bg = ui.bg },
    NormalNC              = { fg = ui.fg, bg = opts.transparent and c.none or opts.dim_inactive and ui.bg_dim or c.bg },
    NormalSB              = { fg = ui.fg_sidebar, bg = ui.bg_sidebar }, -- sidebar windows
    NormalFloat           = { fg = ui.fg, bg = ui.bg_float },
    FloatBorder           = { fg = ui.border_float, bg = ui.bg_float },
    FloatTitle            = { fg = ui.title, bg = ui.bg_float, bold = true },
    FloatFooter           = { fg = ui.fg_dim, bg = ui.bg_float },
    FloatShadow           = { bg = c.crust, blend = 80 },
    FloatShadowThrough    = { bg = c.crust, blend = 100 },

    Cursor                = { fg = c.bg, bg = c.fg },
    lCursor               = "Cursor",
    CursorIM              = "Cursor",
    TermCursor            = { fg = c.bg, bg = c.fg },
    TermCursorNC          = { fg = c.bg, bg = c.overlay0 },
    CursorLine            = { bg = ui.bg_cursorline },
    CursorColumn          = { bg = ui.bg_cursorline },
    ColorColumn           = { bg = c.mantle },
    CursorLineNr          = { fg = ui.fg_gutter_cur, bold = true },
    CursorLineSign        = { bg = c.none },
    CursorLineFold        = { fg = c.comment },
    LineNr                = { fg = ui.fg_gutter },
    LineNrAbove           = "LineNr",
    LineNrBelow           = "LineNr",
    SignColumn            = { fg = ui.fg_gutter, bg = tbg },
    SignColumnSB          = { fg = ui.fg_gutter, bg = ui.bg_sidebar },
    FoldColumn            = { fg = c.comment, bg = tbg },
    Folded                = { fg = c.blue, bg = Util.blend(c.surface1, c.bg, 0.6) },

    Conceal               = { fg = c.comment },
    Directory             = { fg = c.blue },
    EndOfBuffer           = { fg = c.bg },
    NonText               = { fg = ui.nontext },
    SpecialKey            = { fg = ui.nontext },
    Whitespace            = { fg = ui.whitespace },

    VertSplit             = { fg = ui.border },
    WinSeparator          = { fg = ui.border, bold = true },

    Visual                = { bg = ui.bg_visual },
    VisualNOS             = { bg = ui.bg_visual },
    Search                = { fg = ui.fg, bg = ui.bg_search },
    IncSearch             = { fg = c.crust, bg = ui.bg_cursearch, bold = true },
    CurSearch             = "IncSearch",
    Substitute            = { fg = c.crust, bg = c.red },
    MatchParen            = { fg = c.orange, bg = ui.bg_match, bold = true },
    QuickFixLine          = { bg = ui.bg_visual, bold = true },

    Pmenu                 = { fg = ui.fg, bg = ui.bg_popup },
    PmenuSel              = { bg = ui.bg_sel, bold = true },
    PmenuKind             = { fg = c.lavender, bg = ui.bg_popup },
    PmenuKindSel          = { fg = c.lavender, bg = ui.bg_sel },
    PmenuExtra            = { fg = c.comment, bg = ui.bg_popup },
    PmenuExtraSel         = { fg = c.comment, bg = ui.bg_sel },
    PmenuMatch            = { fg = ui.pmenu_match, bg = ui.bg_popup, bold = true },
    PmenuMatchSel         = { fg = ui.pmenu_match, bg = ui.bg_sel, bold = true },
    PmenuSbar             = { bg = c.surface0 },
    PmenuThumb            = { bg = c.surface2 },
    PmenuBorder           = { fg = ui.border_float, bg = ui.bg_popup },
    ComplMatchIns         = { fg = c.comment },
    ComplHint             = { fg = c.comment },
    ComplHintMore         = { fg = c.comment },
    SnippetTabstop        = { bg = Util.blend(c.lavender, c.bg, 0.15) },
    SnippetTabstopActive  = { bg = Util.blend(c.lavender, c.bg, 0.25) },
    WildMenu              = { bg = ui.bg_sel },

    StatusLine            = { fg = ui.fg_sidebar, bg = ui.bg_statusline },
    StatusLineNC          = { fg = c.comment, bg = ui.bg_statusline },
    StatusLineTerm        = "StatusLine",
    StatusLineTermNC      = "StatusLineNC",
    TabLine               = { fg = c.comment, bg = c.mantle },
    TabLineFill           = { bg = opts.transparent and c.none or c.crust },
    TabLineSel            = { fg = c.crust, bg = c.blue, bold = true },
    WinBar                = { fg = ui.fg_dim, bg = tbg },
    WinBarNC              = { fg = c.comment, bg = tbg },

    Title                 = { fg = ui.title, bold = true },
    ModeMsg               = { fg = ui.fg_dim, bold = true },
    MsgArea               = { fg = ui.fg_dim },
    MsgSeparator          = { fg = ui.border, bg = c.mantle },
    MoreMsg               = { fg = c.blue },
    Question              = { fg = c.blue },
    ErrorMsg              = { fg = d.error },
    WarningMsg            = { fg = d.warn },
    OkMsg                 = { fg = d.ok },
    StderrMsg             = "ErrorMsg",
    StdoutMsg             = { fg = ui.fg_dim },

    DiffAdd               = { bg = c.diff.add },
    DiffChange            = { bg = c.diff.change },
    DiffDelete            = { fg = Util.blend(c.red, c.bg, 0.6), bg = c.diff.delete },
    DiffText              = { bg = c.diff.text },
    DiffTextAdd           = { bg = Util.blend(c.green, c.bg, 0.32) },
    Added                 = { fg = c.git.add },
    Changed               = { fg = c.git.change },
    Removed               = { fg = c.git.delete },
    diffAdded             = { fg = c.git.add },
    diffRemoved           = { fg = c.git.delete },
    diffChanged           = { fg = c.git.change },
    diffOldFile           = { fg = c.red, italic = true },
    diffNewFile           = { fg = c.green, italic = true },
    diffFile              = { fg = c.blue, bold = true },
    diffLine              = { fg = c.comment },
    diffIndexLine         = { fg = c.purple },

    SpellBad              = { sp = d.error, undercurl = true },
    SpellCap              = { sp = d.warn, undercurl = true },
    SpellLocal            = { sp = d.info, undercurl = true },
    SpellRare             = { sp = d.hint, undercurl = true },

    healthError           = { fg = d.error },
    healthSuccess         = { fg = d.ok },
    healthWarning         = { fg = d.warn },
    qfFileName            = { fg = c.blue },
    qfLineNr              = { fg = c.comment },
    helpCommand           = { fg = c.blue, bg = c.surface0 },
    helpExample           = { fg = c.comment },
    debugPC               = { bg = Util.blend(c.blue, c.bg, 0.15) },
    debugBreakpoint       = { fg = d.error, bg = Util.blend(d.error, c.bg, 0.15) },
  }
end

return M
