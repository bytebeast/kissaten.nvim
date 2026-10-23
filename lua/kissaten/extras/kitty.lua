local M = {}

---@param c kissaten.Colors
function M.generate(c)
  return require("kissaten.extras").template(
    [[
# vim:ft=kitty
## name: ${_display}
## upstream: ${_upstream}

foreground ${fg}
background ${bg}
selection_foreground ${fg}
selection_background ${ui.bg_visual}
cursor ${fg}
cursor_text_color ${bg}
url_color ${teal}

active_border_color ${blue}
inactive_border_color ${surface1}
bell_border_color ${yellow}

active_tab_foreground ${ui.on_badge}
active_tab_background ${blue}
inactive_tab_foreground ${comment}
inactive_tab_background ${mantle}
tab_bar_background ${crust}

mark1_foreground ${ui.on_badge}
mark1_background ${blue}
mark2_foreground ${ui.on_badge}
mark2_background ${purple}
mark3_foreground ${ui.on_badge}
mark3_background ${teal}

color0  ${terminal.black}
color8  ${terminal.black_bright}
color1  ${terminal.red}
color9  ${terminal.red_bright}
color2  ${terminal.green}
color10 ${terminal.green_bright}
color3  ${terminal.yellow}
color11 ${terminal.yellow_bright}
color4  ${terminal.blue}
color12 ${terminal.blue_bright}
color5  ${terminal.magenta}
color13 ${terminal.magenta_bright}
color6  ${terminal.cyan}
color14 ${terminal.cyan_bright}
color7  ${terminal.white}
color15 ${terminal.white_bright}
color16 ${orange}
color17 ${red}
]],
    c
  )
end

return M
