-- k9s skin (https://k9scli.io/topics/skins/). Keys follow k9s's Style structs
-- (internal/config/styles.go); the test suite checks every key against them.
-- Variants: "default" paints kissaten backgrounds, "transparent" uses the
-- terminal's own background ("default" is k9s's terminal-default color).
local M = {}

---@param c kissaten.Colors
---@param variant "default"|"transparent"
function M.generate(c, variant)
  local t = vim.deepcopy(c)
  local clear = variant == "transparent"
  t._bg = clear and "default" or c.bg
  t._bg_alt = clear and "default" or c.mantle
  t._variant = clear and " (transparent)" or ""
  t._skin = "kissaten_" .. c.style .. (clear and "_transparent" or "")
  -- k9s inverts the selected row: its background becomes the row's status
  -- color (fg, blue, green, red, ...) and its text uses cursorFgColor, so the
  -- cursor text must be the background tone that contrasts most with all of them.
  t._cursor_fg = c.light and c.bg or c.crust
  return require("kissaten.extras").template(
    [[
# ${_display}${_variant} for k9s
# upstream: ${_upstream}
# Copy to the k9s skins directory, then set `k9s.ui.skin: ${_skin}`
# in k9s's config.yaml.
#   Linux:  ~/.config/k9s/skins/
#   macOS:  ~/Library/Application Support/k9s/skins/
#   or run `k9s info` to print the skins directory k9s actually uses

k9s:
  body:
    fgColor: "${fg}"
    bgColor: "${_bg}"
    logoColor: "${purple}"
    logoColorMsg: "${fg}"
    logoColorInfo: "${blue}"
    logoColorWarn: "${yellow}"
    logoColorError: "${red}"
  prompt:
    fgColor: "${fg}"
    bgColor: "${_bg_alt}"
    suggestColor: "${comment}"
    border:
      command: "${blue}"
      default: "${teal}"
  help:
    fgColor: "${fg}"
    bgColor: "${_bg}"
    sectionColor: "${green}"
    keyColor: "${blue}"
    numKeyColor: "${orange}"
  frame:
    title:
      fgColor: "${blue}"
      bgColor: "${_bg}"
      highlightColor: "${pink}"
      counterColor: "${yellow}"
      filterColor: "${green}"
    border:
      fgColor: "${surface2}"
      focusColor: "${blue}"
    menu:
      fgColor: "${subtext}"
      keyColor: "${blue}"
      numKeyColor: "${orange}"
    crumbs:
      fgColor: "${ui.on_badge}"
      bgColor: "${lavender}"
      activeColor: "${blue}"
    status:
      newColor: "${blue}"
      modifyColor: "${lavender}"
      addColor: "${green}"
      pendingColor: "${orange}"
      errorColor: "${red}"
      highlightColor: "${cyan}"
      killColor: "${purple}"
      completedColor: "${comment}"
  info:
    fgColor: "${orange}"
    sectionColor: "${fg}"
    cpuColor: "${purple}"
    memColor: "${yellow}"
    k9sRevColor: "${green}"
  views:
    table:
      fgColor: "${fg}"
      bgColor: "${_bg}"
      cursorFgColor: "${_cursor_fg}"
      cursorBgColor: "${fg}"
      markColor: "${pink}"
      header:
        fgColor: "${yellow}"
        bgColor: "${_bg}"
        sorterColor: "${cyan}"
        selectedSortColumnColor: "${orange}"
    xray:
      fgColor: "${fg}"
      bgColor: "${_bg}"
      cursorColor: "${blue}"
      cursorTextColor: "${_cursor_fg}"
      graphicColor: "${purple}"
    charts:
      bgColor: "${_bg}"
      chartBgColor: "${_bg}"
      dialBgColor: "${_bg}"
      focusFgColor: "${fg}"
      focusBgColor: "${surface1}"
      defaultDialColors:
        - "${green}"
        - "${red}"
      defaultChartColors:
        - "${green}"
        - "${red}"
      resourceColors:
        cpu:
          - "${purple}"
          - "${blue}"
        mem:
          - "${yellow}"
          - "${orange}"
    yaml:
      keyColor: "${teal}"
      valueColor: "${fg}"
      colonColor: "${subtext}"
    picker:
      mainColor: "${fg}"
      focusColor: "${blue}"
      shortcutColor: "${orange}"
    logs:
      fgColor: "${fg}"
      bgColor: "${_bg}"
      indicator:
        fgColor: "${lavender}"
        bgColor: "${_bg}"
        toggleOnColor: "${green}"
        toggleOffColor: "${comment}"
  dialog:
    fgColor: "${fg}"
    bgColor: "${_bg_alt}"
    buttonFgColor: "${fg}"
    buttonBgColor: "${surface1}"
    buttonFocusFgColor: "${ui.on_badge}"
    buttonFocusBgColor: "${blue}"
    labelFgColor: "${orange}"
    fieldFgColor: "${fg}"
]],
    t
  )
end

return M
