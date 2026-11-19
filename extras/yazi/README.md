# kissaten for Yazi

[kissaten.nvim](../../README.md) theme for [Yazi](https://yazi-rs.github.io), generated from the same palettes as the Neovim colorscheme.

Each style is a Yazi flavor folder: `kissaten-morning.yazi`, `kissaten-afternoon.yazi`, `kissaten-evening.yazi`, `kissaten-midnight.yazi` and `kissaten-graveyard.yazi`. The examples use `evening`; swap in the style you want. Replace `curl … -o` with a plain copy if you've cloned the repo.

## Install

Needs Yazi 0.4 or newer. Each flavor has a `flavor.toml` and a `tmtheme.xml` (the [bat theme](../bat/README.md), so previews color code like Neovim does).

```sh
dir=~/.config/yazi/flavors/kissaten-evening.yazi
mkdir -p "$dir"
for f in flavor.toml tmtheme.xml; do
  curl -fsSL -o "$dir/$f" https://raw.githubusercontent.com/bytebeast/kissaten.nvim/main/extras/yazi/kissaten-evening.yazi/$f
done
```

Then in `~/.config/yazi/theme.toml`. Yazi picks `light` or `dark` from your terminal's background, so set both (download `kissaten-morning.yazi` the same way):

```toml
[flavor]
dark = "kissaten-evening"
light = "kissaten-morning"
```
