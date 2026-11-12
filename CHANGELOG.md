# Changelog

## 1.0.0 (2026-11-12)

First release.

- Five styles: `morning` (light), `afternoon`, `evening` (default), `midnight` and
  `graveyard` (black, for OLED screens and dark rooms).
- Every syntax color meets WCAG AA (4.5:1) in every style; comments are at least 4:1.
- Code stays at 4.5:1 on the cursorline, selection and diff backgrounds too: those tints are
  capped by the weakest syntax color, so `morning`'s inks sit at 6:1 and `afternoon`'s red
  and blue at 6.3:1 to keep the tints visible.
- Three override layers: `on_palette`, `on_colors` (semantic roles) and `on_highlights`.
- `contrast = "high"` option that lifts comments, line numbers and UI hints.
- `subtle_comments` option (`true`, `0..1` or `{ fade, docstrings }`) that fades comments
  behind code by a contrast-based amount, consistent across all styles.
- `colorblind = "red-green" | "blue-yellow"`: diff, git and diagnostic colors (diff file
  headers included) chosen by simulating each color vision deficiency on every style
  (re-checked by the test suite).
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
  parameter from LSP semantic tokens; 12 AA colors per style, 6 colorblind-safe with
  `colorblind`, and still AA on the cursorline.
- `styles.readonly`, `styles.statics`, `styles.globals` and `styles.mutable` for LSP modifiers.
- Symbol references: writes get a pink tint, distinct from reads (also with color blindness).
- Diffs: folded lines sit on the other side of the background from the diff and cursorline
  tints, so a fold never looks like a changed line (also in nvim-ufo and VS Code,
  `colors.ui.bg_fold`). Changed text inside a changed line (`DiffText`) is underlined in the
  change hue so one-character edits stand out (`colors.ui.diff_text_underline`, off with
  `no_underline`); added text (`DiffTextAdd`, `diffopt+=inline:char`) in the add hue.
  Colored underlines inside tmux need `terminal-features ...:usstyle` (see the docs).
- Window separators are as visible as indent guides on every style, VS Code pane borders too.
- Recipes: follow the OS light/dark mode, per-language overrides, and a fix for vtsls's
  0-based document-highlight kinds.
- `:checkhealth kissaten` lists the options that shape the colors.
- Options combine safely: status colors and statusline modes keep their hue under
  `saturation`, a mode never shares the accent's color, and the test suite checks
  every pair of options on every style.
- Every option is validated: an invalid value (such as `styles = { comments = "italic" }`)
  warns and falls back to the default. Loading a style, `colors()` and the lualine themes
  never change the options passed to `setup()`.
- 60 plugin integrations, auto-detected through lazy.nvim and `vim.pack` (renamed and
  companion repos such as nvim-bufferline.lua and telescope-file-browser.nvim included),
  among them avante.nvim, blink.pairs, codecompanion.nvim, codediff.nvim, dropbar.nvim,
  git-conflict.nvim, hlargs.nvim, hover.nvim, lspsaga.nvim, markview.nvim, minuet-ai.nvim,
  nvim-cursorword, oil.nvim and virt-column.nvim; barbar, fzf-lua, gitsigns, neogit,
  nvim-tree, render-markdown, scrollbar, telescope, trouble, ufo and which-key theme every
  group their current versions use. tiny-inline-diagnostic works as-is.
- No cache: all groups are rebuilt on every load (about 1 ms), so changes always apply.
- Lualine themes, `:Kissaten` command, `:checkhealth kissaten`.
- Extras for Alacritty, bat, btop, delta, eza, foot, fzf, Ghostty, Helix, iTerm2, k9s (with
  transparent skins), Kitty, lazygit, tmux, VS Code, WezTerm, Windows Terminal, Yazi
  (flavors), Zed and Zettlr, with setup guides for bat, eza, k9s, VS Code and Zettlr in their
  `extras/` folders. btop, eza, foot, Helix, iTerm2, k9s, VS Code, Windows Terminal, Yazi
  and Zed are checked key by key against the tool's own source or schema.
- VS Code: an installable theme extension with all five styles; token colors, semantic
  tokens, bracket pairs and translucent highlights match Neovim, and every color id is
  checked against VS Code's color registry.
- Font guide (`extras/fonts`): recommended Nerd Fonts, setup for popular terminals and
  editors, and how to turn ligatures on or off.
- Tested on Neovim 0.9, 0.10, 0.11, 0.12 and nightly.
