# kissaten for delta

[kissaten.nvim](../../README.md) theme for [delta](https://github.com/dandavison/delta), generated from the same palettes as the Neovim colorscheme.

Every file comes in all five styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`, `kissaten_graveyard`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Each file defines a delta feature named after its style (`kissaten-evening` here).

```sh
mkdir -p ~/.config/delta
curl -fsSL -o ~/.config/delta/kissaten_evening.gitconfig \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/delta/kissaten_evening.gitconfig
```

Then in `~/.gitconfig`:

```gitconfig
[include]
  path = ~/.config/delta/kissaten_evening.gitconfig
[core]
  pager = delta
[delta]
  features = kissaten-evening
```

To switch styles quickly, include several files and change only `features`.
