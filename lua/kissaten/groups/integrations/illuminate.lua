local M = {}

M.url = "https://github.com/RRethy/vim-illuminate"

---@type kissaten.HighlightsFn
function M.get()
  -- stylua: ignore
  return {
    IlluminatedWordText  = "LspReferenceText",
    IlluminatedWordRead  = "LspReferenceRead",
    IlluminatedWordWrite = "LspReferenceWrite",
    illuminatedWord      = "LspReferenceText",
    illuminatedCurWord   = "LspReferenceText",
  }
end

return M
