local M = {}

M.url = "https://github.com/MagicDuck/grug-far.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    GrugFarHelpHeader             = { fg = c.comment },
    GrugFarHelpHeaderKey          = { fg = c.orange },
    GrugFarInputLabel             = { fg = c.ui.accent, bold = true },
    GrugFarInputPlaceholder       = { fg = c.overlay0, italic = true },
    GrugFarResultsChangeIndicator = { fg = c.git.change },
    GrugFarResultsHeader          = { fg = c.purple, bold = true },
    GrugFarResultsLineColumn      = { fg = c.comment },
    GrugFarResultsLineNo          = { fg = c.comment },
    GrugFarResultsMatch           = { fg = c.ui.on_badge, bg = c.orange },
    GrugFarResultsMatchAdded      = { fg = c.ui.on_badge, bg = c.git.add },
    GrugFarResultsMatchRemoved    = { fg = c.ui.on_badge, bg = c.git.delete },
    GrugFarResultsPath            = { fg = c.blue },
    GrugFarResultsStats           = { fg = c.lavender },
  }
end

return M
