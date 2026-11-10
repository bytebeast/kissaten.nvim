local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/yetone/avante.nvim"

--- avante ships hardcoded One Dark colors and keeps any group that already
--- has colors when it first sets up. Hues follow avante's own (green title,
--- cyan subtitle, purple while working), mapped onto the palette and roles.
--- Its conflict view uses the diff tints, so code there stays AA.
---@type kissaten.HighlightsFn
function M.get(c)
  local ui, d, on = c.ui, c.diag, c.ui.on_badge
  local function badge(bg)
    return { fg = on, bg = bg, bold = true }
  end
  -- stylua: ignore
  local hl = {
    AvanteTitle                     = badge(c.green),
    AvanteReversedTitle             = { fg = c.green, bg = ui.bg_float },
    AvanteSubtitle                  = badge(c.teal),
    AvanteReversedSubtitle          = { fg = c.teal, bg = ui.bg_float },
    AvanteThirdTitle                = { fg = c.fg, bg = c.surface1 },
    AvanteReversedThirdTitle        = { fg = c.surface1, bg = ui.bg_float },
    AvanteConfirmTitle              = badge(d.error),
    AvanteSuggestion                = { fg = c.comment, italic = true },
    AvanteAnnotation                = { fg = c.comment, italic = true },
    AvanteCommentFg                 = { fg = c.comment },
    AvanteToBeDeleted               = { bg = c.diff.delete, strikethrough = true },
    AvanteToBeDeletedWOStrikethrough = { bg = c.diff.delete },

    AvanteButtonDefault             = { fg = on, bg = c.subtext },
    AvanteButtonDefaultHover        = badge(c.green),
    AvanteButtonPrimary             = { fg = on, bg = c.subtext },
    AvanteButtonPrimaryHover        = badge(c.teal),
    AvanteButtonDanger              = { fg = on, bg = c.subtext },
    AvanteButtonDangerHover         = badge(d.error),

    AvanteStateSpinnerGenerating    = badge(c.purple),
    AvanteStateSpinnerToolCalling   = badge(c.teal),
    AvanteStateSpinnerFailed        = badge(d.error),
    AvanteStateSpinnerSucceeded     = badge(d.ok),
    AvanteStateSpinnerSearching     = badge(c.purple),
    AvanteStateSpinnerThinking      = badge(c.purple),
    AvanteStateSpinnerCompacting    = badge(c.purple),
    AvanteTaskRunning               = { fg = c.purple },
    AvanteTaskCompleted             = { fg = d.ok },
    AvanteTaskFailed                = { fg = d.error },
    AvanteThinking                  = { fg = c.purple },

    AvanteConflictCurrent           = { bg = c.diff.delete, bold = true },
    AvanteConflictCurrentLabel      = { bg = Util.tint(c.git.delete, c.bg, 0.34), bold = true },
    AvanteConflictIncoming          = { bg = c.diff.add, bold = true },
    AvanteConflictIncomingLabel     = { bg = Util.tint(c.git.add, c.bg, 0.34), bold = true },
  }
  -- avante's logo fades from near-white to grey, which vanishes on the light
  -- style: fade from the text color to the line-number shade instead
  for i = 1, 14 do
    hl["AvanteLogoLine" .. i] = { fg = Util.blend(c.overlay0, c.fg, (i - 1) / 13) }
  end
  return hl
end

return M
