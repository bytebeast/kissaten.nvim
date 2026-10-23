local M = {}

M.url = "https://github.com/HiPhish/rainbow-delimiters.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  local b = c.brackets -- follows the `rainbow` option
  -- stylua: ignore
  return {
    RainbowDelimiterRed    = { fg = b.red },
    RainbowDelimiterOrange = { fg = b.orange },
    RainbowDelimiterYellow = { fg = b.yellow },
    RainbowDelimiterGreen  = { fg = b.green },
    RainbowDelimiterBlue   = { fg = b.blue },
    RainbowDelimiterViolet = { fg = b.violet },
    RainbowDelimiterCyan   = { fg = b.cyan },
  }
end

return M
