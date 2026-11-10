local M = {}

M.url = "https://github.com/Bekaboo/dropbar.nvim"

--- Like nvim-navic: separators on the indent shade (dropbar links them to
--- `Comment`, which `subtle_comments` fades), kind icons from the LSP kinds.
--- Statement kinds (if/for/return) keep dropbar's links to keyword groups.
---@type kissaten.HighlightsFn
function M.get(c)
  local hl = {
    DropBarIconKindDefault = { fg = c.subtext },
    DropBarIconUISeparator = { fg = c.overlay0 },
    DropBarMenuHoverEntry = "PmenuSel",
  }
  return require("kissaten.groups.lsp").kind_groups(hl, "DropBarIconKind%s")
end

return M
