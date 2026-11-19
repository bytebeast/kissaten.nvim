# kissaten for Ghostty

[kissaten.nvim](../../README.md) theme for [Ghostty](https://ghostty.org), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

```sh
mkdir -p ~/.config/ghostty/themes
curl -fsSL -o ~/.config/ghostty/themes/kissaten_evening \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/ghostty/kissaten_evening
```

Then in Ghostty's config:

```ini
theme = kissaten_evening
```

To follow your system's light and dark mode, download `kissaten_morning` too and use:

```ini
theme = light:kissaten_morning,dark:kissaten_evening
```
