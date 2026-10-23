local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/pwntester/octo.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  local function pill(color)
    return { fg = color, bg = Util.tint(color, c.bg, 0.14), bold = true }
  end
  -- stylua: ignore
  return {
    OctoDetailsLabel          = { fg = c.blue, bold = true },
    OctoDetailsValue          = { fg = c.subtext },
    OctoDirty                 = { fg = c.orange, bold = true },
    OctoIssueTitle            = { fg = c.purple, bold = true },
    OctoStateOpen             = pill(c.diag.ok),
    OctoStateClosed           = pill(c.diag.error),
    OctoStateMerged           = pill(c.purple),
    OctoStatePending          = pill(c.yellow),
    OctoStateChangesRequested = pill(c.orange),
    OctoStatusColumn          = { fg = c.blue },
  }
end

return M
