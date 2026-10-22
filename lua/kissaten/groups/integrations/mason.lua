local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/mason-org/mason.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    MasonNormal                   = "NormalFloat",
    MasonHeader                   = { fg = c.crust, bg = c.blue, bold = true },
    MasonHeaderSecondary          = { fg = c.crust, bg = c.orange, bold = true },
    MasonHeading                  = { fg = c.fg, bold = true },
    MasonHighlight                = { fg = c.green },
    MasonHighlightBlock           = { fg = c.crust, bg = c.green },
    MasonHighlightBlockBold       = { fg = c.crust, bg = c.green, bold = true },
    MasonHighlightSecondary       = { fg = c.orange },
    MasonHighlightBlockSecondary  = { fg = c.crust, bg = c.orange },
    MasonHighlightBlockBoldSecondary = { fg = c.crust, bg = c.orange, bold = true },
    MasonLink                     = { fg = c.teal, underline = true },
    MasonMuted                    = { fg = c.comment },
    MasonMutedBlock               = { fg = c.subtext, bg = c.surface0 },
    MasonMutedBlockBold           = { fg = c.subtext, bg = c.surface0, bold = true },
    MasonError                    = { fg = c.red },
    MasonWarning                  = { fg = c.yellow },
    MasonBackdrop                 = { bg = Util.blend(c.crust, c.bg, 0.6) },
  }
end

return M
