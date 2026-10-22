local M = {}

M.url = "https://github.com/nvimdev/dashboard-nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    DashboardHeader          = { fg = c.blue },
    DashboardFooter          = { fg = c.comment, italic = true },
    DashboardDesc            = { fg = c.fg },
    DashboardKey             = { fg = c.orange, bold = true },
    DashboardIcon            = { fg = c.cyan },
    DashboardShortCut        = { fg = c.cyan },
    DashboardShortCutIcon    = { fg = c.purple },
    DashboardProjectTitle    = { fg = c.purple, bold = true },
    DashboardProjectTitleIcon = { fg = c.orange },
    DashboardProjectIcon     = { fg = c.yellow },
    DashboardMruTitle        = { fg = c.purple, bold = true },
    DashboardMruIcon         = { fg = c.yellow },
    DashboardFiles           = { fg = c.subtext },
  }
end

return M
