local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/NeogitOrg/neogit"

---@type kissaten.HighlightsFn
function M.get(c)
  local g = c.git
  -- stylua: ignore
  local hl = {
    NeogitBranch               = { fg = c.purple, bold = true },
    NeogitBranchHead           = { fg = c.purple, bold = true, underline = true },
    NeogitRemote               = { fg = c.pink, bold = true },
    NeogitObjectId             = { fg = c.comment },
    NeogitStash                = { fg = c.comment },
    NeogitFold                 = { fg = c.overlay0 },
    NeogitFilePath             = { fg = c.blue, italic = true },
    NeogitSectionHeader        = { fg = c.purple, bold = true },
    NeogitUnstagedchanges      = { fg = c.purple, bold = true },
    NeogitStagedchanges        = { fg = c.purple, bold = true },
    NeogitUntrackedfiles       = { fg = c.purple, bold = true },
    NeogitUnmergedchanges      = { fg = c.purple, bold = true },
    NeogitUnpulledchanges      = { fg = c.purple, bold = true },
    NeogitRecentcommits        = { fg = c.purple, bold = true },
    NeogitHunkHeader           = { fg = c.subtext, bg = c.surface0 },
    NeogitHunkHeaderHighlight  = { fg = c.blue, bg = c.surface1, bold = true },
    NeogitDiffContext          = { bg = c.mantle },
    NeogitDiffContextHighlight = { bg = c.surface0 },
    NeogitDiffAdd              = { fg = g.add, bg = c.diff.add },
    NeogitDiffAddHighlight     = { fg = g.add, bg = Util.tint(g.add, c.bg, 0.24) },
    NeogitDiffDelete           = { fg = g.delete, bg = c.diff.delete },
    NeogitDiffDeleteHighlight  = { fg = g.delete, bg = Util.tint(g.delete, c.bg, 0.24) },
    NeogitDiffHeader           = { fg = c.blue, bg = c.surface0, bold = true },
    NeogitDiffHeaderHighlight  = { fg = c.orange, bg = c.surface1, bold = true },
    NeogitChangeModified       = { fg = g.change, bold = true },
    NeogitChangeAdded          = { fg = g.add, bold = true },
    NeogitChangeDeleted        = { fg = g.delete, bold = true },
    NeogitChangeRenamed        = { fg = c.purple, bold = true },
    NeogitChangeUpdated        = { fg = c.orange, bold = true },
    NeogitChangeCopied         = { fg = c.cyan, bold = true },
    NeogitChangeNewFile        = { fg = g.add, bold = true },
    NeogitChangeUnmerged       = { fg = g.conflict, bold = true },
    NeogitPopupSectionTitle    = { fg = c.blue, bold = true },
    NeogitPopupActionKey       = { fg = c.orange },
    NeogitPopupOptionKey       = { fg = c.orange },
    NeogitPopupSwitchKey       = { fg = c.orange },
    NeogitPopupConfigKey       = { fg = c.orange },
    NeogitPopupBold            = { bold = true },
    NeogitNotificationInfo     = { fg = c.diag.info },
    NeogitNotificationWarning  = { fg = c.diag.warn },
    NeogitNotificationError    = { fg = c.diag.error },
    NeogitTagName              = { fg = c.yellow },
    NeogitTagDistance          = { fg = c.cyan },
  }
  for name, color in pairs({
    Red = c.red,
    Orange = c.orange,
    Yellow = c.yellow,
    Green = c.green,
    Cyan = c.cyan,
    Blue = c.blue,
    Purple = c.purple,
    Gray = c.overlay0,
    White = c.fg,
  }) do
    hl["NeogitGraph" .. name] = { fg = color }
    hl["NeogitGraphBold" .. name] = { fg = color, bold = true }
  end
  return hl
end

return M
