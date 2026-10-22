local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/lewis6991/gitsigns.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  local g = c.git
  -- stylua: ignore
  return {
    GitSignsAdd              = { fg = g.add },
    GitSignsChange           = { fg = g.change },
    GitSignsDelete           = { fg = g.delete },
    GitSignsChangedelete     = { fg = g.conflict },
    GitSignsTopdelete        = { fg = g.delete },
    GitSignsUntracked        = { fg = g.untracked },
    GitSignsStagedAdd        = { fg = Util.blend(g.add, c.bg, 0.5) },
    GitSignsStagedChange     = { fg = Util.blend(g.change, c.bg, 0.5) },
    GitSignsStagedDelete     = { fg = Util.blend(g.delete, c.bg, 0.5) },
    GitSignsStagedChangedelete = { fg = Util.blend(g.conflict, c.bg, 0.5) },
    GitSignsStagedTopdelete  = { fg = Util.blend(g.delete, c.bg, 0.5) },
    GitSignsAddNr            = { fg = g.add },
    GitSignsChangeNr         = { fg = g.change },
    GitSignsDeleteNr         = { fg = g.delete },
    GitSignsAddInline        = { bg = Util.blend(g.add, c.bg, 0.3) },
    GitSignsChangeInline     = { bg = Util.blend(g.change, c.bg, 0.3) },
    GitSignsDeleteInline     = { bg = Util.blend(g.delete, c.bg, 0.3) },
    GitSignsAddPreview       = "DiffAdd",
    GitSignsDeletePreview    = "DiffDelete",
    GitSignsDeleteVirtLn     = "DiffDelete",
    GitSignsCurrentLineBlame = { fg = c.comment, italic = true },
  }
end

return M
