local M = {}

---@param c kissaten.Colors
function M.generate(c)
  return require("kissaten.extras").template(
    [=[
# ${_display} for Alacritty
# upstream: ${_upstream}
# In alacritty.toml:  [general] import = ["~/.config/alacritty/<this file>"]

[colors.primary]
background = "${bg}"
foreground = "${fg}"
dim_foreground = "${subtext}"

[colors.cursor]
text = "${bg}"
cursor = "${fg}"

[colors.vi_mode_cursor]
text = "${bg}"
cursor = "${blue}"

[colors.selection]
text = "CellForeground"
background = "${ui.bg_visual}"

[colors.search.matches]
foreground = "${fg}"
background = "${ui.bg_search}"

[colors.search.focused_match]
foreground = "${ui.on_badge}"
background = "${orange}"

[colors.footer_bar]
foreground = "${fg}"
background = "${mantle}"

[colors.hints.start]
foreground = "${ui.on_badge}"
background = "${pink}"

[colors.hints.end]
foreground = "${ui.on_badge}"
background = "${blue}"

[colors.normal]
black = "${terminal.black}"
red = "${terminal.red}"
green = "${terminal.green}"
yellow = "${terminal.yellow}"
blue = "${terminal.blue}"
magenta = "${terminal.magenta}"
cyan = "${terminal.cyan}"
white = "${terminal.white}"

[colors.bright]
black = "${terminal.black_bright}"
red = "${terminal.red_bright}"
green = "${terminal.green_bright}"
yellow = "${terminal.yellow_bright}"
blue = "${terminal.blue_bright}"
magenta = "${terminal.magenta_bright}"
cyan = "${terminal.cyan_bright}"
white = "${terminal.white_bright}"

[[colors.indexed_colors]]
index = 16
color = "${orange}"

[[colors.indexed_colors]]
index = 17
color = "${red}"
]=],
    c
  )
end

return M
