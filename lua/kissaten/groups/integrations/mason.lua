local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/mason-org/mason.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    MasonNormal                   = "NormalFloat",
    MasonHeader                   = { fg = c.ui.on_badge, bg = c.ui.accent, bold = true },
    MasonHeaderSecondary          = { fg = c.ui.on_badge, bg = c.orange, bold = true },
    MasonHeading                  = { fg = c.fg, bold = true },
    MasonHighlight                = { fg = c.green },
    MasonHighlightBlock           = { fg = c.ui.on_badge, bg = c.green },
    MasonHighlightBlockBold       = { fg = c.ui.on_badge, bg = c.green, bold = true },
    MasonHighlightSecondary       = { fg = c.orange },
    MasonHighlightBlockSecondary  = { fg = c.ui.on_badge, bg = c.orange },
    MasonHighlightBlockBoldSecondary = { fg = c.ui.on_badge, bg = c.orange, bold = true },
    MasonLink                     = { fg = c.teal, underline = true },
    MasonMuted                    = { fg = c.comment },
    MasonMutedBlock               = { fg = c.subtext, bg = c.surface0 },
    MasonMutedBlockBold           = { fg = c.subtext, bg = c.surface0, bold = true },
    MasonError                    = { fg = c.diag.error },
    MasonWarning                  = { fg = c.diag.warn },
    MasonBackdrop                 = { bg = Util.blend(c.crust, c.bg, 0.6) },
  }
end

return M
