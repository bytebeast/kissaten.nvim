---@mod kissaten.lualine Lualine theme builder
local Util = require("kissaten.util")

local M = {}

---@param style? kissaten.Style
function M.theme(style)
  local opts = require("kissaten.config").extend()
  local c = require("kissaten").colors(style)
  local bold = opts.lualine_bold and "bold" or nil
  local bg = opts.transparent and "NONE" or c.mantle

  local function mode(color)
    return {
      a = { fg = c.crust, bg = color, gui = bold },
      b = { fg = color, bg = Util.blend(color, c.surface0, 0.15) },
      c = { fg = c.subtext, bg = bg },
    }
  end

  return {
    normal = mode(c.blue),
    insert = mode(c.green),
    visual = mode(c.purple),
    replace = mode(c.red),
    command = mode(c.orange),
    terminal = mode(c.teal),
    inactive = {
      a = { fg = c.comment, bg = bg },
      b = { fg = c.comment, bg = bg },
      c = { fg = c.comment, bg = bg },
    },
  }
end

return M
