local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/folke/snacks.nvim"

---@type kissaten.HighlightsFn
function M.get(c, opts)
  local ui = c.ui
  local nbg = opts.transparent and c.none or c.bg
  local function level(color)
    return {
      body = { fg = c.fg, bg = nbg },
      border = { fg = Util.blend(color, c.bg, 0.5), bg = nbg },
      icon = { fg = color },
      title = { fg = color, bold = true },
      footer = { fg = Util.blend(color, c.bg, 0.6) },
    }
  end

  -- stylua: ignore
  local hl = {
    -- picker (LazyVim default)
    SnacksPicker              = "NormalFloat",
    SnacksPickerBorder        = "FloatBorder",
    SnacksPickerTitle         = { fg = c.ui.on_badge, bg = ui.accent, bold = true },
    SnacksPickerInputBorder   = { fg = c.orange, bg = ui.bg_float },
    SnacksPickerInputTitle    = { fg = c.ui.on_badge, bg = c.orange, bold = true },
    SnacksPickerBoxTitle      = { fg = c.ui.on_badge, bg = ui.accent, bold = true },
    SnacksPickerPreviewTitle  = { fg = c.ui.on_badge, bg = c.green, bold = true },
    SnacksPickerListTitle     = { fg = c.ui.on_badge, bg = ui.accent, bold = true },
    SnacksPickerPrompt        = { fg = c.orange },
    SnacksPickerMatch         = { fg = ui.accent, bold = true },
    SnacksPickerSelected      = { fg = c.pink },
    SnacksPickerUnselected    = { fg = c.overlay0 },
    SnacksPickerCursorLine    = { bg = ui.bg_sel },
    SnacksPickerListCursorLine = { bg = ui.bg_sel },
    SnacksPickerDir           = { fg = c.comment },
    SnacksPickerFile          = { fg = c.fg },
    SnacksPickerPathHidden    = { fg = c.overlay0 },
    SnacksPickerPathIgnored   = { fg = c.overlay0, italic = true },
    SnacksPickerTotals        = { fg = c.comment },
    SnacksPickerToggle        = { fg = ui.accent, bg = Util.tint(ui.accent, c.bg, 0.12) },
    SnacksPickerSpinner       = { fg = c.orange },
    SnacksPickerPickWin       = { fg = c.ui.on_badge, bg = ui.accent, bold = true },
    SnacksPickerPickWinCurrent = { fg = c.ui.on_badge, bg = c.pink, bold = true },
    SnacksPickerTree          = { fg = ui.indent },
    SnacksPickerGitStatusAdded     = { fg = c.git.add },
    SnacksPickerGitStatusModified  = { fg = c.git.change },
    SnacksPickerGitStatusDeleted   = { fg = c.git.delete },
    SnacksPickerGitStatusUntracked = { fg = c.git.untracked },
    SnacksPickerGitStatusIgnored   = { fg = c.git.ignore },

    -- explorer (LazyVim default file tree)
    SnacksExplorerNormal      = "NormalSB",

    -- dashboard
    SnacksDashboardNormal     = { fg = c.fg },
    SnacksDashboardHeader     = { fg = ui.accent },
    SnacksDashboardTitle      = { fg = c.purple, bold = true },
    SnacksDashboardIcon       = { fg = c.cyan },
    SnacksDashboardDesc       = { fg = c.fg },
    SnacksDashboardKey        = { fg = c.orange, bold = true },
    SnacksDashboardSpecial    = { fg = c.purple },
    SnacksDashboardFile       = { fg = c.fg },
    SnacksDashboardDir        = { fg = c.comment },
    SnacksDashboardFooter     = { fg = c.comment, italic = true },
    SnacksDashboardTerminal   = { fg = c.subtext },

    -- indent / scope
    SnacksIndent              = { fg = ui.indent, nocombine = true },
    SnacksIndentScope         = { fg = ui.indent_scope, nocombine = true },
    SnacksIndentChunk         = { fg = ui.indent_scope, nocombine = true },

    -- input / win / misc
    SnacksNormal              = "NormalFloat",
    SnacksWinBar              = "Title",
    SnacksBackdrop            = { bg = c.crust },
    SnacksInputIcon           = { fg = ui.accent },
    SnacksInputBorder         = { fg = c.yellow, bg = ui.bg_float },
    SnacksInputTitle          = { fg = c.yellow, bg = ui.bg_float, bold = true },
    SnacksWinKey              = { fg = c.orange },
    SnacksWinKeySep           = { fg = c.overlay0 },
    SnacksWinKeyDesc          = { fg = c.subtext },
    SnacksFooterKey           = { fg = c.ui.on_badge, bg = ui.accent },
    SnacksFooterDesc          = { fg = ui.accent, bg = Util.tint(ui.accent, c.bg, 0.12) },
    SnacksZenIcon             = { fg = c.purple },
    SnacksScratchKey          = { fg = c.orange },
    SnacksScratchDesc         = { fg = c.subtext },
    SnacksStatusColumnMark    = { fg = c.orange, bold = true },
    SnacksWordsCurrent        = "LspReferenceText",
    SnacksImageMath           = { fg = c.cyan },

    -- profiler
    SnacksProfilerIconInfo    = { fg = c.blue, bg = Util.tint(c.blue, c.bg, 0.25) },
    SnacksProfilerBadgeInfo   = { fg = c.blue, bg = Util.tint(c.blue, c.bg, 0.1) },
    SnacksProfilerIconTrace   = { fg = c.comment, bg = Util.tint(c.overlay0, c.bg, 0.25) },
    SnacksProfilerBadgeTrace  = { fg = c.comment, bg = Util.tint(c.overlay0, c.bg, 0.1) },
  }

  for name, color in pairs({
    Error = c.diag.error,
    Warn = c.diag.warn,
    Info = c.diag.info,
    Debug = c.comment,
    Trace = c.purple,
  }) do
    local l = level(color)
    hl["SnacksNotifier" .. name] = l.body
    hl["SnacksNotifierBorder" .. name] = l.border
    hl["SnacksNotifierIcon" .. name] = l.icon
    hl["SnacksNotifierTitle" .. name] = l.title
    hl["SnacksNotifierFooter" .. name] = l.footer
  end
  if opts.borderless then
    local p = ui.picker
    -- snacks derives <Part>, <Part>Border, <Part>Title for each picker part
    for part, bg in pairs({ Input = p.prompt, List = p.list, Preview = p.preview, Box = p.list, [""] = p.list }) do
      hl["SnacksPicker" .. part] = { fg = c.fg, bg = bg }
      hl["SnacksPicker" .. part .. "Border"] = { fg = bg, bg = bg }
    end
    hl.SnacksPickerPrompt = { fg = c.orange, bg = p.prompt }
    hl.SnacksPickerListCursorLine = { bg = p.sel }
    -- the picker box title goes through snacks' generic title group
    hl.SnacksTitle = { fg = ui.on_badge, bg = ui.accent, bold = true }
  end
  hl.SnacksNotifierHistory = "NormalFloat"
  hl.SnacksNotifierHistoryTitle = { fg = ui.accent, bold = true }
  hl.SnacksNotifierHistoryDateTime = { fg = c.comment }

  for i, color in ipairs(c.scopes) do -- follows the `rainbow` option
    hl["SnacksIndent" .. i] = { fg = Util.blend(color, c.bg, 0.4), nocombine = true }
  end
  return hl
end

return M
