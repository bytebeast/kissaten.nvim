local M = {}

M.url = "https://github.com/stevearc/aerial.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  local hl = {
    AerialNormal = { fg = c.ui.fg_sidebar, bg = c.ui.bg_sidebar },
    AerialGuide = { fg = c.ui.indent },
    AerialLine = "QuickFixLine",
  }
  require("kissaten.groups.lsp").kind_groups(hl, "Aerial%sIcon")
  return hl
end

return M
