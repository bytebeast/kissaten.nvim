-- Print the computed colors of every style as JSON (used by make_assets.py,
-- handy for porting kissaten to other tools):
--   nvim --headless -u NONE -i NONE -l scripts/export_colors.lua > colors.json
vim.opt.rtp:prepend(vim.fn.getcwd())

local Config = require("kissaten.config")
local out = {}
for _, style in ipairs(Config.styles) do
  local function colors(extra)
    local opts = Config.extend(extra or {})
    opts.style = style
    return require("kissaten.colors").setup(opts)
  end
  local c = colors()
  local strip = function(t)
    local r = {}
    for k, v in pairs(t) do
      if type(v) == "string" then
        r[k] = v
      end
    end
    return r
  end
  out[style] = {
    background = c._background,
    palette = strip(require("kissaten.colors").palette(style)),
    syn = strip(c.syn),
    ui = strip(c.ui),
    diff = strip(c.diff),
    diag = strip(c.diag),
    git = strip(c.git),
    subtle = {
      ["0.5"] = colors({ subtle_comments = 0.5 }).syn.comment,
      ["0.7"] = colors({ subtle_comments = 0.7 }).syn.comment,
    },
    colorblind = {},
  }
  for _, mode in ipairs({ "red-green", "blue-yellow" }) do
    local cb = colors({ colorblind = mode })
    out[style].colorblind[mode] = { git = strip(cb.git), diag = strip(cb.diag), diff = strip(cb.diff) }
  end
end
io.write(vim.json.encode(out), "\n")
