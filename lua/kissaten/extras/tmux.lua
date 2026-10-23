local M = {}

---@param c kissaten.Colors
function M.generate(c)
  local t = vim.deepcopy(c)
  -- current window: a raised tab on dark styles; on the light style the
  -- paper itself, where blue keeps AA contrast
  t._cur_bg = c.light and c.bg or c.surface0
  return require("kissaten.extras").template(
    [[
# ${_display} for tmux
# upstream: ${_upstream}
# In ~/.tmux.conf:  source-file ~/.config/tmux/<this file>

set -g mode-style "fg=${fg},bg=${ui.bg_visual}"
set -g message-style "fg=${fg},bg=${surface0}"
set -g message-command-style "fg=${fg},bg=${surface0}"
set -g pane-border-style "fg=${surface1}"
set -g pane-active-border-style "fg=${blue}"
set -g popup-border-style "fg=${blue}"
set -g display-panes-colour "${surface2}"
set -g display-panes-active-colour "${blue}"
set -g clock-mode-colour "${blue}"

set -g status "on"
set -g status-justify "left"
set -g status-style "fg=${subtext},bg=${mantle}"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left "#[fg=${ui.on_badge},bg=${blue},bold] #S #[fg=${blue},bg=${mantle},nobold] "
set -g status-right "#[fg=${comment},bg=${mantle}] %Y-%m-%d  %H:%M #[fg=${ui.on_badge},bg=${purple},bold] #h "

setw -g window-status-separator ""
setw -g window-status-style "fg=${comment},bg=${mantle}"
setw -g window-status-format " #I #W#{?window_zoomed_flag, ,} "
setw -g window-status-current-format "#[fg=${blue},bg=${_cur_bg},bold] #I #W#{?window_zoomed_flag, ,} "
setw -g window-status-activity-style "fg=${orange},bg=${mantle}"
setw -g window-status-bell-style "fg=${red},bg=${mantle}"
]],
    t
  )
end

return M
