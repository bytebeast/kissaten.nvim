# kissaten for WezTerm

[kissaten.nvim](../../README.md) theme for [WezTerm](https://wezterm.org), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

WezTerm loads color schemes from the `colors` folder next to its config:

```sh
mkdir -p ~/.config/wezterm/colors
curl -fsSL -o ~/.config/wezterm/colors/kissaten_evening.toml \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/wezterm/kissaten_evening.toml
```

Then in `wezterm.lua`:

```lua
config.color_scheme = "Kissaten Evening"
```

To follow your system's light and dark mode, download `kissaten_morning.toml` too:

```lua
local function scheme(appearance)
  return appearance:find("Dark") and "Kissaten Evening" or "Kissaten Morning"
end
config.color_scheme = scheme(wezterm.gui and wezterm.gui.get_appearance() or "Dark")
```
