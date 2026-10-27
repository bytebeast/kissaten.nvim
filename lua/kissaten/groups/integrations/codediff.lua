local M = {}

M.url = "https://github.com/esmuellert/codediff.nvim"

--- codediff derives its line and character diff colors from DiffAdd/DiffDelete
--- on every :colorscheme (they already follow this theme); these are the
--- groups it leaves to the colorscheme: signs, explorer, status and help.
---@type kissaten.HighlightsFn
function M.get(c)
  local g, ui = c.git, c.ui
  -- stylua: ignore
  return {
    CodeDiffGutterInsert          = { fg = g.add, bg = c.diff.add },
    CodeDiffGutterDelete          = { fg = g.delete, bg = c.diff.delete },
    CodeDiffGutterInsertNumber    = { fg = g.add },
    CodeDiffGutterDeleteNumber    = { fg = g.delete },
    CodeDiffMoveFrom              = { fg = c.purple },
    CodeDiffMoveTo                = { fg = c.purple },
    CodeDiffFiller                = { fg = c.surface2 },
    CodeDiffExplorerSelected      = { bg = ui.bg_sel },
    CodeDiffExplorerTreeGroup     = { fg = c.blue },
    CodeDiffStatusAdded           = { fg = g.add },
    CodeDiffStatusModified        = { fg = g.change },
    CodeDiffStatusDeleted         = { fg = g.delete },
    CodeDiffStatusRenamed         = { fg = g.change },
    CodeDiffStatusUntracked       = { fg = g.untracked },
    CodeDiffStatusConflict        = { fg = g.conflict },
    CodeDiffExplorerStatFiles     = { fg = c.orange },
    CodeDiffExplorerStatInsertions = { fg = g.add },
    CodeDiffExplorerStatDeletions = { fg = g.delete },
    CodeDiffExplorerStatBinary    = { fg = c.comment },
    CodeDiffConflictSign          = { fg = g.conflict },
    CodeDiffConflictSignResolved  = { fg = c.comment },
    CodeDiffConflictSignAccepted  = { fg = g.add },
    CodeDiffConflictSignRejected  = { fg = g.delete },
    CodeDiffHistoryTitle          = { fg = ui.title, bold = true },
    CodeDiffHelpHeader            = { fg = ui.title, bold = true },
    CodeDiffHelpSection           = { fg = c.purple, bold = true },
    CodeDiffHelpKey               = { fg = c.orange },
    CodeDiffHelpSep               = { fg = c.overlay0 },
    CodeDiffHelpDesc              = { fg = c.fg },
    CodeDiffWelcomeLogo           = { fg = ui.accent },
    CodeDiffWelcomeKey            = { fg = c.orange },
    ExplorerDirectorySmall        = { fg = c.comment },
  }
end

return M
