local M = {}

M.url = "https://github.com/folke/flash.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    FlashBackdrop = { fg = c.overlay0 },
    FlashMatch    = { fg = c.fg, bg = c.surface2 },
    FlashCurrent  = { fg = c.ui.on_badge, bg = c.orange },
    -- labels are the one thing you must find instantly: brightest color on the screen
    FlashLabel    = { fg = c.ui.on_badge, bg = c.pink, bold = true },
    FlashPrompt   = { fg = c.fg, bg = c.mantle },
    FlashPromptIcon = { fg = c.pink },
  }
end

return M
