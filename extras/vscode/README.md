# kissaten for VS Code

[kissaten.nvim](../../README.md) as a VS Code color theme, generated from the same palettes as the Neovim colorscheme. It also works in VS Code forks that install VS Code extensions, such as VSCodium and Cursor.

This folder is a complete theme extension with all five styles: **Kissaten Morning**, **Kissaten Afternoon**, **Kissaten Evening**, **Kissaten Midnight** and **Kissaten Graveyard**. Code is colored the way Neovim colors it:

- **Token colors** come from the same TextMate rules as the [bat theme](../bat/README.md).
- **Semantic tokens** follow kissaten's LSP groups: built-in functions and types, parameters, interfaces in italic, deprecated symbols struck through, and `mut` bindings underlined (rust-analyzer).
- **The workbench** is laid out like kissaten's Neovim UI. Sidebars, panels and inactive tabs use the darker sidebar shade, focus and titles use the accent color, and the terminal uses the same 16 colors as the terminal extras.
- **Highlights drawn over text** (find matches, word highlights, diff lines) are translucent, as VS Code requires, and they land on exactly the colors Neovim uses.

## Install

### 1. Get the files

Clone the repo, or download it as a zip from GitHub and unpack it:

```sh
git clone https://github.com/bytebeast/kissaten.nvim
cd kissaten.nvim
```

Everything below runs from the repo root. Only the `extras/vscode` folder is needed.

### 2. Install the extension

Pick **one** of the two ways.

**Option A: copy the folder.** Copy `extras/vscode` into your editor's extensions folder, then restart the editor completely (quit it, not just close the window).

| Editor | Extensions folder (macOS / Linux) | Extensions folder (Windows) |
| --- | --- | --- |
| VS Code | `~/.vscode/extensions` | `%USERPROFILE%\.vscode\extensions` |
| VS Code Insiders | `~/.vscode-insiders/extensions` | `%USERPROFILE%\.vscode-insiders\extensions` |
| VSCodium | `~/.vscode-oss/extensions` | `%USERPROFILE%\.vscode-oss\extensions` |
| Cursor | `~/.cursor/extensions` | `%USERPROFILE%\.cursor\extensions` |

macOS / Linux:

```sh
cp -r extras/vscode ~/.vscode/extensions/bytebeast.kissaten
```

Windows (PowerShell):

```powershell
Copy-Item -Recurse extras\vscode "$env:USERPROFILE\.vscode\extensions\bytebeast.kissaten"
```

