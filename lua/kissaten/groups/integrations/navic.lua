local M = {}

M.url = "https://github.com/SmiteshP/nvim-navic"

---@type kissaten.HighlightsFn
function M.get(c)
  local hl = {
    NavicText = { fg = c.subtext },
    NavicSeparator = { fg = c.overlay0 },
  }
  return require("kissaten.groups.lsp").kind_groups(hl, "NavicIcons%s")
end

return M
