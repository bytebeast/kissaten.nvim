local M = {}

---@param c kissaten.Colors
function M.generate(c)
  return require("kissaten.extras").template(
    [[
# ${_display} for lazygit
# upstream: ${_upstream}
# Merge into ~/.config/lazygit/config.yml (or point LG_CONFIG_FILE at both files)

gui:
  nerdFontsVersion: "3"
  theme:
    activeBorderColor:
      - "${blue}"
      - bold
    inactiveBorderColor:
      - "${surface2}"
    searchingActiveBorderColor:
      - "${orange}"
      - bold
    optionsTextColor:
      - "${blue}"
    selectedLineBgColor:
      - "${surface0}"
    inactiveViewSelectedLineBgColor:
      - "${surface0}"
    cherryPickedCommitFgColor:
      - "${pink}"
    cherryPickedCommitBgColor:
      - "${surface1}"
    markedBaseCommitFgColor:
      - "${yellow}"
    markedBaseCommitBgColor:
      - "${surface1}"
    unstagedChangesColor:
      - "${red}"
    defaultFgColor:
      - "${fg}"
  authorColors:
    "*": "${lavender}"
]],
    c
  )
end

return M
