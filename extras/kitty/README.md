# kissaten for kitty

[kissaten.nvim](../../README.md) theme for [kitty](https://sw.kovidgoyal.net/kitty/), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Put the file in kitty's `themes` folder so the theme kitten lists it:

```sh
mkdir -p ~/.config/kitty/themes
curl -fsSL -o ~/.config/kitty/themes/kissaten_evening.conf \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/kitty/kissaten_evening.conf
```

Then run `kitten themes` and pick **Kissaten Evening**. kitty 0.38+ asks at the end whether to save it for dark, light or no-preference mode, so you can pair `evening` with `morning` and follow your OS.

Or skip the kitten and include the file from `kitty.conf`:

```sh
include themes/kissaten_evening.conf
```
