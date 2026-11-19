# kissaten for btop

[kissaten.nvim](../../README.md) theme for [btop](https://github.com/aristocratos/btop), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

btop looks for user themes in `$XDG_CONFIG_HOME/btop/themes`, which is usually `~/.config/btop/themes`:

```sh
mkdir -p ~/.config/btop/themes
curl -fsSL -o ~/.config/btop/themes/kissaten_evening.theme \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/btop/kissaten_evening.theme
```

Then in `~/.config/btop/btop.conf`:

```sh
color_theme = "kissaten_evening"
```

Or pick it from the options menu (`o` or `F2`) under color theme.
