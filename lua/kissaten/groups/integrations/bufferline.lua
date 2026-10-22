local M = {}

M.url = "https://github.com/akinsho/bufferline.nvim"

--- bufferline derives most colors from Normal/TabLine; we only tune accents.
---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    BufferLineIndicatorSelected = { fg = c.blue },
    BufferLineModifiedSelected  = { fg = c.green },
    BufferLineDuplicateSelected = { fg = c.comment, italic = true },
  }
end

return M
