local M = {}

M.url = "https://github.com/stevearc/oil.nvim"

--- oil links hidden files and link targets to `Comment`, which
--- `subtle_comments` fades toward the background: use the UI comment color
--- instead. Preview actions follow the git roles, so `colorblind` applies.
---@type kissaten.HighlightsFn
function M.get(c)
  local g = c.git
  -- stylua: ignore
  return {
    OilHidden           = { fg = c.comment },
    OilEmpty            = { fg = c.comment },
    OilLinkTarget       = { fg = c.comment },
    OilTrashSourcePath  = { fg = c.comment },
    OilLink             = { fg = c.teal },
    OilOrphanLink       = { fg = c.diag.error },
    OilCreate           = { fg = g.add },
    OilDelete           = { fg = g.delete },
    OilMove             = { fg = g.change },
  }
end

return M
