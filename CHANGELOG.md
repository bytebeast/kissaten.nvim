# Changelog

## 1.0.0 (2026-10-22)

First release.

- Four styles: `morning` (light), `afternoon`, `evening` (default) and
  `midnight`.
- Every syntax color meets WCAG AA (4.5:1) in every style; comments are at least
  4:1.
- Three override layers: `on_palette`, `on_colors` (semantic roles) and
  `on_highlights`.
- `contrast = "high"` option that lifts comments, line numbers and UI hints.
- `subtle_comments` option (`true`, `0..1` or `{ fade, docstrings }`) that fades
  comments behind code by a contrast-based amount, consistent across all four
  styles.
- 46 plugin integrations, auto-detected through lazy.nvim and `vim.pack`.
- No cache: all groups are rebuilt on every load (about 1 ms), so changes always
  apply.
- Lualine themes, `:Kissaten` command, `:checkhealth kissaten`.
- Extras for Alacritty, delta, fzf, Ghostty, Kitty, lazygit, tmux and WezTerm.
- Tested on Neovim 0.9, 0.10, 0.11, 0.12 and nightly.
