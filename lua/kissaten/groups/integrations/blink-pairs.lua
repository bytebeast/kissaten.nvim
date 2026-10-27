local M = {}

M.url = "https://github.com/saghen/blink.pairs"

--- Rainbow pairs share colors with rainbow-delimiters (and follow `rainbow`).
--- blink.pairs uses three groups by default; the other four are here for a
--- longer `highlights.groups` list.
---@type kissaten.HighlightsFn
function M.get(c)
  local b = c.brackets
  -- stylua: ignore
  return {
    BlinkPairs           = { fg = c.syn.punct },
    BlinkPairsOrange     = { fg = b.orange },
    BlinkPairsPurple     = { fg = b.violet },
    BlinkPairsBlue       = { fg = b.blue },
    BlinkPairsRed        = { fg = b.red },
    BlinkPairsYellow     = { fg = b.yellow },
    BlinkPairsGreen      = { fg = b.green },
    BlinkPairsCyan       = { fg = b.cyan },
    BlinkPairsUnmatched  = { fg = c.diag.error, undercurl = true, sp = c.diag.error },
    BlinkPairsMatchParen = "MatchParen",
  }
end

return M
