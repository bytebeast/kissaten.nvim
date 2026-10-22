---@mod kissaten kissaten.nvim
---
--- A coffee-house colorscheme for Neovim: Tokyonight's crisp structure,
--- Catppuccin's warm accents, contrast-checked for long programming sessions.
local Config = require("kissaten.config")

local M = {}

--- Last style used for each background, so toggling `background` round-trips.
---@type table<"dark"|"light", kissaten.Style>
M.last = {}

---@param opts? kissaten.Config
function M.setup(opts)
  Config.setup(opts)
end

local function style_bg(style)
  return style == "morning" and "light" or "dark"
end

--- Resolve which style to load, honouring `vim.o.background` changes.
---@param opts kissaten.Config
---@param requested? kissaten.Style explicit style from `:colorscheme kissaten-<style>`
local function resolve_style(opts, requested)
  local bg = vim.o.background
  if requested then
    -- Neovim re-runs the current colorscheme when 'background' changes. If the
    -- active variant no longer matches, switch to the matching one instead of
    -- forcing the background back.
    if vim.g.colors_name == "kissaten-" .. requested and style_bg(requested) ~= bg then
      return bg == "light" and (M.last.light or opts.light_style) or (M.last.dark or opts.style)
    end
    return requested
  end
  if bg == "light" then
    return M.last.light or opts.light_style
  end
  local style = M.last.dark or opts.style
  return style_bg(style) == "dark" and style or "evening"
end

--- Apply the colorscheme.
---@param opts? kissaten.Config|{style?: kissaten.Style}
---@param requested? kissaten.Style
---@return kissaten.Colors colors, kissaten.Highlights groups, kissaten.Config opts
function M.load(opts, requested)
  opts = Config.extend(opts)
  opts.style = resolve_style(opts, requested)

  local colors = require("kissaten.colors").setup(opts)
  local groups = require("kissaten.groups").setup(colors, opts)

  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  local bg = colors.light and "light" or "dark"
  if vim.o.background ~= bg then
    vim.o.background = bg
  end
  vim.o.termguicolors = true
  vim.g.colors_name = "kissaten-" .. opts.style
  M.last[bg] = opts.style

  for name, hl in pairs(groups) do
    vim.api.nvim_set_hl(0, name, hl)
  end

  if opts.terminal_colors then
    M.terminal(colors)
  end

  return colors, groups, opts
end

---@param c kissaten.Colors
function M.terminal(c)
  local t = c.terminal
  -- stylua: ignore
  local map = {
    t.black, t.red, t.green, t.yellow, t.blue, t.magenta, t.cyan, t.white,
    t.black_bright, t.red_bright, t.green_bright, t.yellow_bright,
    t.blue_bright, t.magenta_bright, t.cyan_bright, t.white_bright,
  }
  for i, color in ipairs(map) do
    vim.g["terminal_color_" .. (i - 1)] = color
  end
end

--- Colors for the active (or a given) style, for use in your own config:
---   local c = require("kissaten").colors()
---   vim.api.nvim_set_hl(0, "MyGroup", { fg = c.syn.keyword })
---@param style? kissaten.Style
---@return kissaten.Colors
function M.colors(style)
  local opts = Config.extend()
  opts.style = style or (vim.g.colors_name or ""):match("^kissaten%-(%a+)$") or opts.style
  return require("kissaten.colors").setup(opts)
end

return M
