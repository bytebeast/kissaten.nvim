local M = {}

M.url = "https://codeberg.org/andyg/leap.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    LeapMatch    = { fg = c.pink, bold = true, nocombine = true },
    LeapLabel    = { fg = c.ui.on_badge, bg = c.pink, bold = true },
    LeapBackdrop = { fg = c.overlay0 },
  }
end

return M
