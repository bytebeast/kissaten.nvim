# Kissaten Evening for tmux
# upstream: https://github.com/bytebeast/kissaten.nvim
# In ~/.tmux.conf:  source-file ~/.config/tmux/<this file>

set -g mode-style "fg=#cad3f5,bg=#353f60"
set -g message-style "fg=#cad3f5,bg=#272a40"
set -g message-command-style "fg=#cad3f5,bg=#272a40"
set -g pane-border-style "fg=#323650"
set -g pane-active-border-style "fg=#82aaff"
set -g popup-border-style "fg=#82aaff"
set -g display-panes-colour "#3f4463"
set -g display-panes-active-colour "#82aaff"
set -g clock-mode-colour "#82aaff"

set -g status "on"
set -g status-justify "left"
set -g status-style "fg=#aeb7dc,bg=#191a2a"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left "#[fg=#13141f,bg=#82aaff,bold] #S #[fg=#82aaff,bg=#191a2a,nobold] "
set -g status-right "#[fg=#7f87b0,bg=#191a2a] %Y-%m-%d  %H:%M #[fg=#13141f,bg=#c3a6ff,bold] #h "

setw -g window-status-separator ""
setw -g window-status-style "fg=#7f87b0,bg=#191a2a"
setw -g window-status-format " #I #W#{?window_zoomed_flag, ,} "
setw -g window-status-current-format "#[fg=#82aaff,bg=#272a40,bold] #I #W#{?window_zoomed_flag, ,} "
setw -g window-status-activity-style "fg=#f7a46f,bg=#191a2a"
setw -g window-status-bell-style "fg=#f28fad,bg=#191a2a"
