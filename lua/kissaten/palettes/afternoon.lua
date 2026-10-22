-- Kissaten afternoon: Mid-dark. Slate-blue, a softer take on storm/frappé.
---@type kissaten.Palette
return {
  _name = "afternoon",
  _background = "dark",
  crust = "#1a1c2a", -- deepest background: borders, tabline fill
  mantle = "#212435", -- sidebars, floats, statusline
  bg = "#282b3e", -- editor background
  surface0 = "#31354b", -- cursorline, subtle highlights
  surface1 = "#3c4159", -- selection-adjacent: pmenu sel, folds
  surface2 = "#4a506b", -- visual selection, search
  overlay0 = "#6a7194", -- line numbers, whitespace, indent guides
  comment = "#8890b6", -- comments (contrast-tuned)
  subtext = "#b0b9dd", -- dimmed text, punctuation
  fg = "#cdd5f6", -- default text
  red = "#ef8aa6", -- errors, builtin variables (self/this), tags
  maroon = "#eca7a1", -- parameters
  orange = "#f3a06c", -- numbers, constants, booleans
  yellow = "#e8c47e", -- types, classes, warnings
  green = "#a9d881", -- strings, added
  teal = "#7fd3c4", -- properties, fields, hints
  cyan = "#7fd1f0", -- builtin functions, regex
  sky = "#abd6ee", -- operators (a soft cyan tint)
  blue = "#84a8f8", -- functions, methods, directories
  lavender = "#b5bff8", -- modules, namespaces
  purple = "#c6a0f6", -- keywords
  pink = "#f4b8e4", -- macros, decorators, escapes, preprocessor
}
