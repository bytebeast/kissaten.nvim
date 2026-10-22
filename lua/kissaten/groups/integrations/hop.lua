local M = {}

M.url = "https://github.com/smoka7/hop.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    HopNextKey   = { fg = c.pink, bold = true },
    HopNextKey1  = { fg = c.cyan, bold = true },
    HopNextKey2  = { fg = c.blue },
    HopUnmatched = { fg = c.overlay0 },
  }
end

return M
