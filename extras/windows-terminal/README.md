# kissaten for Windows Terminal

[kissaten.nvim](../../README.md) theme for [Windows Terminal](https://github.com/microsoft/terminal), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Each file is one color scheme object.

1. Open **Settings**, then **Open JSON file** at the bottom left.
2. Paste the contents of [`kissaten_evening.json`](https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/windows-terminal/kissaten_evening.json) into the `"schemes"` array (add a comma after the previous scheme).
3. Use it for every profile:

```json
"profiles": {
  "defaults": {
    "colorScheme": "Kissaten Evening"
  }
}
```

Or pick **Kissaten Evening** under a profile's **Appearance → Color scheme**.
