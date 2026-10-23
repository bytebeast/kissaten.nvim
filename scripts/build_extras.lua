-- Regenerate ./extras from the palettes:
--   nvim --headless -u NONE -i NONE -l scripts/build_extras.lua
vim.opt.rtp:prepend(vim.fn.getcwd())
local Extras = require("kissaten.extras")
local styles = require("kissaten.config").styles

local count = 0
for name in pairs(Extras.extras) do
  vim.fn.mkdir("extras/" .. name, "p")
  for _, style in ipairs(styles) do
    for _, file in ipairs(Extras.files(name)) do
      local suffix, variant = file[1], file[2]
      local f = assert(io.open(Extras.path(name, style, suffix), "w"))
      f:write(Extras.render(name, style, variant))
      f:close()
      count = count + 1
    end
  end
end
print(("wrote %d files to ./extras"):format(count))
