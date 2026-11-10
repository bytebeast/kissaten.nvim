-- Windows Terminal color scheme: one entry for the "schemes" list in
-- settings.json. The schema allows exactly these keys (SchemeList in
-- doc/cascadia/profiles.schema.json); "purple" is ANSI magenta.
local M = {}

---@param c kissaten.Colors
function M.generate(c)
  return require("kissaten.extras").template(
    [[
{
  "name": "${_display}",
  "background": "${bg}",
  "foreground": "${fg}",
  "cursorColor": "${fg}",
  "selectionBackground": "${ui.bg_visual}",
  "black": "${terminal.black}",
  "red": "${terminal.red}",
  "green": "${terminal.green}",
  "yellow": "${terminal.yellow}",
  "blue": "${terminal.blue}",
  "purple": "${terminal.magenta}",
  "cyan": "${terminal.cyan}",
  "white": "${terminal.white}",
  "brightBlack": "${terminal.black_bright}",
  "brightRed": "${terminal.red_bright}",
  "brightGreen": "${terminal.green_bright}",
  "brightYellow": "${terminal.yellow_bright}",
  "brightBlue": "${terminal.blue_bright}",
  "brightPurple": "${terminal.magenta_bright}",
  "brightCyan": "${terminal.cyan_bright}",
  "brightWhite": "${terminal.white_bright}"
}
]],
    c
  )
end

return M
