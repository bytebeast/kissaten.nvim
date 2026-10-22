local M = {}

M.url = "https://github.com/sindrets/diffview.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  local g = c.git
  -- stylua: ignore
  return {
    DiffviewNormal            = { fg = c.ui.fg_sidebar, bg = c.ui.bg_sidebar },
    DiffviewWinSeparator      = { fg = c.crust, bg = c.ui.bg_sidebar },
    DiffviewDim1              = { fg = c.overlay0 },
    DiffviewPrimary           = { fg = c.blue },
    DiffviewSecondary         = { fg = c.purple },
    DiffviewFilePanelTitle    = { fg = c.blue, bold = true },
    DiffviewFilePanelCounter  = { fg = c.orange },
    DiffviewFilePanelRootPath = { fg = c.lavender, bold = true },
    DiffviewFilePanelFileName = { fg = c.fg },
    DiffviewFilePanelSelected = { fg = c.yellow },
    DiffviewFilePanelPath     = { fg = c.comment },
    DiffviewFilePanelInsertions = { fg = g.add },
    DiffviewFilePanelDeletions = { fg = g.delete },
    DiffviewFilePanelConflicts = { fg = g.conflict },
    DiffviewFolderName        = { fg = c.blue },
    DiffviewFolderSign        = { fg = c.blue },
    DiffviewHash              = { fg = c.pink },
    DiffviewReference         = { fg = c.teal, bold = true },
    DiffviewReflogSelector    = { fg = c.pink },
    DiffviewStatusAdded       = { fg = g.add },
    DiffviewStatusUntracked   = { fg = g.untracked },
    DiffviewStatusModified    = { fg = g.change },
    DiffviewStatusRenamed     = { fg = g.change },
    DiffviewStatusCopied      = { fg = g.change },
    DiffviewStatusTypeChange  = { fg = g.change },
    DiffviewStatusUnmerged    = { fg = g.conflict },
    DiffviewStatusUnknown     = { fg = c.red },
    DiffviewStatusDeleted     = { fg = g.delete },
    DiffviewStatusBroken      = { fg = c.red },
    DiffviewStatusIgnored     = { fg = g.ignore },
  }
end

return M
