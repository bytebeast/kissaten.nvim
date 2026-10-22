# Kissaten Morning for tmux
# upstream: https://github.com/bytebeast/kissaten.nvim
# In ~/.tmux.conf:  source-file ~/.config/tmux/<this file>

set -g mode-style "fg=#353a5c,bg=#cbd6f2"
set -g message-style "fg=#353a5c,bg=#e2e5ee"
set -g message-command-style "fg=#353a5c,bg=#e2e5ee"
set -g pane-border-style "fg=#d3d8e5"
set -g pane-active-border-style "fg=#2a5fe0"
set -g popup-border-style "fg=#2a5fe0"
set -g display-panes-colour "#c2c9dc"
set -g display-panes-active-colour "#2a5fe0"
set -g clock-mode-colour "#2a5fe0"

set -g status "on"
set -g status-justify "left"
set -g status-style "fg=#4f5578,bg=#e0e4ee"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left "#[fg=#d4d8e4,bg=#2a5fe0,bold] #S #[fg=#2a5fe0,bg=#e0e4ee,nobold] "
set -g status-right "#[fg=#686f8e,bg=#e0e4ee] %Y-%m-%d  %H:%M #[fg=#d4d8e4,bg=#7c3aed,bold] #h "

setw -g window-status-separator ""
setw -g window-status-style "fg=#686f8e,bg=#e0e4ee"
setw -g window-status-format " #I #W#{?window_zoomed_flag, ,} "
setw -g window-status-current-format "#[fg=#2a5fe0,bg=#e2e5ee,bold] #I #W#{?window_zoomed_flag, ,} "
setw -g window-status-activity-style "fg=#b25000,bg=#e0e4ee"
setw -g window-status-bell-style "fg=#c8153c,bg=#e0e4ee"
