# kissaten for fzf

[kissaten.nvim](../../README.md) theme for [fzf](https://github.com/junegunn/fzf), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Needs fzf 0.52 or newer (the files use `--highlight-line`). Each file appends to `FZF_DEFAULT_OPTS`, for bash and zsh.

```sh
mkdir -p ~/.config/fzf
curl -fsSL -o ~/.config/fzf/kissaten_evening.sh \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/fzf/kissaten_evening.sh
```

Then in `~/.bashrc` or `~/.zshrc`, after anything else that sets `FZF_DEFAULT_OPTS`:

```sh
source ~/.config/fzf/kissaten_evening.sh
```