**Option B: build a `.vsix` package.** A `.vsix` installs like any extension from the marketplace. It also works over Remote SSH, in WSL and in dev containers, and you can share the file with other people. This needs [Node.js](https://nodejs.org):

```sh
cd extras/vscode
npx @vscode/vsce package          # writes kissaten-1.0.0.vsix
code --install-extension kissaten-1.0.0.vsix
```

To install the `.vsix` from inside the editor instead, open the Extensions view, click the `...` menu at the top of it, and choose **Install from VSIX...**. VSCodium uses `codium --install-extension`, and Cursor uses `cursor --install-extension`.

### 3. Pick a style

Open the Command Palette (`Ctrl+Shift+P`, or `Cmd+Shift+P` on macOS), run **Preferences: Color Theme**, and choose one of:

| Theme | Style |
| --- | --- |
| Kissaten Morning | light: bright paper with deep inks |
| Kissaten Afternoon | mid-dark slate blue |
| Kissaten Evening | dark navy with warm accents (the default) |
| Kissaten Midnight | near-black ink for low light |
| Kissaten Graveyard | black, for OLED screens and dark rooms |

You can also set it in `settings.json`: `"workbench.colorTheme": "Kissaten Evening"`.

**Don't see the themes?** Make sure the copied folder contains `package.json` directly, for example at `~/.vscode/extensions/bytebeast.kissaten/package.json` and not one folder deeper. Then restart the editor. With Option B, check that `code --list-extensions` lists `bytebeast.kissaten`.

### Update or uninstall

- **Update:** pull the latest repo, then repeat step 2. With Option A, delete the old `bytebeast.kissaten` folder first.
- **Uninstall:** with Option A, delete the `bytebeast.kissaten` folder and restart. With Option B, run `code --uninstall-extension bytebeast.kissaten`, or uninstall it from the Extensions view.

## Settings

VS Code themes take no options of their own: everything that shapes how kissaten looks is a VS Code setting. This is every setting that matters, ready to paste into your user `settings.json` (open it with **Preferences: Open User Settings (JSON)**).

Each line shows **VS Code's default**, except the first three, which select kissaten. Delete any line you don't change.

```jsonc
{
  // ── Theme ─────────────────────────────────────────────────────────────
  // VS Code's defaults: "Dark 2026" / "Dark 2026" / "Light 2026"
  "workbench.colorTheme": "Kissaten Evening",
  "workbench.preferredDarkColorTheme": "Kissaten Evening",
  "workbench.preferredLightColorTheme": "Kissaten Morning",
  // Follow the OS light/dark mode (uses the two preferred themes above)
  "window.autoDetectColorScheme": false,
  // Switch to a high contrast theme when the OS asks for one
  "window.autoDetectHighContrast": true,

  // ── Code colors ───────────────────────────────────────────────────────
  // true | false | "configuredByTheme" (kissaten turns it on: LSP-aware
  // colors for parameters, built-ins, interfaces, deprecated symbols, ...)
  "editor.semanticHighlighting.enabled": "configuredByTheme",
  // Rainbow brackets, in rainbow-delimiters' order
  "editor.bracketPairColorization.enabled": true,
  // true: ( ), [ ] and { } each cycle through the colors on their own
  "editor.bracketPairColorization.independentColorPoolPerBracketType": false,
  // Vertical lines in the bracket colors: true | "active" | false
  "editor.guides.bracketPairs": false,
  "editor.guides.bracketPairsHorizontal": "active",
  "editor.guides.highlightActiveBracketPair": true,
  // Indent guides (the active scope is drawn brighter)
  "editor.guides.indentation": true,
  "editor.guides.highlightActiveIndentation": true,
  // "none" | "boundary" | "selection" | "trailing" | "all"
  "editor.renderWhitespace": "selection",
  // Inlay hints in kissaten's tinted style: "on" | "off" | "onUnlessPressed" | "offUnlessPressed"
  "editor.inlayHints.enabled": "on",

  // ── Fonts ─────────────────────────────────────────────────────────────
  // kissaten italicizes comments and keywords: pick a font with a real
  // italic (see the font guide). The screenshots use JetBrains Mono Nerd Font.
  // Default: Menlo (macOS), Consolas (Windows), Droid Sans Mono (Linux)
  "editor.fontFamily": "Menlo, Monaco, 'Courier New', monospace",
  "editor.fontSize": 12, // 12 on macOS, 14 elsewhere
  "editor.fontLigatures": false,

  // ── Terminal ──────────────────────────────────────────────────────────
  // VS Code nudges terminal text to this contrast. kissaten's 16 terminal
  // colors already meet it, so they show as designed; 1 turns it off.
  "terminal.integrated.minimumContrastRatio": 4.5,

  // ── Your own changes ──────────────────────────────────────────────────
  // Change single colors, for every theme or for one (in square brackets).
  // Workbench color ids: https://code.visualstudio.com/api/references/theme-color
  "workbench.colorCustomizations": {
    // "[Kissaten Evening]": { "editorCursor.foreground": "#f7a46f" }
  },
  // TextMate token colors: "comments", "strings", "keywords", "numbers",
  // "types", "functions", "variables", or "textMateRules" for any scope
  "editor.tokenColorCustomizations": {
    // "[Kissaten Evening]": { "comments": "#8a91b8" }
  },
  // Semantic token colors, e.g. parameters or read-only variables
  "editor.semanticTokenColorCustomizations": {
    // "[Kissaten Evening]": { "rules": { "parameter": { "italic": true } } }
  }
}
```

## Notes

- Comments and keywords are italic, like the Neovim defaults. Whether that shows depends on your font: pick one with a real italic. The [font guide](../fonts/README.md) has suggestions.
- Bracket pairs are colored in rainbow-delimiters' order. VS Code turns this on by default (`editor.bracketPairColorization.enabled`).
- Like every extra, the themes are built with kissaten's default options. Neovim options such as `accent`, `colorblind` or `saturation` don't apply here.
- To change single colors, see the overrides at the end of [Settings](#settings).
