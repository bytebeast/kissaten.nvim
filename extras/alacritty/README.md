# kissaten for Alacritty

[kissaten.nvim](../../README.md) theme for [Alacritty](https://alacritty.org), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

```sh
mkdir -p ~/.config/alacritty
curl -fsSL -o ~/.config/alacritty/kissaten_evening.toml \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/alacritty/kissaten_evening.toml
```

Then in `alacritty.toml`:

```toml
[general]
import = ["~/.config/alacritty/kissaten_evening.toml"]
```

Alacritty before 0.14 reads `import` at the top level instead of under `[general]`.
