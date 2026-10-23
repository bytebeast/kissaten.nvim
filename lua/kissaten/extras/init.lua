---@mod kissaten.extras Generate matching themes for terminals and CLI tools
---
--- Regenerate everything in ./extras with:
---   nvim --headless -u NONE -l scripts/build_extras.lua
local M = {}

--- name -> {
---   ext      file extension ("" for none)
---   label    shown in the README
---   variants optional { [suffix] = variant }: one extra file per style and
---            variant, named kissaten_<style><suffix>.<ext>; the generator
---            receives the variant as its second argument
--- }
-- stylua: ignore
M.extras = {
  alacritty = { ext = "toml", label = "Alacritty" },
  bat       = { ext = "tmTheme", label = "bat" },
  delta     = { ext = "gitconfig", label = "delta (git pager)" },
  eza       = { ext = "yml", label = "eza" },
  fzf       = { ext = "sh", label = "fzf" },
  ghostty   = { ext = "", label = "Ghostty" },
  k9s       = { ext = "yaml", label = "k9s", variants = { [""] = "default", ["_transparent"] = "transparent" } },
  kitty     = { ext = "conf", label = "Kitty" },
  lazygit   = { ext = "yml", label = "lazygit" },
  tmux      = { ext = "tmux", label = "tmux" },
  wezterm   = { ext = "toml", label = "WezTerm" },
  zettlr    = { ext = "css", label = "Zettlr" },
}

--- Every file an extra produces for one style: { { suffix, variant }, ... }
---@param name string
---@return {[1]: string, [2]: string}[]
function M.files(name)
  local variants = M.extras[name].variants
  if not variants then
    return { { "", "default" } }
  end
  local out = {}
  for suffix, variant in pairs(variants) do
    out[#out + 1] = { suffix, variant }
  end
  table.sort(out, function(a, b)
    return a[1] < b[1]
  end)
  return out
end

--- Output path of one generated file, relative to the repo root.
function M.path(name, style, suffix)
  local ext = M.extras[name].ext
  return ("extras/%s/kissaten_%s%s%s"):format(name, style, suffix or "", ext ~= "" and ("." .. ext) or "")
end

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
---@param variant? string one of the extra's variants (default: "default")
---@return string
function M.render(name, style, variant)
  local opts = require("kissaten.config").extend()
  opts.style = style
  local colors = require("kissaten.colors").setup(opts)
  colors._display = "Kissaten " .. style:sub(1, 1):upper() .. style:sub(2)
  colors._upstream = "https://github.com/bytebeast/kissaten.nvim"
  colors._styles = opts.styles -- italic/bold choices, for extras that support them
  return require("kissaten.extras." .. name).generate(colors, variant or "default")
end

return M
