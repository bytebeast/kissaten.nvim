# kissaten for tmux

[kissaten.nvim](../../README.md) theme for [tmux](https://github.com/tmux/tmux), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

The theme styles panes, messages, copy mode and the status line, including `status-left` and `status-right`. Remove other status line themes first, or source this file after them.

```sh
mkdir -p ~/.config/tmux
curl -fsSL -o ~/.config/tmux/kissaten_evening.tmux \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/tmux/kissaten_evening.tmux
```

Then in `~/.tmux.conf` (or `~/.config/tmux/tmux.conf`):

```sh
source-file ~/.config/tmux/kissaten_evening.tmux
# colored undercurls and underlines in Neovim (tmux 3.2+)
set -as terminal-features ",*:usstyle"
```

Reload with `tmux source-file ~/.tmux.conf`.
