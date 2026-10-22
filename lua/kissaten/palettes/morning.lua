-- Kissaten morning: Light. Bright paper with deep, AA-contrast inks.
---@type kissaten.Palette
return {
  _name = "morning",
  _background = "light",
  crust = "#d4d8e4", -- deepest background: borders, tabline fill
  mantle = "#e0e4ee", -- sidebars, floats, statusline
  bg = "#eef0f6", -- editor background
  surface0 = "#e2e5ee", -- cursorline, subtle highlights
  surface1 = "#d3d8e5", -- selection-adjacent: pmenu sel, folds
  surface2 = "#c2c9dc", -- visual selection, search
  overlay0 = "#8f96b1", -- line numbers, whitespace, indent guides
  comment = "#686f8e", -- comments (contrast-tuned)
  subtext = "#4f5578", -- dimmed text, punctuation
  fg = "#353a5c", -- default text
  red = "#c8153c", -- errors, builtin variables (self/this), tags
  maroon = "#9d4f45", -- parameters
  orange = "#b25000", -- numbers, constants, booleans
  yellow = "#8f5f06", -- types, classes, warnings
  green = "#32761f", -- strings, added
  teal = "#10757a", -- properties, fields, hints
  cyan = "#09729f", -- builtin functions, regex
  sky = "#3a6f8f", -- operators (a soft cyan tint)
  blue = "#2a5fe0", -- functions, methods, directories
  lavender = "#5f62a3", -- modules, namespaces
  purple = "#7c3aed", -- keywords
  pink = "#ab3c87", -- macros, decorators, escapes, preprocessor
}
