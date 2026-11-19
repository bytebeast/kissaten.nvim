# kissaten for Zed

[kissaten.nvim](../../README.md) theme for [Zed](https://zed.dev), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

```sh
mkdir -p ~/.config/zed/themes   # Windows: %USERPROFILE%\AppData\Roaming\Zed\themes
curl -fsSL -o ~/.config/zed/themes/kissaten_evening.json \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/zed/kissaten_evening.json
```

Pick **Kissaten Evening** in the theme selector (`cmd-k cmd-t`, or `ctrl-k ctrl-t` on Linux and Windows). To follow your system's light and dark mode, download `kissaten_morning.json` too and set it in `settings.json`:

```json
"theme": {
  "mode": "system",
  "light": "Kissaten Morning",
  "dark": "Kissaten Evening"
}
```
