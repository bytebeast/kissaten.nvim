local Util = require("kissaten.util")

local M = {}

---@param c kissaten.Colors
function M.generate(c)
  local t = vim.deepcopy(c)
  t._key = "kissaten-" .. c.style
  t._light = c.light and "true" or "false"
  t._minus_emph = Util.blend(c.red, c.bg, 0.35)
  t._plus_emph = Util.blend(c.green, c.bg, 0.35)
  return require("kissaten.extras").template(
    [=[
# ${_display} for delta
# upstream: ${_upstream}
# In ~/.gitconfig:
#   [include]
#     path = /path/to/this/file
#   [delta]
#     features = ${_key}

[delta "${_key}"]
  dark = ${_light}
  light = ${_light}
  syntax-theme = none
  file-style = "${blue}" bold
  file-decoration-style = "${surface2}" ul
  hunk-header-style = file line-number syntax
  hunk-header-decoration-style = "${surface2}" box
  hunk-header-line-number-style = "${orange}"
  line-numbers = true
  line-numbers-left-style = "${surface2}"
  line-numbers-right-style = "${surface2}"
  line-numbers-zero-style = "${comment}"
  line-numbers-minus-style = "${red}"
  line-numbers-plus-style = "${green}"
  minus-style = syntax "${diff.delete}"
  minus-emph-style = syntax "${_minus_emph}"
  plus-style = syntax "${diff.add}"
  plus-emph-style = syntax "${_plus_emph}"
  map-styles = bold purple => syntax "${surface1}", bold cyan => syntax "${surface0}"
  blame-palette = "${bg}" "${mantle}" "${surface0}"
  commit-decoration-style = "${surface2}" box ul
  zero-style = syntax
]=],
    t
  )
end

return M
