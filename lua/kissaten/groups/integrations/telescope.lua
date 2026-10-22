local M = {}

M.url = "https://github.com/nvim-telescope/telescope.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  local fbg = c.ui.bg_float
  -- stylua: ignore
  return {
    TelescopeNormal         = { fg = c.fg, bg = fbg },
    TelescopeBorder         = { fg = c.ui.border_float, bg = fbg },
    TelescopeTitle          = { fg = c.crust, bg = c.blue, bold = true },
    TelescopePromptNormal   = { fg = c.fg, bg = fbg },
    TelescopePromptBorder   = { fg = c.orange, bg = fbg },
    TelescopePromptTitle    = { fg = c.crust, bg = c.orange, bold = true },
    TelescopePromptPrefix   = { fg = c.orange, bg = fbg },
    TelescopePromptCounter  = { fg = c.comment },
    TelescopePreviewTitle   = { fg = c.crust, bg = c.green, bold = true },
    TelescopeResultsTitle   = { fg = c.crust, bg = c.blue, bold = true },
    TelescopeSelection      = { bg = c.ui.bg_sel, bold = true },
    TelescopeSelectionCaret = { fg = c.pink, bg = c.ui.bg_sel },
    TelescopeMultiSelection = { fg = c.pink },
    TelescopeMultiIcon      = { fg = c.pink },
    TelescopeMatching       = { fg = c.blue, bold = true },
    TelescopeResultsComment = { fg = c.comment },
  }
end

return M
