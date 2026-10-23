local M = {}

M.url = "https://github.com/goolord/alpha-nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    AlphaHeader      = { fg = c.ui.accent },
    AlphaHeaderLabel = { fg = c.orange },
    AlphaButtons     = { fg = c.cyan },
    AlphaShortcut    = { fg = c.orange, bold = true },
    AlphaFooter      = { fg = c.comment, italic = true },
  }
end

return M
