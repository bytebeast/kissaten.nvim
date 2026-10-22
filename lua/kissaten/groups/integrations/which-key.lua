local M = {}

M.url = "https://github.com/folke/which-key.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    WhichKey          = { fg = c.cyan },
    WhichKeyGroup     = { fg = c.blue },
    WhichKeyDesc      = { fg = c.fg },
    WhichKeySeparator = { fg = c.overlay0 },
    WhichKeyValue     = { fg = c.comment },
    WhichKeyNormal    = { bg = c.ui.bg_float },
    WhichKeyBorder    = "FloatBorder",
    WhichKeyTitle     = "FloatTitle",
    WhichKeyIcon      = { fg = c.lavender },
  }
end

return M
