local M = {}

M.url = "https://github.com/nvim-neo-tree/neo-tree.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  local g = c.git
  -- stylua: ignore
  return {
    NeoTreeNormal              = { fg = c.ui.fg_sidebar, bg = c.ui.bg_sidebar },
    NeoTreeNormalNC            = { fg = c.ui.fg_sidebar, bg = c.ui.bg_sidebar },
    NeoTreeDirectoryName       = { fg = c.blue },
    NeoTreeDirectoryIcon       = { fg = c.blue },
    NeoTreeRootName            = { fg = c.purple, bold = true },
    NeoTreeFileName            = { fg = c.ui.fg_sidebar },
    NeoTreeFileNameOpened      = { fg = c.fg, bold = true },
    NeoTreeExpander            = { fg = c.overlay0 },
    NeoTreeIndentMarker        = { fg = c.ui.indent },
    NeoTreeSymbolicLinkTarget  = { fg = c.teal },
    NeoTreeModified            = { fg = c.orange },
    NeoTreeDimText             = { fg = c.overlay0 },
    NeoTreeDotfile             = { fg = c.comment },
    NeoTreeHiddenByName        = { fg = c.comment },
    NeoTreeFilterTerm          = { fg = c.orange, bold = true },
    NeoTreeGitAdded            = { fg = g.add },
    NeoTreeGitModified         = { fg = g.change },
    NeoTreeGitDeleted          = { fg = g.delete },
    NeoTreeGitConflict         = { fg = g.conflict, bold = true },
    NeoTreeGitIgnored          = { fg = g.ignore },
    NeoTreeGitStaged           = { fg = g.add },
    NeoTreeGitUnstaged         = { fg = g.change },
    NeoTreeGitUntracked        = { fg = g.untracked },
    NeoTreeFloatBorder         = "FloatBorder",
    NeoTreeFloatTitle          = "FloatTitle",
    NeoTreeTitleBar            = { fg = c.ui.on_badge, bg = c.ui.accent },
    NeoTreeWinSeparator        = { fg = c.ui.bg_sidebar == c.none and c.ui.border or c.crust, bg = c.ui.bg_sidebar },
    NeoTreeTabActive           = { fg = c.ui.accent, bg = c.ui.bg_sidebar, bold = true },
    NeoTreeTabInactive         = { fg = c.comment, bg = c.crust },
    NeoTreeTabSeparatorActive  = { fg = c.ui.bg_sidebar, bg = c.ui.bg_sidebar },
    NeoTreeTabSeparatorInactive = { fg = c.crust, bg = c.crust },
  }
end

return M
