local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/romgrk/barbar.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  local hl = {}
  local states = {
    Current = { fg = c.fg, bg = c.surface1 },
    Visible = { fg = c.subtext, bg = c.mantle },
    Inactive = { fg = c.comment, bg = c.mantle },
    Alternate = { fg = c.fg, bg = c.surface0 },
  }
  for state, base in pairs(states) do
    hl["Buffer" .. state] = base
    hl["Buffer" .. state .. "Index"] = { fg = c.ui.accent, bg = base.bg }
    hl["Buffer" .. state .. "Mod"] = { fg = c.orange, bg = base.bg }
    hl["Buffer" .. state .. "Sign"] = { fg = state == "Current" and c.ui.accent or c.overlay0, bg = base.bg }
    hl["Buffer" .. state .. "SignRight"] = hl["Buffer" .. state .. "Sign"]
    hl["Buffer" .. state .. "Number"] = { fg = c.ui.accent, bg = base.bg }
    hl["Buffer" .. state .. "Icon"] = { fg = base.fg, bg = base.bg }
    hl["Buffer" .. state .. "Btn"] = { fg = state == "Current" and c.subtext or c.overlay0, bg = base.bg }
    hl["Buffer" .. state .. "ModBtn"] = { fg = c.orange, bg = base.bg }
    hl["Buffer" .. state .. "Pin"] = { fg = c.pink, bg = base.bg }
    hl["Buffer" .. state .. "PinBtn"] = { fg = c.pink, bg = base.bg }
    hl["Buffer" .. state .. "Target"] = { fg = c.red, bg = base.bg, bold = true }
    hl["Buffer" .. state .. "ERROR"] = { fg = c.diag.error, bg = base.bg }
    hl["Buffer" .. state .. "WARN"] = { fg = c.diag.warn, bg = base.bg }
    hl["Buffer" .. state .. "INFO"] = { fg = c.diag.info, bg = base.bg }
    hl["Buffer" .. state .. "HINT"] = { fg = c.diag.hint, bg = base.bg }
    hl["Buffer" .. state .. "ADDED"] = { fg = c.git.add, bg = base.bg }
    hl["Buffer" .. state .. "CHANGED"] = { fg = c.git.change, bg = base.bg }
    hl["Buffer" .. state .. "DELETED"] = { fg = c.git.delete, bg = base.bg }
  end
  hl.BufferTabpageFill = { fg = c.overlay0, bg = c.crust }
  hl.BufferTabpages = { fg = c.ui.accent, bg = c.crust, bold = true }
  hl.BufferTabpagesSep = { fg = c.overlay0, bg = c.crust }
  hl.BufferScrollArrow = { fg = c.ui.accent, bg = c.crust, bold = true }
  hl.BufferOffset = { fg = c.subtext, bg = Util.blend(c.mantle, c.crust, 0.5) }
  return hl
end

return M
