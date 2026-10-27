local M = {}

M.url = "https://github.com/petertriho/nvim-scrollbar"

--- nvim-scrollbar rewrites these groups itself unless `set_highlights = false`
--- (its default derives them from kissaten's diagnostic and git groups, which
--- also looks right); with it off, these exact colors are used.
---@type kissaten.HighlightsFn
function M.get(c)
  local hl = {
    ScrollbarHandle = { bg = c.surface1 },
    ScrollbarCursor = { fg = c.subtext },
    ScrollbarCursorHandle = { fg = c.subtext, bg = c.surface1 },
  }
  for name, color in pairs({
    Error = c.diag.error,
    Warn = c.diag.warn,
    Info = c.diag.info,
    Hint = c.diag.hint,
    Search = c.orange,
    Misc = c.purple,
    GitAdd = c.git.add,
    GitChange = c.git.change,
    GitDelete = c.git.delete,
  }) do
    hl["Scrollbar" .. name] = { fg = color }
    hl["Scrollbar" .. name .. "Handle"] = { fg = color, bg = c.surface1 }
  end
  return hl
end

return M
