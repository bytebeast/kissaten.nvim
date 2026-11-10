# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

kissaten.nvim is a Neovim colorscheme (five styles: `morning` light, `afternoon`, `evening` default, `midnight`, `graveyard`) plus generated themes for terminals and CLI tools in `extras/`. Supports Neovim 0.9.5 through nightly (CI matrix).

## Commands

```sh
# full test suite (single file, no per-test filter; exits non-zero on failure)
nvim --headless -u NONE -i NONE -l tests/run.lua

# regenerate extras/ from the palettes. CI fails if extras/ differs from the generated output
nvim --headless -u NONE -i NONE -l scripts/build_extras.lua

# format (CI runs this with --check)
stylua lua plugin colors tests scripts/build_extras.lua

# dump every computed color per style as JSON
nvim --headless -u NONE -i NONE -l scripts/export_colors.lua > colors.json
```

Any change to a palette, `colors.lua`, `config.lua` defaults or an extras generator needs `build_extras.lua` re-run and the `extras/` diff committed.

## Architecture

Three layers, documented at the top of `lua/kissaten/colors.lua`:

1. **Palette** (`lua/kissaten/palettes/<style>.lua`): raw hex colors per style, same keys in every file.
2. **Colors** (`lua/kissaten/colors.lua`): turns a palette plus config into semantic roles (`c.syn`, `c.ui`, `c.diag`, `c.git`, `c.diff`, `c.terminal`). All option logic that changes colors lives here: `contrast`, `subtle_comments`, `colorblind` remaps, `saturation`, `accent`, `rainbow_variables`, `on_palette`/`on_colors` hooks.
3. **Groups** (`lua/kissaten/groups/`): highlight definitions that read only semantic roles, never palette names. Re-pointing a role restyles everything that uses it.

Load path: `colors/kissaten-<style>.lua` calls `require("kissaten").load(nil, style)`. `init.lua` resolves the style against `vim.o.background` (and remembers the last style per background in `M.last` so toggling round-trips), builds colors, builds groups, then sets them. `colors/kissaten.lua` follows `background`.

`groups/init.lua`:
- `M.core` groups always load. `M.plugins` maps plugin repo name to integration module.
- Integrations auto-enable by querying lazy.nvim or `vim.pack` (only if the user already loaded it). No recognised manager means load all. User `plugins.<module|repo>` settings override detection.
- Groups may be a string (shorthand for `link`) or a table with a `style` sub-table. `finalize()` normalises these and applies `no_italic`/`no_bold`/`no_underline`. There is deliberately no cache.

Adding an integration: one file in `groups/integrations/` exporting `url` and `get(c, opts)`, plus one line in `M.plugins`. Also add a row to the README integration table.

`extras/`: `lua/kissaten/extras/init.lua` registers each tool (extension, label, optional `variants` like k9s `_transparent`). Each generator exports `generate(colors, variant)` and optionally `static()` for non-per-style files (VS Code's `package.json` and `LICENSE`; `package.json` takes its version from `config.version`). `per_style = false` skips the flat `kissaten_<style>.<ext>` files for tools that only use `static()` (yazi writes `kissaten-<style>.yazi/` flavor folders, reusing the bat tmTheme). Files under `extras/` are build output; edit the generator, not the output. Hand-written exceptions are the per-tool `README.md` files, `extras/fonts/` and `extras/vscode/icon.png`.

Lualine themes in `lua/lualine/themes/` are thin wrappers over `lua/kissaten/lualine.lua`.

## Tests

`tests/run.lua` is a self-contained harness (`test`, `eq`, `truthy`), no external framework. It intercepts `vim.notify`, so any warning during load fails the "loads without warnings" tests. Beyond loading every style it enforces design invariants, so expect failures if a color change breaks them:
- WCAG contrast: syntax roles at 4.5:1, comments at 4:1, badge text at 4.5:1, in every style and option combination. Code also stays at 4.5:1 on the cursorline, selection and diff backgrounds: `colors.lua` caps those tints by the weakest syntax role, so a palette ink near 4.5 forces faint tints (raise the ink instead).
- Colorblind separation via a CVD simulation (Machado 2009) and OKLab distance.
- Every highlight link resolves; every integration's groups are themed.
- Extras validated against each tool's real schema: key lists inline in the test for small formats (eza, k9s, Windows Terminal, iTerm2, foot, btop), fixtures in `tests/fixtures/` for large ones (VS Code, Helix, Zed, Yazi). Each fixture header names the upstream commit it came from; regenerate from that tool's source when updating.

`:checkhealth kissaten` (`lua/kissaten/health.lua`) reports active integrations and warns when user `on_colors` overrides push syntax roles below 4.5:1.

## Conventions

- stylua: 2 spaces, 120 columns, double quotes, call parentheses always. Aligned tables use `-- stylua: ignore`.
- Type annotations live in `lua/kissaten/types.lua` and inline `---@` comments. Modules start with `---@mod`.
- `doc/kissaten.nvim.txt` is hand-maintained vimdoc (no generator), so option changes need updating there as well as in the README.
- Python scripts in `scripts/` (screenshots via pynvim, asset generation via Pillow, Blender scene) are only for README images and are not linted or tested in CI. `scripts/screenshots/run.sh` rebuilds every screenshot: its `init.lua` runs LazyVim offline from an existing plugin dir (lazy `dev` mode, empty root), `scenario.lua` drives each shot, `samples/` is the demo project. `zettlr-*.png` are app screenshots it can't make.
