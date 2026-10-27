local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/akinsho/git-conflict.nvim"

--- "ours" (current) is the git add hue and "theirs" (incoming) is orange; the
--- common ancestor (diff3 style) is neutral grey. Orange was picked by
--- measurement: it stays apart from the add hue, the ancestor, the editor and
--- the visual selection on every style, with and without `colorblind` (the
--- tests check this under simulated color vision deficiency). Labels (the
--- <<<<<<< / >>>>>>> lines) are a step deeper.
---@type kissaten.HighlightsFn
function M.get(c)
  local alpha = c.light and 0.2 or 0.17
  local function side(name, color)
    return {
      ["GitConflict" .. name] = { bg = Util.tint(color, c.bg, alpha) },
      ["GitConflict" .. name .. "Label"] = { fg = c.fg, bg = Util.tint(color, c.bg, alpha * 2), bold = true },
    }
  end
  return vim.tbl_extend("force", side("Current", c.git.add), side("Incoming", c.orange), {
    GitConflictAncestor = { bg = c.surface2 },
    GitConflictAncestorLabel = { fg = c.fg, bg = c.surface2, bold = true },
  })
end

return M
