# kissaten for k9s

[kissaten.nvim](../../README.md) theme for [k9s](https://k9scli.io), generated from the same palettes as the Neovim colorscheme.

Every file comes in all four styles (`kissaten_morning`, `kissaten_afternoon`, `kissaten_evening`, `kissaten_midnight`). The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Each style also comes as a `_transparent` skin that keeps your terminal's background.

```sh
# Linux; on macOS use "$HOME/Library/Application Support/k9s/skins". `k9s info` prints the right path.
OUT="${XDG_CONFIG_HOME:-$HOME/.config}/k9s/skins"
mkdir -p "$OUT"
curl -fsSL -o "$OUT/kissaten_evening.yaml" \
  https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/k9s/kissaten_evening.yaml
```

Then in k9s's `config.yaml`:

```yaml
k9s:
  ui:
    skin: kissaten_evening   # or kissaten_evening_transparent
```
