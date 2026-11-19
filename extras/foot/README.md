# kissaten for foot

[kissaten.nvim](../../README.md) theme for [foot](https://codeberg.org/dnkl/foot), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Needs foot 1.26 or newer (the files use its `[colors-dark]` and `[colors-light]` sections).

```sh
mkdir -p ~/.config/foot
curl -fsSL -o ~/.config/foot/kissaten_evening.ini \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/foot/kissaten_evening.ini
```

Then at the top of `~/.config/foot/foot.ini`, before any section header:

```ini
include=~/.config/foot/kissaten_evening.ini
```

`morning` fills `[colors-light]`. To use it, add `initial-color-theme=light` under `[main]`. Include a dark style and `morning` together to switch between them with foot's `color-theme-toggle` key binding.
