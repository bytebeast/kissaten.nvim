# kissaten for Helix

[kissaten.nvim](../../README.md) theme for [Helix](https://helix-editor.com), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

```sh
mkdir -p ~/.config/helix/themes   # Windows: %AppData%\helix\themes
curl -fsSL -o ~/.config/helix/themes/kissaten_evening.toml \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/helix/kissaten_evening.toml
```

Try it with `:theme kissaten_evening`, then set it at the top of `~/.config/helix/config.toml`:

```toml
theme = "kissaten_evening"
```

To follow your terminal's light and dark mode, download `kissaten_morning.toml` too and use a `[theme]` table instead:

```toml
[theme]
dark = "kissaten_evening"
light = "kissaten_morning"
```
