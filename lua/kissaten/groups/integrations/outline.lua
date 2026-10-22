local M = {}

M.url = "https://github.com/hedyhli/outline.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    OutlineCurrent  = { fg = c.orange, bold = true },
    OutlineGuides   = { fg = c.ui.indent },
    OutlineFoldMarker = { fg = c.overlay0 },
    OutlineDetails  = { fg = c.comment },
    OutlineLineno   = { fg = c.ui.fg_gutter },
  }
end

return M
