# Kissaten Graveyard for tmux
# upstream: https://github.com/bytebeast/kissaten.nvim
# In ~/.tmux.conf:  source-file ~/.config/tmux/<this file>

set -g mode-style "fg=#bfc7e6,bg=#252e46"
set -g message-style "fg=#bfc7e6,bg=#171827"
set -g message-command-style "fg=#bfc7e6,bg=#171827"
set -g pane-border-style "fg=#23253b"
set -g pane-active-border-style "fg=#739aee"
set -g popup-border-style "fg=#739aee"
set -g display-panes-colour "#30344f"
set -g display-panes-active-colour "#739aee"
set -g clock-mode-colour "#739aee"

set -g status "on"
set -g status-justify "left"
set -g status-style "fg=#a1a9cd,bg=#050507"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left "#[fg=#000000,bg=#739aee,bold] #S #[fg=#739aee,bg=#050507,nobold] "
set -g status-right "#[fg=#7479a1,bg=#050507] %Y-%m-%d  %H:%M #[fg=#000000,bg=#b392ee,bold] #h "

setw -g window-status-separator ""
setw -g window-status-style "fg=#7479a1,bg=#050507"
setw -g window-status-format " #I #W#{?window_zoomed_flag, ,} "
setw -g window-status-current-format "#[fg=#739aee,bg=#171827,bold] #I #W#{?window_zoomed_flag, ,} "
setw -g window-status-activity-style "fg=#f09a62,bg=#050507"
setw -g window-status-bell-style "fg=#ea83a0,bg=#050507"
