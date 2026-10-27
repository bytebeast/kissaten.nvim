local M = {}

M.url = "https://github.com/lukas-reineke/virt-column.nvim"

--- A thin line the color of indent guides. virt-column's own default draws
--- with `NonText`; set `highlight = "VirtColumn"` to use this group.
---@type kissaten.HighlightsFn
function M.get(c)
  return {
    VirtColumn = { fg = c.ui.indent },
  }
end

return M
