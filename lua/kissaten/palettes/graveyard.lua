-- Kissaten graveyard: Black. For OLED screens and dark rooms; midnight's
-- colors, each matched to the contrast it has in midnight.
---@type kissaten.Palette
return {
  _name = "graveyard",
  _background = "dark",
  -- On black there is less light to mix a tint into, so selection, search,
  -- diff and diagnostic backgrounds mix in 15% more color to stay as visible
  -- as they are in midnight.
  _tint = 1.15,
  crust = "#000000", -- deepest background: borders, tabline fill
  mantle = "#050507", -- sidebars, floats, statusline
  bg = "#0a0a0d", -- editor background
  surface0 = "#171827", -- cursorline, subtle highlights
  surface1 = "#23253b", -- selection-adjacent: pmenu sel, folds
  surface2 = "#30344f", -- visual selection, search
  overlay0 = "#51577b", -- line numbers, whitespace, indent guides
  comment = "#7479a1", -- comments (contrast-tuned)
  subtext = "#a1a9cd", -- dimmed text, punctuation
  fg = "#bfc7e6", -- default text
  red = "#ea83a0", -- errors, builtin variables (self/this), tags
  maroon = "#e7a09a", -- parameters
  orange = "#f09a62", -- numbers, constants, booleans
  yellow = "#ddbc66", -- types, classes, warnings
  green = "#9dd081", -- strings, added
  teal = "#69d1c1", -- properties, fields, hints
  cyan = "#74c6f5", -- builtin functions, regex
  sky = "#a0cfe6", -- operators (a soft cyan tint)
  blue = "#739aee", -- functions, methods, directories
  lavender = "#acb5f5", -- modules, namespaces
  purple = "#b392ee", -- keywords
  pink = "#ebb9dd", -- macros, decorators, escapes, preprocessor
}
