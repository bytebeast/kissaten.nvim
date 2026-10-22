local M = {}

M.url = "https://github.com/Saghen/blink.cmp"

---@type kissaten.HighlightsFn
function M.get(c)
  local ui = c.ui
  -- stylua: ignore
  local hl = {
    BlinkCmpMenu                = { fg = c.fg, bg = ui.bg_popup },
    BlinkCmpMenuBorder          = { fg = ui.border_float, bg = ui.bg_popup },
    BlinkCmpMenuSelection       = { bg = ui.bg_sel, bold = true },
    BlinkCmpScrollBarThumb      = { bg = c.surface2 },
    BlinkCmpScrollBarGutter     = { bg = c.surface0 },
    BlinkCmpLabel               = { fg = c.fg },
    BlinkCmpLabelDeprecated     = { fg = c.overlay0, strikethrough = true },
    BlinkCmpLabelMatch          = { fg = ui.pmenu_match, bold = true },
    BlinkCmpLabelDetail         = { fg = c.comment },
    BlinkCmpLabelDescription    = { fg = c.comment },
    BlinkCmpSource              = { fg = c.overlay0 },
    BlinkCmpGhostText           = { fg = c.comment, italic = true },
    BlinkCmpDoc                 = { fg = c.fg, bg = ui.bg_float },
    BlinkCmpDocBorder           = { fg = ui.border_float, bg = ui.bg_float },
    BlinkCmpDocSeparator        = { fg = c.surface2, bg = ui.bg_float },
    BlinkCmpDocCursorLine       = { bg = ui.bg_sel },
    BlinkCmpSignatureHelp       = { fg = c.fg, bg = ui.bg_float },
    BlinkCmpSignatureHelpBorder = { fg = ui.border_float, bg = ui.bg_float },
    BlinkCmpSignatureHelpActiveParameter = "LspSignatureActiveParameter",
    BlinkCmpKind                = { fg = c.lavender },
    BlinkCmpKindDefault         = { fg = c.subtext },
    BlinkCmpKindCopilot         = { fg = c.teal },
    BlinkCmpKindCodeium         = { fg = c.teal },
    BlinkCmpKindSupermaven      = { fg = c.teal },
    BlinkCmpKindTabNine         = { fg = c.teal },
    BlinkCmpKindAI              = { fg = c.teal },
  }
  return require("kissaten.groups.lsp").kind_groups(hl, "BlinkCmpKind%s")
end

return M
