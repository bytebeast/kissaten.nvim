local M = {}

M.url = "https://github.com/lukas-reineke/indent-blankline.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    IblIndent                   = { fg = c.ui.indent, nocombine = true },
    IblWhitespace               = { fg = c.ui.indent, nocombine = true },
    IblScope                    = { fg = c.ui.indent_scope, nocombine = true },
    IndentBlanklineChar         = { fg = c.ui.indent, nocombine = true },
    IndentBlanklineContextChar  = { fg = c.ui.indent_scope, nocombine = true },
  }
end

return M
