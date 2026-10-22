local M = {}

M.url = "https://github.com/nvim-neotest/neotest"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    NeotestPassed       = { fg = c.diag.ok },
    NeotestFailed       = { fg = c.diag.error },
    NeotestRunning      = { fg = c.yellow },
    NeotestSkipped      = { fg = c.overlay0 },
    NeotestUnknown      = { fg = c.comment },
    NeotestWatching     = { fg = c.orange },
    NeotestTest         = { fg = c.ui.fg_sidebar },
    NeotestNamespace    = { fg = c.lavender },
    NeotestFocused      = { bold = true, underline = true },
    NeotestFile         = { fg = c.blue },
    NeotestDir          = { fg = c.blue },
    NeotestIndent       = { fg = c.ui.indent },
    NeotestExpandMarker = { fg = c.overlay0 },
    NeotestAdapterName  = { fg = c.purple, bold = true },
    NeotestWinSelect    = { fg = c.orange, bold = true },
    NeotestMarked       = { fg = c.pink, bold = true },
    NeotestTarget       = { fg = c.red },
    NeotestBorder       = { fg = c.ui.border_float },
  }
end

return M
