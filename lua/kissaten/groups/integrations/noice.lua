local M = {}

M.url = "https://github.com/folke/noice.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  local hl = {
    NoiceCmdline                 = { fg = c.fg },
    NoiceCmdlineIcon             = { fg = c.ui.accent },
    NoiceCmdlineIconSearch       = { fg = c.yellow },
    NoiceCmdlineIconLua          = { fg = c.blue },
    NoiceCmdlineIconInput        = { fg = c.green },
    NoiceCmdlinePopup            = { fg = c.fg, bg = c.ui.bg_float },
    NoiceCmdlinePopupBorder      = { fg = c.ui.accent, bg = c.ui.bg_float },
    NoiceCmdlinePopupTitle       = { fg = c.ui.accent, bold = true },
    NoiceCmdlinePopupBorderSearch = { fg = c.yellow, bg = c.ui.bg_float },
    NoiceCmdlinePopupBorderLua   = { fg = c.blue, bg = c.ui.bg_float },
    NoiceCmdlinePopupBorderInput = { fg = c.green, bg = c.ui.bg_float },
    NoiceCmdlinePopupTitleInput  = { fg = c.green, bold = true },
    NoiceConfirmBorder           = { fg = c.orange },
    NoicePopupmenuBorder         = "FloatBorder",
    NoiceMini                    = { fg = c.subtext, bg = c.mantle },
    NoiceLspProgressTitle        = { fg = c.comment },
    NoiceLspProgressClient       = { fg = c.ui.accent, bold = true },
    NoiceLspProgressSpinner      = { fg = c.orange },
    NoiceFormatProgressDone      = { fg = c.ui.on_badge, bg = c.green },
    NoiceFormatProgressTodo      = { fg = c.subtext, bg = c.surface0 },
    NoiceVirtualText             = { fg = c.yellow },
    NoiceCompletionItemKindDefault = { fg = c.subtext },
  }
  return require("kissaten.groups.lsp").kind_groups(hl, "NoiceCompletionItemKind%s")
end

return M
