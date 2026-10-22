local M = {}

M.url = "https://github.com/ThePrimeagen/harpoon"

---@type kissaten.HighlightsFn
function M.get()
  return {
    HarpoonWindow = "NormalFloat",
    HarpoonBorder = "FloatBorder",
  }
end

return M
