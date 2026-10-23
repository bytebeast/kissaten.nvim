local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/folke/sidekick.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    SidekickDiffContext = { bg = c.diff.change },
    SidekickDiffAdd     = { bg = Util.tint(c.git.add, c.bg, 0.3) },
    SidekickDiffDelete  = { bg = Util.tint(c.git.delete, c.bg, 0.3) },
    SidekickSignAdd     = { fg = c.git.add },
    SidekickSignChange  = { fg = c.git.change },
    SidekickSignDelete  = { fg = c.git.delete },
  }
end

return M
