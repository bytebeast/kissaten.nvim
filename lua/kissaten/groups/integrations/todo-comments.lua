local M = {}

M.url = "https://github.com/folke/todo-comments.nvim"

--- todo-comments builds its groups from its own `colors` option (which
--- defaults to DiagnosticError/Warn/Info/Hint, so it already follows this
--- theme). We only style its sign column icons to sit quietly in the gutter.
---@type kissaten.HighlightsFn
function M.get(c)
  local function kw(name, color)
    return {
      ["TodoSign" .. name] = { fg = color },
    }
  end
  local hl = {}
  for name, color in pairs({
    TODO = c.blue,
    FIX = c.diag.error,
    HACK = c.diag.warn,
    WARN = c.diag.warn,
    PERF = c.purple,
    NOTE = c.diag.hint,
    TEST = c.teal,
  }) do
    hl = vim.tbl_extend("force", hl, kw(name, color))
  end
  return hl
end

return M
