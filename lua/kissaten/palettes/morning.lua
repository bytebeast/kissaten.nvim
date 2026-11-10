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
  red = "#b7002f", -- errors, builtin variables (self/this), tags
  maroon = "#90433a", -- parameters
  orange = "#9c3c00", -- numbers, constants, booleans
  yellow = "#805000", -- types, classes, warnings
  green = "#24680c", -- strings, added
  teal = "#00656a", -- properties, fields, hints
  cyan = "#00608c", -- builtin functions, regex
  sky = "#2a5f7f", -- operators (a soft cyan tint)
  blue = "#1d4fcf", -- functions, methods, directories
  lavender = "#525494", -- modules, namespaces
  purple = "#7128df", -- keywords
  pink = "#9c2d7a", -- macros, decorators, escapes, preprocessor
}
