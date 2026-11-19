# kissaten for Xresources

[kissaten.nvim](../../README.md) theme for X terminals that read X resources (xterm, URxvt and others), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

```sh
mkdir -p ~/.config/xresources
curl -fsSL -o ~/.config/xresources/kissaten_evening.Xresources \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/xresources/kissaten_evening.Xresources
xrdb -merge ~/.config/xresources/kissaten_evening.Xresources
```

To load it at every login, include it from `~/.Xresources` (xrdb runs it through the C preprocessor, so `#include` works):

```c
#include ".config/xresources/kissaten_evening.Xresources"
```

Terminals pick up the colors when they start, so open a new window.
