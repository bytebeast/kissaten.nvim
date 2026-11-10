# Kissaten Morning for tmux
# upstream: https://github.com/bytebeast/kissaten.nvim
# In ~/.tmux.conf:  source-file ~/.config/tmux/<this file>

set -g mode-style "fg=#353a5c,bg=#c8d3ef"
set -g message-style "fg=#353a5c,bg=#e2e5ee"
set -g message-command-style "fg=#353a5c,bg=#e2e5ee"
set -g pane-border-style "fg=#d3d8e5"
set -g pane-active-border-style "fg=#1d4fcf"
set -g popup-border-style "fg=#1d4fcf"
set -g display-panes-colour "#c2c9dc"
set -g display-panes-active-colour "#1d4fcf"
set -g clock-mode-colour "#1d4fcf"

set -g status "on"
set -g status-justify "left"
set -g status-style "fg=#4f5578,bg=#e0e4ee"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left "#[fg=#eef0f6,bg=#1d4fcf,bold] #S #[fg=#1d4fcf,bg=#e0e4ee,nobold] "
set -g status-right "#[fg=#686f8e,bg=#e0e4ee] %Y-%m-%d  %H:%M #[fg=#eef0f6,bg=#7128df,bold] #h "

setw -g window-status-separator ""
setw -g window-status-style "fg=#686f8e,bg=#e0e4ee"
setw -g window-status-format " #I #W#{?window_zoomed_flag, ,} "
setw -g window-status-current-format "#[fg=#1d4fcf,bg=#eef0f6,bold] #I #W#{?window_zoomed_flag, ,} "
setw -g window-status-activity-style "fg=#9c3c00,bg=#e0e4ee"
setw -g window-status-bell-style "fg=#b7002f,bg=#e0e4ee"
