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
    UfoCursorFoldedLine = { bg = c.surface1 },
    UfoPreviewCursorLine = { bg = c.ui.bg_sel },
    UfoPreviewWinBar  = { fg = c.comment, bg = c.ui.bg_float },
  }
end

return M
