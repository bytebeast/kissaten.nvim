# Kissaten Midnight for tmux
# upstream: https://github.com/bytebeast/kissaten.nvim
# In ~/.tmux.conf:  source-file ~/.config/tmux/<this file>

set -g mode-style "fg=#c8d0f0,bg=#2c354f"
set -g message-style "fg=#c8d0f0,bg=#1f2030"
set -g message-command-style "fg=#c8d0f0,bg=#1f2030"
set -g pane-border-style "fg=#2a2c42"
set -g pane-active-border-style "fg=#7aa2f7"
set -g popup-border-style "fg=#7aa2f7"
set -g display-panes-colour "#363a56"
set -g display-panes-active-colour "#7aa2f7"
set -g clock-mode-colour "#7aa2f7"

set -g status "on"
set -g status-justify "left"
set -g status-style "fg=#a9b1d6,bg=#111118"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left "#[fg=#0c0c12,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#111118,nobold] "
set -g status-right "#[fg=#7a80a8,bg=#111118] %Y-%m-%d  %H:%M #[fg=#0c0c12,bg=#bb9af7,bold] #h "

setw -g window-status-separator ""
setw -g window-status-style "fg=#7a80a8,bg=#111118"
setw -g window-status-format " #I #W#{?window_zoomed_flag, ,} "
setw -g window-status-current-format "#[fg=#7aa2f7,bg=#1f2030,bold] #I #W#{?window_zoomed_flag, ,} "
setw -g window-status-activity-style "fg=#f9a26a,bg=#111118"
setw -g window-status-bell-style "fg=#f38ba8,bg=#111118"
