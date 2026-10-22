local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/rcarriga/nvim-notify"

---@type kissaten.HighlightsFn
function M.get(c, opts)
  local bg = opts.transparent and c.none or c.ui.bg_float
  local hl = { NotifyBackground = { fg = c.fg, bg = bg } }
  for name, color in pairs({
    ERROR = c.diag.error,
    WARN = c.diag.warn,
    INFO = c.diag.info,
    DEBUG = c.comment,
    TRACE = c.purple,
  }) do
    hl["Notify" .. name .. "Border"] = { fg = Util.blend(color, c.bg, 0.5), bg = bg }
    hl["Notify" .. name .. "Icon"] = { fg = color }
    hl["Notify" .. name .. "Title"] = { fg = color, bold = true }
    hl["Notify" .. name .. "Body"] = { fg = c.fg, bg = bg }
  end
  return hl
end

return M
