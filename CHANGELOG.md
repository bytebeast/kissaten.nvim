# Changelog

## 1.0.0 (2026-10-22)

First release.

- Five styles: `morning` (light), `afternoon`, `evening` (default), `midnight` and
  `graveyard` (black, for OLED screens and dark rooms).
- Every syntax color meets WCAG AA (4.5:1) in every style; comments are at least 4:1.
- Three override layers: `on_palette`, `on_colors` (semantic roles) and `on_highlights`.
- `contrast = "high"` option that lifts comments, line numbers and UI hints.
- `subtle_comments` option (`true`, `0..1` or `{ fade, docstrings }`) that fades comments
  behind code by a contrast-based amount, consistent across all styles.
- `colorblind = "red-green" | "blue-yellow"`: diff, git and diagnostic colors chosen by
  simulating each color vision deficiency on every style (re-checked by the test suite).
- `saturation = 0..1`: mutes colors in OKLab while keeping every color's contrast.
- `accent`: pick the UI accent (titles, matches, normal mode, selected tab) from the palette.
- `rainbow = "vivid" | "dimmed" | "mono"` for rainbow-delimiters and rainbow indent scopes.
- `borderless = true`: Telescope, snacks and fzf-lua pickers framed by shade instead of lines.
- `diagnostics.underline`, `diagnostics.virtual_text`, `inlay_hints`, and
  `styles.virtual_text`, `styles.inlay_hints`, `styles.conditionals`, `styles.loops`.
- Text on colored badges meets 4.5:1 on every style (the light style uses its paper color).
- `midnight` and `graveyard`: floats and the completion menu sit a step above the editor so
  they no longer blend into it; `bright_borders` docs explain `winborder` for border-less popups.
- `rainbow_variables`: JetBrains-style semantic highlighting, a color per local variable and
  parameter from LSP semantic tokens; 12 AA colors per style, 6 colorblind-safe with `colorblind`.
- `styles.readonly`, `styles.statics`, `styles.globals` and `styles.mutable` for LSP modifiers.
- Symbol references: writes get a pink tint, distinct from reads (also with color blindness).
- Recipes: follow the OS light/dark mode, per-language overrides, and a fix for vtsls's
  0-based document-highlight kinds.
- `:checkhealth kissaten` lists the options that shape the colors.
- Options combine safely: status colors and statusline modes keep their hue under
  `saturation`, a mode never shares the accent's color, and the test suite checks
  every pair of options on every style.
- 55 plugin integrations, auto-detected through lazy.nvim and `vim.pack` (renamed and
  companion repos such as nvim-bufferline.lua and telescope-file-browser.nvim included):
  new are blink.pairs, codediff.nvim, git-conflict.nvim, hlargs.nvim, hover.nvim,
  lspsaga.nvim, minuet-ai.nvim, nvim-cursorword and virt-column.nvim; barbar, fzf-lua,
  gitsigns, neogit, nvim-tree, render-markdown, scrollbar, telescope, trouble, ufo and
  which-key now theme every group their current versions use.
- No cache: all groups are rebuilt on every load (about 1 ms), so changes always apply.
- Lualine themes, `:Kissaten` command, `:checkhealth kissaten`.
- Extras for Alacritty, bat, delta, eza, fzf, Ghostty, k9s (with transparent skins), Kitty,
  lazygit, tmux, WezTerm and Zettlr, with setup guides for bat, eza, k9s and Zettlr
  in their `extras/` folders.
- Font guide (`extras/fonts`): recommended Nerd Fonts, setup for popular terminals and
  editors, and how to turn ligatures on or off.
- Tested on Neovim 0.9, 0.10, 0.11, 0.12 and nightly.
