# kissaten for lazygit

[kissaten.nvim](../../README.md) theme for [lazygit](https://github.com/jesseduffield/lazygit), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

lazygit reads one `config.yml`:

- Linux: `~/.config/lazygit/config.yml`
- macOS: `~/Library/Application Support/lazygit/config.yml`
- Windows: `%LOCALAPPDATA%\lazygit\config.yml`

Copy the `gui:` block from `kissaten_evening.yml` into it. The block also sets `nerdFontsVersion: "3"`; drop that line if you don't use a Nerd Font.

Or keep the theme in its own file and let lazygit merge the two. Later files win (the paths below are for Linux; use the folder above on macOS and Windows):

```sh
curl -fsSL -o ~/.config/lazygit/kissaten_evening.yml \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/lazygit/kissaten_evening.yml
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml,$HOME/.config/lazygit/kissaten_evening.yml"
```
