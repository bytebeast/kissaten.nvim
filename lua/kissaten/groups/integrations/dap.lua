local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/mfussenegger/nvim-dap"

--- nvim-dap signs + nvim-dap-ui panels.
---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    DapStoppedLine           = { bg = Util.blend(c.yellow, c.bg, 0.14) },
    DapBreakpoint            = { fg = c.red },
    DapBreakpointCondition   = { fg = c.yellow },
    DapBreakpointRejected    = { fg = c.overlay0 },
    DapLogPoint              = { fg = c.sky },
    DapStopped               = { fg = c.yellow },

    DapUIScope               = { fg = c.blue, bold = true },
    DapUIType                = { fg = c.syn.type },
    DapUIValue               = { fg = c.fg },
    DapUIVariable            = { fg = c.fg },
    DapUIModifiedValue       = { fg = c.orange, bold = true },
    DapUIDecoration          = { fg = c.overlay0 },
    DapUIThread              = { fg = c.green },
    DapUIStoppedThread       = { fg = c.yellow },
    DapUISource              = { fg = c.lavender },
    DapUILineNumber          = { fg = c.orange },
    DapUIFloatBorder         = "FloatBorder",
    DapUIWatchesEmpty        = { fg = c.comment },
    DapUIWatchesValue        = { fg = c.green },
    DapUIWatchesError        = { fg = c.red },
    DapUIBreakpointsPath     = { fg = c.blue },
    DapUIBreakpointsInfo     = { fg = c.green },
    DapUIBreakpointsCurrentLine = { fg = c.yellow, bold = true },
    DapUIBreakpointsDisabledLine = { fg = c.overlay0 },
    DapUIWinSelect           = { fg = c.orange, bold = true },
    DapUIPlayPause           = { fg = c.green },
    DapUIRestart             = { fg = c.green },
    DapUIStop                = { fg = c.red },
    DapUIStepOver            = { fg = c.blue },
    DapUIStepInto            = { fg = c.blue },
    DapUIStepOut             = { fg = c.blue },
    DapUIStepBack            = { fg = c.blue },
    DapUIUnavailable         = { fg = c.overlay0 },
    DapUIPlayPauseNC         = { fg = c.green, bg = c.mantle },
    DapUIRestartNC           = { fg = c.green, bg = c.mantle },
    DapUIStopNC              = { fg = c.red, bg = c.mantle },
    DapUIStepOverNC          = { fg = c.blue, bg = c.mantle },
    DapUIStepIntoNC          = { fg = c.blue, bg = c.mantle },
    DapUIStepOutNC           = { fg = c.blue, bg = c.mantle },
    DapUIStepBackNC          = { fg = c.blue, bg = c.mantle },
    DapUIUnavailableNC       = { fg = c.overlay0, bg = c.mantle },
    NvimDapVirtualText       = { fg = c.comment, italic = true },
    NvimDapVirtualTextChanged = { fg = c.orange, italic = true },
    NvimDapVirtualTextError  = { fg = c.red, italic = true },
  }
end

return M
