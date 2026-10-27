local M = {}

M.url = "https://github.com/folke/trouble.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  local hl = {
    TroubleBasename    = { fg = c.fg },
    TroubleIconDirectory = { fg = c.lavender },
    TroublePreview     = { bg = c.ui.bg_visual },
    TroubleIndentTop   = "TroubleIndent",
    TroubleIndentMiddle = "TroubleIndent",
    TroubleIndentLast  = "TroubleIndent",
    TroubleIndentWs    = "TroubleIndent",
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
  -- symbol icons match the code they stand for
  return require("kissaten.groups.lsp").kind_groups(hl, "TroubleIcon%s")
end

return M
