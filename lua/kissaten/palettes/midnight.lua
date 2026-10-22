-- Kissaten midnight: Darkest. Near-black ink for low-light sessions.
---@type kissaten.Palette
return {
  _name = "midnight",
  _background = "dark",
  crust = "#0c0c12", -- deepest background: borders, tabline fill
  mantle = "#111118", -- sidebars, floats, statusline
  bg = "#16161f", -- editor background
  surface0 = "#1f2030", -- cursorline, subtle highlights
  surface1 = "#2a2c42", -- selection-adjacent: pmenu sel, folds
  surface2 = "#363a56", -- visual selection, search
  overlay0 = "#575d82", -- line numbers, whitespace, indent guides
  comment = "#7a80a8", -- comments (contrast-tuned)
  subtext = "#a9b1d6", -- dimmed text, punctuation
  fg = "#c8d0f0", -- default text
  red = "#f38ba8", -- errors, builtin variables (self/this), tags
  maroon = "#f0a8a2", -- parameters
  orange = "#f9a26a", -- numbers, constants, booleans
  yellow = "#e6c56f", -- types, classes, warnings
  green = "#a6d98a", -- strings, added
  teal = "#73daca", -- properties, fields, hints
  cyan = "#7dcfff", -- builtin functions, regex
  sky = "#a9d8f0", -- operators (a soft cyan tint)
  blue = "#7aa2f7", -- functions, methods, directories
  lavender = "#b4befe", -- modules, namespaces
  purple = "#bb9af7", -- keywords
  pink = "#f5c2e7", -- macros, decorators, escapes, preprocessor
}
