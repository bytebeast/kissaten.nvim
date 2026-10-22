local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/echasnovski/mini.nvim"

--- One module for every mini.* plugin (they are tiny, and LazyVim pulls in
--- several: mini.icons, mini.ai, mini.pairs, mini.surround ...).
---@type kissaten.HighlightsFn
function M.get(c, opts)
  local ui = c.ui
  local fbg = ui.bg_float
  local function mode(color)
    return { fg = c.crust, bg = color, bold = true }
  end

  -- stylua: ignore
  return {
    -- icons (used by LazyVim everywhere)
    MiniIconsAzure     = { fg = c.blue },
    MiniIconsBlue      = { fg = c.lavender },
    MiniIconsCyan      = { fg = c.cyan },
    MiniIconsGreen     = { fg = c.green },
    MiniIconsGrey      = { fg = c.subtext },
    MiniIconsOrange    = { fg = c.orange },
    MiniIconsPurple    = { fg = c.purple },
    MiniIconsRed       = { fg = c.red },
    MiniIconsYellow    = { fg = c.yellow },

    MiniAnimateCursor  = { reverse = true, nocombine = true },
    MiniAnimateNormalFloat = "NormalFloat",

    MiniClueBorder     = "FloatBorder",
    MiniClueDescGroup  = { fg = c.blue },
    MiniClueDescSingle = { fg = c.fg },
    MiniClueNextKey    = { fg = c.cyan, bold = true },
    MiniClueNextKeyWithPostkeys = { fg = c.red, bold = true },
    MiniClueSeparator  = { fg = c.overlay0 },
    MiniClueTitle      = "FloatTitle",

    MiniCompletionActiveParameter = "LspSignatureActiveParameter",
    MiniCursorword     = { bg = c.surface1 },
    MiniCursorwordCurrent = { bg = c.surface1 },

    MiniDepsChangeAdded   = "Added",
    MiniDepsChangeRemoved = "Removed",
    MiniDepsHint          = "DiagnosticHint",
    MiniDepsInfo          = "DiagnosticInfo",
    MiniDepsMsgBreaking   = "DiagnosticWarn",
    MiniDepsPlaceholder   = "Comment",
    MiniDepsTitle         = "Title",
    MiniDepsTitleError    = { fg = c.crust, bg = c.diag.error },
    MiniDepsTitleSame     = "Comment",
    MiniDepsTitleUpdate   = { fg = c.crust, bg = c.diag.ok },

    MiniDiffSignAdd       = { fg = c.git.add },
    MiniDiffSignChange    = { fg = c.git.change },
    MiniDiffSignDelete    = { fg = c.git.delete },
    MiniDiffOverAdd       = "DiffAdd",
    MiniDiffOverChange    = "DiffText",
    MiniDiffOverContext   = "DiffChange",
    MiniDiffOverDelete    = "DiffDelete",

    MiniFilesBorder       = "FloatBorder",
    MiniFilesBorderModified = { fg = c.orange, bg = fbg },
    MiniFilesCursorLine   = { bg = ui.bg_sel },
    MiniFilesDirectory    = "Directory",
    MiniFilesFile         = { fg = c.fg },
    MiniFilesNormal       = "NormalFloat",
    MiniFilesTitle        = { fg = c.comment, bg = fbg },
    MiniFilesTitleFocused = { fg = c.blue, bg = fbg, bold = true },

    MiniHipatternsFixme   = { fg = c.crust, bg = c.diag.error, bold = true },
    MiniHipatternsHack    = { fg = c.crust, bg = c.diag.warn, bold = true },
    MiniHipatternsNote    = { fg = c.crust, bg = c.diag.hint, bold = true },
    MiniHipatternsTodo    = { fg = c.crust, bg = c.blue, bold = true },

    MiniIndentscopeSymbol = { fg = ui.indent_scope, nocombine = true },
    MiniIndentscopePrefix = { nocombine = true },

    MiniJump              = { fg = c.crust, bg = c.pink },
    MiniJump2dDim         = { fg = c.overlay0 },
    MiniJump2dSpot        = { fg = c.pink, bold = true, nocombine = true },
    MiniJump2dSpotAhead   = { fg = c.teal, bg = c.mantle, nocombine = true },
    MiniJump2dSpotUnique  = { fg = c.orange, bold = true, nocombine = true },

    MiniMapNormal         = { fg = c.subtext, bg = c.mantle },
    MiniMapSymbolCount    = { fg = c.purple },
    MiniMapSymbolLine     = { fg = c.blue },
    MiniMapSymbolView     = { fg = c.overlay0 },

    MiniNotifyBorder      = "FloatBorder",
    MiniNotifyNormal      = "NormalFloat",
    MiniNotifyTitle       = "FloatTitle",

    MiniOperatorsExchangeFrom = "IncSearch",

    MiniPickBorder        = "FloatBorder",
    MiniPickBorderBusy    = { fg = c.orange, bg = fbg },
    MiniPickBorderText    = { fg = c.purple, bg = fbg, bold = true },
    MiniPickHeader        = { fg = c.blue, bold = true },
    MiniPickIconDirectory = "Directory",
    MiniPickIconFile      = { fg = c.subtext },
    MiniPickMatchCurrent  = { bg = ui.bg_sel },
    MiniPickMatchMarked   = { bg = Util.blend(c.purple, c.bg, 0.2) },
    MiniPickMatchRanges   = { fg = c.blue, bold = true },
    MiniPickNormal        = "NormalFloat",
    MiniPickPreviewLine   = { bg = ui.bg_sel },
    MiniPickPreviewRegion = "IncSearch",
    MiniPickPrompt        = { fg = c.orange, bg = fbg },
    MiniPickPromptCaret   = { fg = c.orange, bg = fbg },
    MiniPickPromptPrefix  = { fg = c.orange, bg = fbg },

    MiniStarterCurrent    = { nocombine = true },
    MiniStarterFooter     = { fg = c.comment, italic = true },
    MiniStarterHeader     = { fg = c.blue },
    MiniStarterInactive   = { fg = c.overlay0 },
    MiniStarterItem       = { fg = c.fg },
    MiniStarterItemBullet = { fg = c.overlay0 },
    MiniStarterItemPrefix = { fg = c.orange, bold = true },
    MiniStarterQuery      = { fg = c.cyan },
    MiniStarterSection    = { fg = c.purple },

    MiniStatuslineDevinfo     = { fg = c.subtext, bg = c.surface1 },
    MiniStatuslineFileinfo    = { fg = c.subtext, bg = c.surface1 },
    MiniStatuslineFilename    = { fg = c.subtext, bg = c.mantle },
    MiniStatuslineInactive    = { fg = c.comment, bg = c.mantle },
    MiniStatuslineModeCommand = mode(c.orange),
    MiniStatuslineModeInsert  = mode(c.green),
    MiniStatuslineModeNormal  = mode(c.blue),
    MiniStatuslineModeOther   = mode(c.teal),
    MiniStatuslineModeReplace = mode(c.red),
    MiniStatuslineModeVisual  = mode(c.purple),

    MiniSurround          = "IncSearch",

    MiniTablineCurrent    = { fg = c.fg, bg = c.surface1, bold = true },
    MiniTablineFill       = { bg = opts.transparent and c.none or c.crust },
    MiniTablineHidden     = { fg = c.comment, bg = c.mantle },
    MiniTablineModifiedCurrent = { fg = c.orange, bg = c.surface1, bold = true },
    MiniTablineModifiedHidden  = { fg = Util.blend(c.orange, c.bg, 0.6), bg = c.mantle },
    MiniTablineModifiedVisible = { fg = c.orange, bg = c.mantle },
    MiniTablineTabpagesection  = { fg = c.crust, bg = c.blue, bold = true },
    MiniTablineVisible    = { fg = c.subtext, bg = c.mantle },

    MiniTestEmphasis      = { bold = true },
    MiniTestFail          = { fg = c.diag.error, bold = true },
    MiniTestPass          = { fg = c.diag.ok, bold = true },
    MiniTrailspace        = { bg = c.red },
  }
end

return M
