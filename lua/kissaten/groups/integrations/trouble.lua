local M = {}

M.url = "https://github.com/folke/trouble.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    TroubleNormal      = { fg = c.ui.fg_sidebar, bg = c.ui.bg_sidebar },
    TroubleNormalNC    = { fg = c.ui.fg_sidebar, bg = c.ui.bg_sidebar },
    TroubleText        = { fg = c.fg },
    TroubleCount       = { fg = c.purple, bg = c.surface1 },
    TroublePos         = { fg = c.comment },
    TroubleFilename    = { fg = c.blue },
    TroubleDirectory   = { fg = c.lavender },
    TroubleIndent      = { fg = c.ui.indent },
    TroubleIndentFoldClosed = { fg = c.orange },
    TroubleIndentFoldOpen   = { fg = c.overlay0 },
    TroubleSource      = { fg = c.comment },
    TroubleCode        = { fg = c.comment },
  }
end

return M
