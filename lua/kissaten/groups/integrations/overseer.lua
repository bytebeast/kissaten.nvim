local M = {}

M.url = "https://github.com/stevearc/overseer.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    OverseerPENDING    = { fg = c.comment },
    OverseerRUNNING    = { fg = c.yellow },
    OverseerSUCCESS    = { fg = c.diag.ok },
    OverseerCANCELED   = { fg = c.overlay0 },
    OverseerFAILURE    = { fg = c.diag.error },
    OverseerTask       = { fg = c.blue },
    OverseerTaskBorder = { fg = c.ui.border_float },
    OverseerOutput     = { fg = c.fg },
    OverseerComponent  = { fg = c.yellow },
    OverseerField      = { fg = c.teal },
  }
end

return M
