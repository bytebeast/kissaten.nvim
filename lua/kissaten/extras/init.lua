---@mod kissaten.extras Generate matching themes for terminals and CLI tools
---
--- Regenerate everything in ./extras with:
---   nvim --headless -u NONE -l scripts/build_extras.lua
local M = {}

--- name -> { ext = file extension, label = shown in README }
-- stylua: ignore
M.extras = {
  alacritty = { ext = "toml", label = "Alacritty" },
  delta     = { ext = "gitconfig", label = "delta (git pager)" },
  fzf       = { ext = "sh", label = "fzf" },
  ghostty   = { ext = "", label = "Ghostty" },
  kitty     = { ext = "conf", label = "Kitty" },
  lazygit   = { ext = "yml", label = "lazygit" },
  tmux      = { ext = "tmux", label = "tmux" },
  wezterm   = { ext = "toml", label = "WezTerm" },
}

--- Replace ${path.to.key} with values from `tbl`.
---@param str string
---@param tbl table
function M.template(str, tbl)
  return (
    str:gsub("%${([%w_%.]+)}", function(path)
      local v = tbl
      for part in path:gmatch("[^%.]+") do
        v = type(v) == "table" and v[part] or nil
      end
      return v ~= nil and tostring(v) or ("${" .. path .. "}")
    end)
  )
end

---@param name string
---@param style kissaten.Style
---@return string
function M.render(name, style)
  local opts = require("kissaten.config").extend()
  opts.style = style
  local colors = require("kissaten.colors").setup(opts)
  colors._display = "Kissaten " .. style:sub(1, 1):upper() .. style:sub(2)
  colors._upstream = "https://github.com/bytebeast/kissaten.nvim"
  return require("kissaten.extras." .. name).generate(colors)
end

return M
