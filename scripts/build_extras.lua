-- Regenerate ./extras from the palettes:
--   nvim --headless -u NONE -i NONE -l scripts/build_extras.lua
vim.opt.rtp:prepend(vim.fn.getcwd())
local Extras = require("kissaten.extras")
local styles = require("kissaten.config").styles

local count = 0
for name, info in pairs(Extras.extras) do
  vim.fn.mkdir("extras/" .. name, "p")
  for _, style in ipairs(styles) do
    local file = ("extras/%s/kissaten_%s%s"):format(name, style, info.ext ~= "" and ("." .. info.ext) or "")
    local f = assert(io.open(file, "w"))
    f:write(Extras.render(name, style))
    f:close()
    count = count + 1
  end
end
print(("wrote %d files to ./extras"):format(count))
