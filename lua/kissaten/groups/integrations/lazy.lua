local M = {}

M.url = "https://github.com/folke/lazy.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    LazyNormal          = { fg = c.fg, bg = c.ui.bg_float },
    LazyH1              = { fg = c.ui.on_badge, bg = c.ui.accent, bold = true },
    LazyH2              = { fg = c.ui.accent, bold = true },
    LazyButton          = { fg = c.subtext, bg = c.surface0 },
    LazyButtonActive    = { fg = c.ui.on_badge, bg = c.orange, bold = true },
    LazySpecial         = { fg = c.cyan },
    LazyReasonPlugin    = { fg = c.purple },
    LazyReasonEvent     = { fg = c.yellow },
    LazyReasonKeys      = { fg = c.teal },
    LazyReasonCmd       = { fg = c.orange },
    LazyReasonFt        = { fg = c.blue },
    LazyReasonStart     = { fg = c.green },
    LazyReasonSource    = { fg = c.lavender },
    LazyReasonImport    = { fg = c.pink },
    LazyReasonRuntime   = { fg = c.sky },
    LazyCommit          = { fg = c.pink },
    LazyCommitType      = { fg = c.purple },
    LazyCommitScope     = { fg = c.teal, italic = true },
    LazyDimmed          = { fg = c.comment },
    LazyProp            = { fg = c.comment },
    LazyValue           = { fg = c.green },
    LazyUrl             = { fg = c.teal, underline = true },
    LazyProgressDone    = { fg = c.ui.accent, bold = true },
    LazyProgressTodo    = { fg = c.surface2 },
  }
end

return M
