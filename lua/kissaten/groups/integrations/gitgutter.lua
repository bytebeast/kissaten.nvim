local M = {}

M.url = "https://github.com/airblade/vim-gitgutter"

---@type kissaten.HighlightsFn
function M.get(c)
  local g = c.git
  -- stylua: ignore
  return {
    GitGutterAdd          = { fg = g.add },
    GitGutterChange       = { fg = g.change },
    GitGutterDelete       = { fg = g.delete },
    GitGutterAddLineNr    = { fg = g.add },
    GitGutterChangeLineNr = { fg = g.change },
    GitGutterDeleteLineNr = { fg = g.delete },
  }
end

return M
