local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/milanglacier/minuet-ai.nvim"

--- AI suggestions look like every other ghost text (copilot, completion
--- preview); minuet's "duet" edit previews use the diff colors.
---@type kissaten.HighlightsFn
function M.get(c)
  local g = c.git
  -- stylua: ignore
  return {
    MinuetVirtualText      = { fg = c.comment, italic = true },
    MinuetDuetAdd          = { bg = c.diff.add },
    MinuetDuetDelete       = { fg = Util.blend(g.delete, c.bg, 0.6), bg = c.diff.delete, strikethrough = true },
    MinuetDuetComment      = { fg = c.comment, italic = true },
    MinuetDuetCursor       = "Cursor",
    CmpItemKindMinuet      = { fg = c.teal },
    BlinkCmpItemKindMinuet = { fg = c.teal },
    BlinkCmpKindMinuet     = { fg = c.teal },
    LspKindMinuet          = { fg = c.teal },
  }
end

return M
