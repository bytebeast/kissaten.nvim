-- X resources for xterm, URxvt and other X terminals:
-- `xrdb -merge kissaten_evening.Xresources`, or #include it in ~/.Xresources.
local M = {}

---@param c kissaten.Colors
function M.generate(c)
  local out = {
    ("! %s for X terminals"):format(c._display),
    "! upstream: " .. c._upstream,
    "",
    "*.foreground: " .. c.fg,
    "*.background: " .. c.bg,
    "*.cursorColor: " .. c.fg,
  }
  for i, color in ipairs(require("kissaten.extras").ansi(c)) do
    out[#out + 1] = ("*.color%d: %s"):format(i - 1, color)
  end
  return table.concat(out, "\n") .. "\n"
end

return M
