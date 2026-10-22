local M = {}

M.url = "https://github.com/zbirenbaum/copilot.lua"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    CopilotSuggestion   = { fg = c.comment, italic = true },
    CopilotAnnotation   = { fg = c.comment, italic = true },
    SupermavenSuggestion = { fg = c.comment, italic = true },
    CodeiumSuggestion   = { fg = c.comment, italic = true },
  }
end

return M
