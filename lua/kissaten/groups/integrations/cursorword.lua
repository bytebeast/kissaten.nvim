local M = {}

M.url = "https://github.com/xiyaowong/nvim-cursorword"

--- Same look as LSP references, so every word-under-cursor plugin agrees.
---@type kissaten.HighlightsFn
function M.get()
  return {
    CursorWord = "LspReferenceText",
  }
end

return M
