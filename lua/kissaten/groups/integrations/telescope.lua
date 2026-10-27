local M = {}

M.url = "https://github.com/nvim-telescope/telescope.nvim"

---@type kissaten.HighlightsFn
function M.get(c, opts)
  local fbg = c.ui.bg_float
  -- stylua: ignore
  local hl = {
    TelescopeNormal         = { fg = c.fg, bg = fbg },
    TelescopeBorder         = { fg = c.ui.border_float, bg = fbg },
    TelescopeTitle          = { fg = c.ui.on_badge, bg = c.ui.accent, bold = true },
    TelescopePromptNormal   = { fg = c.fg, bg = fbg },
    TelescopePromptBorder   = { fg = c.orange, bg = fbg },
    TelescopePromptTitle    = { fg = c.ui.on_badge, bg = c.orange, bold = true },
    TelescopePromptPrefix   = { fg = c.orange, bg = fbg },
    TelescopePromptCounter  = { fg = c.comment },
    TelescopePreviewTitle   = { fg = c.ui.on_badge, bg = c.green, bold = true },
    TelescopeResultsTitle   = { fg = c.ui.on_badge, bg = c.ui.accent, bold = true },
    TelescopeSelection      = { bg = c.ui.bg_sel, bold = true },
    TelescopeSelectionCaret = { fg = c.pink, bg = c.ui.bg_sel },
    TelescopeMultiSelection = { fg = c.pink },
    TelescopeMultiIcon      = { fg = c.pink },
    TelescopeMatching       = { fg = c.ui.accent, bold = true },
    TelescopeResultsComment = { fg = c.comment },
    -- results columns (symbols, git status) and the preview/file-browser
    -- columns (permissions, size, date)
    TelescopeResultsClass     = "@type",
    TelescopeResultsConstant  = "@constant",
    TelescopeResultsField     = "@variable.member",
    TelescopeResultsFunction  = "@function",
    TelescopeResultsMethod    = "@function.method",
    TelescopeResultsOperator  = "@operator",
    TelescopeResultsStruct    = "@type",
    TelescopeResultsVariable  = "@variable",
    TelescopeResultsIdentifier = "@variable",
    TelescopeResultsNumber    = "@number",
    TelescopeResultsLineNr    = { fg = c.ui.fg_gutter },
    TelescopeResultsSpecialComment = { fg = c.comment, italic = true },
    TelescopeResultsDiffAdd   = { fg = c.git.add },
    TelescopeResultsDiffChange = { fg = c.git.change },
    TelescopeResultsDiffDelete = { fg = c.git.delete },
    TelescopeResultsDiffUntracked = { fg = c.git.untracked },
    TelescopePreviewLine      = { bg = c.ui.bg_cursorline },
    TelescopePreviewMatch     = { bg = c.ui.bg_search },
    TelescopePreviewMessage   = { fg = c.comment },
    TelescopePreviewMessageFillchar = { fg = c.surface1 },
    TelescopePreviewDirectory = { fg = c.blue },
    TelescopePreviewLink      = { fg = c.teal },
    TelescopePreviewPipe      = { fg = c.purple },
    TelescopePreviewSocket    = { fg = c.pink },
    TelescopePreviewCharDev   = { fg = c.orange },
    TelescopePreviewBlock     = { fg = c.orange },
    TelescopePreviewSticky    = { fg = c.cyan },
    TelescopePreviewRead      = { fg = c.yellow },
    TelescopePreviewWrite     = { fg = c.red },
    TelescopePreviewExecute   = { fg = c.green },
    TelescopePreviewHyphen    = { fg = c.comment },
    TelescopePreviewSize      = { fg = c.green },
    TelescopePreviewUser      = { fg = c.yellow },
    TelescopePreviewGroup     = { fg = c.yellow },
    TelescopePreviewDate      = { fg = c.blue },
  }
  if opts.borderless then
    local p = c.ui.picker
    local function panel(bg)
      return { fg = c.fg, bg = bg }, { fg = bg, bg = bg }
    end
    hl.TelescopeNormal, hl.TelescopeBorder = panel(p.list)
    hl.TelescopePromptNormal, hl.TelescopePromptBorder = panel(p.prompt)
    hl.TelescopeResultsNormal, hl.TelescopeResultsBorder = panel(p.list)
    hl.TelescopePreviewNormal, hl.TelescopePreviewBorder = panel(p.preview)
    hl.TelescopePromptPrefix = { fg = c.orange, bg = p.prompt }
    hl.TelescopePromptCounter = { fg = c.comment, bg = p.prompt }
    hl.TelescopeSelection = { bg = p.sel, bold = true }
    hl.TelescopeSelectionCaret = { fg = c.pink, bg = p.sel }
  end
  return hl
end

return M
