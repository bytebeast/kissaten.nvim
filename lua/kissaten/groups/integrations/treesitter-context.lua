local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/nvim-treesitter/nvim-treesitter-context"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    TreesitterContext            = { bg = Util.blend(c.surface0, c.bg, 0.8) },
    TreesitterContextLineNumber  = { fg = c.ui.fg_gutter, bg = Util.blend(c.surface0, c.bg, 0.8) },
    TreesitterContextBottom      = { underline = true, sp = c.surface2 },
    TreesitterContextSeparator   = { fg = c.surface2 },
  }
end

return M
