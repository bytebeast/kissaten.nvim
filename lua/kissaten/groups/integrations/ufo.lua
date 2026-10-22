local M = {}

M.url = "https://github.com/kevinhwang91/nvim-ufo"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    UfoFoldedFg       = { fg = c.fg },
    UfoFoldedBg       = { bg = c.surface0 },
    UfoFoldedEllipsis = { fg = c.overlay0 },
    UfoPreviewSbar    = { bg = c.surface0 },
    UfoPreviewThumb   = { bg = c.surface2 },
  }
end

return M
