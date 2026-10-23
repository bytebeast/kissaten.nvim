# kissaten for bat

[kissaten.nvim](../../README.md) theme for [bat](https://github.com/sharkdp/bat), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

The theme is built from the same syntax roles as the Neovim theme, so code in `bat` is colored the way it is in your editor. bat names a theme after its file.

```sh
mkdir -p "$(bat --config-dir)/themes"
curl -fsSL -o "$(bat --config-dir)/themes/kissaten_evening.tmTheme" \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/bat/kissaten_evening.tmTheme
bat cache --build
bat --list-themes | grep kissaten
```

Then in bat's config file (`bat --config-file` prints where it is):

```sh
--theme="kissaten_evening"
--italic-text=always   # bat turns italics off by default; kissaten italicizes comments and keywords
```

bat 0.25+ can switch with your terminal's light/dark mode instead: download `kissaten_morning.tmTheme` too, then use `--theme-light="kissaten_morning"` and `--theme-dark="kissaten_evening"` in place of `--theme`.
