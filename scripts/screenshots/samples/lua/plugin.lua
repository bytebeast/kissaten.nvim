---@class Brew
---@field origin string
---@field grams number
local Brew = {}
Brew.__index = Brew

local RATIO = 15 -- grams of water per gram of coffee
local roasts = { light = 94, medium = 92, dark = 88 }

---@param origin string
---@param grams? number
---@return Brew
function Brew.new(origin, grams)
  return setmetatable({ origin = origin, grams = grams or 18 }, Brew)
end

function Brew:water()
  return self.grams * RATIO
end

---@param roast "light"|"medium"|"dark"
function Brew:temperature(roast)
  local t = roasts[roast]
  if not t then
    error(("unknown roast: %s"):format(roast))
  end
  return t
end

local M = {}

function M.setup(opts)
  opts = vim.tbl_deep_extend("force", { origin = "Ethiopia", roast = "light" }, opts or {})
  local brew = Brew.new(opts.origin)
  vim.api.nvim_create_user_command("Brew", function()
    vim.notify(("%s: %dg water at %d°C"):format(brew.origin, brew:water(), brew:temperature(opts.roast)))
  end, { desc = "Print a pour-over recipe" })
  return brew ~= nil and true or false
end

return M
