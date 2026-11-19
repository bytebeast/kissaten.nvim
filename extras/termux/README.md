# kissaten for Termux

[kissaten.nvim](../../README.md) theme for [Termux](https://termux.dev), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

```sh
mkdir -p ~/.termux
curl -fsSL -o ~/.termux/colors.properties \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/termux/kissaten_evening.properties
termux-reload-settings
```

This replaces any colors you set before, including ones chosen with Termux:Styling.
