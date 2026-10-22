local M = {}

M.url = "https://github.com/j-hui/fidget.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    FidgetTitle = { fg = c.blue, bold = true },
    FidgetTask  = { fg = c.comment },
  }
end

return M
