local M = {}

M.url = "https://github.com/lewis6991/hover.nvim"

--- The hover float matches every other float; the source tabs along its top
--- look like the tabline.
---@type kissaten.HighlightsFn
function M.get(c)
  local ui = c.ui
  -- stylua: ignore
  return {
    HoverWindow         = { fg = c.fg, bg = ui.bg_float },
    HoverBorder         = { fg = ui.border_float, bg = ui.bg_float },
    HoverSourceLine     = { fg = c.comment, bg = c.mantle },
    HoverActiveSource   = { fg = ui.on_badge, bg = ui.accent, bold = true },
    HoverInactiveSource = { fg = c.comment, bg = c.mantle },
    HoverFloatingError  = "DiagnosticFloatingError",
    HoverFloatingWarn   = "DiagnosticFloatingWarn",
    HoverFloatingInfo   = "DiagnosticFloatingInfo",
    HoverFloatingHint   = "DiagnosticFloatingHint",
  }
end

return M
