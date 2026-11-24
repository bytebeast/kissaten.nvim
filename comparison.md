# Comparison

How kissaten.nvim compares with [catppuccin/nvim](https://github.com/catppuccin/nvim) and
[tokyonight.nvim](https://github.com/folke/tokyonight.nvim).

| Feature | kissaten | catppuccin | tokyonight |
|---|---|---|---|
| Styles | 5, including a true black OLED style (graveyard) | 4, no black style | 4, no black style |
| Light style | Hand-tuned, AA-checked | Hand-tuned | Inverted from night |
| WCAG contrast enforced by tests | Yes, every style and option combination | No | No |
| Comments meet AA on the default style | Yes (4.53:1) | Yes (5.81:1) | No (3.11:1) |
| High contrast mode | Yes | No | No |
| Colorblind modes (red-green, blue-yellow) | Yes, tested with a CVD simulation | No | No |
| Fade comments without losing them | Yes | No | No |
| Saturation control, all styles | Yes, stays AA | No | Day style only |
| UI accent color | Any of 12 | No | No |
| Rainbow variables (semantic tokens) | Yes | No | No |
| Rainbow delimiter modes | vivid, dimmed, mono | Integration only | Integration only |
| Borderless pickers | Yes | Partial (`float.solid`) | No |
| LSP modifier styles (mut, readonly, static, global) | Yes | No | No |
| `:checkhealth` with contrast warnings | Yes | No | No |
| Plugin auto-detection | lazy.nvim + vim.pack | lazy.nvim + vim.pack | lazy.nvim only |
| Themes for other tools | 27 terminals and CLI tools, mainly focused on a robust Neovim IDE setup | Largest ecosystem, separate repos in the catppuccin org | 48, in the same repo |
| Extras validated against real tool schemas | Yes | No | No |

"No" means no built-in option, as of catppuccin
[`edefef7`](https://github.com/catppuccin/nvim/commit/edefef7) and tokyonight
[`cdc07ac`](https://github.com/folke/tokyonight.nvim/commit/cdc07ac). Contrast ratios are comment color on editor
background for each theme's default dark style (kissaten evening, catppuccin mocha, tokyonight moon).
