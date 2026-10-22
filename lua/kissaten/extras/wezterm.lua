local M = {}

---@param c kissaten.Colors
function M.generate(c)
  return require("kissaten.extras").template(
    [[
# ${_display} for WezTerm
# upstream: ${_upstream}
# Copy to ~/.config/wezterm/colors/ and set `config.color_scheme = "${_display}"`

[colors]
foreground = "${fg}"
background = "${bg}"
cursor_bg = "${fg}"
cursor_border = "${fg}"
cursor_fg = "${bg}"
selection_bg = "${ui.bg_visual}"
selection_fg = "${fg}"
split = "${surface1}"
compose_cursor = "${orange}"
scrollbar_thumb = "${surface2}"

ansi = ["${terminal.black}", "${terminal.red}", "${terminal.green}", "${terminal.yellow}", "${terminal.blue}", "${terminal.magenta}", "${terminal.cyan}", "${terminal.white}"]
brights = ["${terminal.black_bright}", "${terminal.red_bright}", "${terminal.green_bright}", "${terminal.yellow_bright}", "${terminal.blue_bright}", "${terminal.magenta_bright}", "${terminal.cyan_bright}", "${terminal.white_bright}"]

[colors.tab_bar]
background = "${crust}"
inactive_tab_edge = "${mantle}"

[colors.tab_bar.active_tab]
bg_color = "${blue}"
fg_color = "${crust}"

[colors.tab_bar.inactive_tab]
bg_color = "${mantle}"
fg_color = "${comment}"

[colors.tab_bar.inactive_tab_hover]
bg_color = "${surface0}"
fg_color = "${fg}"

[colors.tab_bar.new_tab]
bg_color = "${crust}"
fg_color = "${blue}"

[colors.tab_bar.new_tab_hover]
bg_color = "${surface0}"
fg_color = "${blue}"

[metadata]
name = "${_display}"
origin_url = "${_upstream}"
]],
    c
  )
end

return M
