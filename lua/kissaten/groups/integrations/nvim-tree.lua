local M = {}

M.url = "https://github.com/nvim-tree/nvim-tree.lua"

---@type kissaten.HighlightsFn
function M.get(c)
  local g = c.git
  -- stylua: ignore
  return {
    NvimTreeNormal         = { fg = c.ui.fg_sidebar, bg = c.ui.bg_sidebar },
    NvimTreeNormalNC       = { fg = c.ui.fg_sidebar, bg = c.ui.bg_sidebar },
    NvimTreeWinSeparator   = { fg = c.crust, bg = c.ui.bg_sidebar },
    NvimTreeRootFolder     = { fg = c.purple, bold = true },
    NvimTreeFolderName     = { fg = c.blue },
    NvimTreeFolderIcon     = { fg = c.blue },
    NvimTreeOpenedFolderName = { fg = c.blue, bold = true },
    NvimTreeEmptyFolderName = { fg = c.comment },
    NvimTreeIndentMarker   = { fg = c.ui.indent },
    NvimTreeOpenedFile     = { fg = c.fg, bold = true },
    NvimTreeSpecialFile    = { fg = c.pink, underline = true },
    NvimTreeImageFile      = { fg = c.subtext },
    NvimTreeSymlink        = { fg = c.teal },
    NvimTreeGitDirty       = { fg = g.change },
    NvimTreeGitNew         = { fg = g.add },
    NvimTreeGitDeleted     = { fg = g.delete },
    NvimTreeGitStaged      = { fg = g.add },
    NvimTreeGitIgnored     = { fg = g.ignore },
  }
end

return M
