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
