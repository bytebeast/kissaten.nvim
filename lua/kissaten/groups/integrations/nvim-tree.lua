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
    -- current names (nvim-tree 1.0+); the older ones above stay for old installs
    NvimTreeGitDirtyIcon   = { fg = g.change },
    NvimTreeGitNewIcon     = { fg = g.untracked },
    NvimTreeGitDeletedIcon = { fg = g.delete },
    NvimTreeGitStagedIcon  = { fg = g.add },
    NvimTreeGitRenamedIcon = { fg = g.change },
    NvimTreeGitMergeIcon   = { fg = g.conflict },
    NvimTreeGitIgnoredIcon = { fg = g.ignore },
    NvimTreeGitFileIgnoredHL = { fg = g.ignore },
    NvimTreeGitFolderIgnoredHL = { fg = g.ignore },
    NvimTreeOpenedFolderIcon = { fg = c.blue },
    NvimTreeClosedFolderIcon = { fg = c.blue },
    NvimTreeFolderArrowOpen  = { fg = c.overlay0 },
    NvimTreeFolderArrowClosed = { fg = c.overlay0 },
    NvimTreeFileIcon       = { fg = c.ui.fg_sidebar },
    NvimTreeSymlinkIcon    = { fg = c.teal },
    NvimTreeSymlinkFolderName = { fg = c.teal },
    NvimTreeExecFile       = { fg = c.green, bold = true },
    NvimTreeOpenedHL       = { fg = c.fg, bold = true },
    NvimTreeModifiedIcon   = { fg = c.orange },
    NvimTreeBookmarkIcon   = { fg = c.pink },
    NvimTreeBookmarkHL     = { fg = c.pink },
    NvimTreeHiddenIcon     = { fg = c.comment },
    NvimTreeHiddenFileHL   = { fg = c.comment },
    NvimTreeHiddenDisplay  = { fg = c.comment, italic = true },
    NvimTreeCutHL          = { fg = c.red, strikethrough = true },
    NvimTreeCopiedHL       = { fg = c.green, underline = true },
    NvimTreeLiveFilterPrefix = { fg = c.ui.accent, bold = true },
    NvimTreeLiveFilterValue = { fg = c.fg, bold = true },
    NvimTreeWindowPicker   = { fg = c.ui.on_badge, bg = c.pink, bold = true },
    NvimTreeCursorLine     = { bg = c.ui.bg_sel },
    NvimTreeEndOfBuffer    = { fg = c.ui.bg_sidebar },
    NvimTreeSignColumn     = { bg = c.ui.bg_sidebar },
    NvimTreeLineNr         = { fg = c.ui.fg_gutter, bg = c.ui.bg_sidebar },
  }
end

return M
