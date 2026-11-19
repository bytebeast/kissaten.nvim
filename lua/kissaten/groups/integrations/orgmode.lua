local M = {}

M.url = "https://github.com/nvim-orgmode/orgmode"

--- orgmode copies these from Error/WarningMsg/diffAdded and lightens them,
--- which costs contrast on the light style. Everything else links to
--- treesitter groups.
---@type kissaten.HighlightsFn
function M.get(c)
  local d = c.diag
  -- stylua: ignore
  return {
    ["@org.agenda.deadline"]          = { fg = d.error },
    ["@org.agenda.deadline.upcoming"] = { fg = d.warn },
    ["@org.agenda.scheduled"]         = { fg = d.ok },
    ["@org.agenda.scheduled_past"]    = { fg = d.warn },
    ["@org.agenda.time_grid"]         = { fg = d.warn },
    ["@org.keyword.todo"]             = { fg = d.error, bold = true },
    ["@org.keyword.done"]             = { fg = d.ok, bold = true },
  }
end

return M
