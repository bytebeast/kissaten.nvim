# Kissaten Afternoon for tmux
# upstream: https://github.com/bytebeast/kissaten.nvim
# In ~/.tmux.conf:  source-file ~/.config/tmux/<this file>

set -g mode-style "fg=#cdd5f6,bg=#3c4767"
set -g message-style "fg=#cdd5f6,bg=#31354b"
set -g message-command-style "fg=#cdd5f6,bg=#31354b"
set -g pane-border-style "fg=#3c4159"
set -g pane-active-border-style "fg=#84a8f8"
set -g popup-border-style "fg=#84a8f8"
set -g display-panes-colour "#4a506b"
set -g display-panes-active-colour "#84a8f8"
set -g clock-mode-colour "#84a8f8"

set -g status "on"
set -g status-justify "left"
set -g status-style "fg=#b0b9dd,bg=#212435"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left "#[fg=#1a1c2a,bg=#84a8f8,bold] #S #[fg=#84a8f8,bg=#212435,nobold] "
set -g status-right "#[fg=#8890b6,bg=#212435] %Y-%m-%d  %H:%M #[fg=#1a1c2a,bg=#c6a0f6,bold] #h "

setw -g window-status-separator ""
setw -g window-status-style "fg=#8890b6,bg=#212435"
setw -g window-status-format " #I #W#{?window_zoomed_flag, ,} "
setw -g window-status-current-format "#[fg=#84a8f8,bg=#31354b,bold] #I #W#{?window_zoomed_flag, ,} "
setw -g window-status-activity-style "fg=#f3a06c,bg=#212435"
setw -g window-status-bell-style "fg=#ef8aa6,bg=#212435"
