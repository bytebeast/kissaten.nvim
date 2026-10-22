-- Kissaten evening: Dark. Cool navy with warm café accents (default).
---@type kissaten.Palette
return {
  _name = "evening",
  _background = "dark",
  crust = "#13141f", -- deepest background: borders, tabline fill
  mantle = "#191a2a", -- sidebars, floats, statusline
  bg = "#1f2133", -- editor background
  surface0 = "#272a40", -- cursorline, subtle highlights
  surface1 = "#323650", -- selection-adjacent: pmenu sel, folds
  surface2 = "#3f4463", -- visual selection, search
  overlay0 = "#5f668d", -- line numbers, whitespace, indent guides
  comment = "#7f87b0", -- comments (contrast-tuned)
  subtext = "#aeb7dc", -- dimmed text, punctuation
  fg = "#cad3f5", -- default text
  red = "#f28fad", -- errors, builtin variables (self/this), tags
  maroon = "#efaaa5", -- parameters
  orange = "#f7a46f", -- numbers, constants, booleans
  yellow = "#ebcf8c", -- types, classes, warnings
  green = "#b5e08d", -- strings, added
  teal = "#7fd8c8", -- properties, fields, hints
  cyan = "#89ddff", -- builtin functions, regex
  sky = "#acd9f2", -- operators (a soft cyan tint)
  blue = "#82aaff", -- functions, methods, directories
  lavender = "#b7c1fb", -- modules, namespaces
  purple = "#c3a6ff", -- keywords
  pink = "#f5bde6", -- macros, decorators, escapes, preprocessor
}
