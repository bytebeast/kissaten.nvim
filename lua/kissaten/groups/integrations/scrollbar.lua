local M = {}

M.url = "https://github.com/petertriho/nvim-scrollbar"

---@type kissaten.HighlightsFn
function M.get(c)
  local hl = { ScrollbarHandle = { bg = c.surface1 } }
  for name, color in pairs({
    Error = c.diag.error,
    Warn = c.diag.warn,
    Info = c.diag.info,
    Hint = c.diag.hint,
    Search = c.orange,
    Misc = c.purple,
  }) do
    hl["Scrollbar" .. name] = { fg = color }
    hl["Scrollbar" .. name .. "Handle"] = { fg = color, bg = c.surface1 }
  end
  return hl
end

return M
