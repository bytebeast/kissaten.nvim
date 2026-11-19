-- Termux: save as ~/.termux/colors.properties, then `termux-reload-settings`.
-- Keys from termux-app TerminalColorScheme.updateWith(); anything else is
-- rejected.
local M = {}

---@param c kissaten.Colors
function M.generate(c)
  local out = {
    ("# %s for Termux"):format(c._display),
    "# upstream: " .. c._upstream,
    "foreground=" .. c.fg,
    "background=" .. c.bg,
    "cursor=" .. c.fg,
  }
  for i, color in ipairs(require("kissaten.extras").ansi(c)) do
    out[#out + 1] = ("color%d=%s"):format(i - 1, color)
  end
  return table.concat(out, "\n") .. "\n"
end

return M
