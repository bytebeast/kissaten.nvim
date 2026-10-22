local M = {}

M.url = "https://github.com/MagicDuck/grug-far.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    GrugFarHelpHeader             = { fg = c.comment },
    GrugFarHelpHeaderKey          = { fg = c.orange },
    GrugFarInputLabel             = { fg = c.blue, bold = true },
    GrugFarInputPlaceholder       = { fg = c.overlay0, italic = true },
    GrugFarResultsChangeIndicator = { fg = c.git.change },
    GrugFarResultsHeader          = { fg = c.purple, bold = true },
    GrugFarResultsLineColumn      = { fg = c.comment },
    GrugFarResultsLineNo          = { fg = c.comment },
    GrugFarResultsMatch           = { fg = c.crust, bg = c.orange },
    GrugFarResultsMatchAdded      = { fg = c.crust, bg = c.green },
    GrugFarResultsMatchRemoved    = { fg = c.crust, bg = c.red },
    GrugFarResultsPath            = { fg = c.blue },
    GrugFarResultsStats           = { fg = c.lavender },
  }
end

return M
