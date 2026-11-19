# kissaten for zathura

[kissaten.nvim](../../README.md) theme for [zathura](https://pwmt.org/projects/zathura/), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

```sh
mkdir -p ~/.config/zathura
curl -fsSL -o ~/.config/zathura/kissaten_evening.zathurarc \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/zathura/kissaten_evening.zathurarc
```

Then in `~/.config/zathura/zathurarc` (relative paths resolve from that file):

```sh
include kissaten_evening.zathurarc
```

The theme colors zathura's interface. To render pages in the theme's colors too, press `Ctrl+r` or add `set recolor true`.
