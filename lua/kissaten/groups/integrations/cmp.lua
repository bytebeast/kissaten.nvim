local M = {}

M.url = "https://github.com/hrsh7th/nvim-cmp"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  local hl = {
    CmpDocumentation       = { fg = c.fg, bg = c.ui.bg_float },
    CmpDocumentationBorder = { fg = c.ui.border_float, bg = c.ui.bg_float },
    CmpGhostText           = { fg = c.comment, italic = true },
    CmpItemAbbr            = { fg = c.fg },
    CmpItemAbbrDeprecated  = { fg = c.overlay0, strikethrough = true },
    CmpItemAbbrMatch       = { fg = c.ui.pmenu_match, bold = true },
    CmpItemAbbrMatchFuzzy  = { fg = c.ui.pmenu_match },
    CmpItemMenu            = { fg = c.comment },
    CmpItemKindDefault     = { fg = c.subtext },
    CmpItemKindCopilot     = { fg = c.teal },
    CmpItemKindCodeium     = { fg = c.teal },
    CmpItemKindSupermaven  = { fg = c.teal },
    CmpItemKindTabNine     = { fg = c.teal },
  }
  return require("kissaten.groups.lsp").kind_groups(hl, "CmpItemKind%s")
end

return M
