# kissaten for Zellij

[kissaten.nvim](../../README.md) theme for [Zellij](https://zellij.dev), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Needs Zellij 0.42 or newer (the files use its named-style theme format).

```sh
mkdir -p ~/.config/zellij/themes
curl -fsSL -o ~/.config/zellij/themes/kissaten_evening.kdl \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/zellij/kissaten_evening.kdl
```

Then in `~/.config/zellij/config.kdl`:

```kdl
theme "kissaten_evening"
```

Zellij 0.44.2+ can follow your terminal's light and dark mode: download `kissaten_morning.kdl` too and set both:

```kdl
theme_dark "kissaten_evening"
theme_light "kissaten_morning"
```
