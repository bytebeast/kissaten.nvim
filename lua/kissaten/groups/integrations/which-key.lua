local M = {}

M.url = "https://github.com/folke/which-key.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    WhichKey          = { fg = c.cyan },
    WhichKeyGroup     = { fg = c.ui.accent },
    WhichKeyDesc      = { fg = c.fg },
    WhichKeySeparator = { fg = c.overlay0 },
    WhichKeyValue     = { fg = c.comment },
    WhichKeyNormal    = { bg = c.ui.bg_float },
    WhichKeyBorder    = "FloatBorder",
    WhichKeyTitle     = "FloatTitle",
    WhichKeyIcon      = { fg = c.lavender },
    -- per-mapping icon colors, the same as mini.icons uses
    WhichKeyIconAzure  = { fg = c.blue },
    WhichKeyIconBlue   = { fg = c.lavender },
    WhichKeyIconCyan   = { fg = c.cyan },
    WhichKeyIconGreen  = { fg = c.green },
    WhichKeyIconGrey   = { fg = c.subtext },
    WhichKeyIconOrange = { fg = c.orange },
    WhichKeyIconPurple = { fg = c.purple },
    WhichKeyIconRed    = { fg = c.red },
    WhichKeyIconYellow = { fg = c.yellow },
  }
end

return M
