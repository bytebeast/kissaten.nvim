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

## Follow the OS light/dark mode

This is the VS Code version of the auto dark mode recipe in the main README. Add to `settings.json`:

```jsonc
{
  "window.autoDetectColorScheme": true,
  "workbench.preferredLightColorTheme": "Kissaten Morning",
  "workbench.preferredDarkColorTheme": "Kissaten Evening"
}
```

## Notes

- Comments and keywords are italic, like the Neovim defaults. Whether that shows depends on your font: pick one with a real italic. The [font guide](../fonts/README.md) has suggestions.
- Bracket pairs are colored in rainbow-delimiters' order. VS Code turns this on by default (`editor.bracketPairColorization.enabled`).
- Like every extra, the themes are built with kissaten's default options. Neovim options such as `accent`, `colorblind` or `saturation` don't apply here.
- To change single colors, use VS Code's own overrides, for example:

  ```jsonc
  "workbench.colorCustomizations": {
    "[Kissaten Evening]": { "editorCursor.foreground": "#f7a46f" }
  },
  "editor.tokenColorCustomizations": {
    "[Kissaten Evening]": { "comments": "#8a91b8" }
  }
  ```
