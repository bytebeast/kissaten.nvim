# kissaten for fish

[kissaten.nvim](../../README.md) theme for [fish](https://fishshell.com), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Needs fish 3.4 or newer.

```sh
mkdir -p ~/.config/fish/themes
curl -fsSL -o ~/.config/fish/themes/kissaten_evening.theme \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/fish/kissaten_evening.theme
```

Try it in the current shell:

```fish
fish_config theme choose kissaten_evening
```

To keep it, put that line in `~/.config/fish/config.fish`. `fish_config theme save kissaten_evening` also works, but stores the colors as universal variables instead.
