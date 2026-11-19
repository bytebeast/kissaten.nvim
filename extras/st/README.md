# kissaten for st

[kissaten.nvim](../../README.md) theme for [st](https://st.suckless.org), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

st is configured at compile time. Each file holds st's `colorname[]` array and the four `default*` lines that pick the foreground, background and cursor colors.

```sh
curl -fsSL -o kissaten_evening.txt \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/st/kissaten_evening.txt
```

In st's `config.h`, replace `colorname[]` and the `defaultfg`, `defaultbg`, `defaultcs` and `defaultrcs` lines with the file's contents (or `#include "kissaten_evening.txt"` in their place), then rebuild:

```sh
sudo make clean install
```

Patches that change `colorname[]` (alpha, xresources) may need these values moved into their own format.
