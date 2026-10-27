local M = {}

M.url = "https://github.com/nvimdev/lspsaga.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  local ui, d = c.ui, c.diag
  -- stylua: ignore
  local hl = {
    SagaNormal           = { fg = c.fg, bg = ui.bg_float },
    SagaBorder           = { fg = ui.border_float, bg = ui.bg_float },
    SagaTitle            = { fg = ui.title, bold = true },
    SagaToggle           = { fg = c.overlay0 },
    SagaBeacon           = { bg = c.pink },
    SagaVirtLine         = { fg = c.surface2 },
    SagaSpinnerTitle     = { fg = c.purple, bold = true },
    SagaSpinner          = { fg = c.purple },
    SagaText             = { fg = c.comment },
    SagaSelect           = { fg = c.green },
    SagaSearch           = "Search",
    SagaFinderFname      = { fg = c.blue },
    SagaDetail           = { fg = c.comment },
    SagaInCurrent        = { fg = c.purple },
    SagaCount            = { fg = ui.on_badge, bg = ui.accent, bold = true },
    SagaSep              = { fg = c.overlay0 },
    SagaLightBulb        = { fg = c.yellow },
    SagaImpIcon          = { fg = c.pink },
    SagaButton           = { fg = d.hint },
    SagaActionTitle      = { fg = ui.on_badge, bg = ui.accent, bold = true },
    SagaFileName         = { fg = c.fg, bold = true },
    SagaFolderName       = { fg = c.comment },
    SagaFolder           = { fg = c.blue },
    SagaWinbarSep        = { fg = c.overlay0 },
    SagaWinbarFileName   = { fg = c.fg, bold = true },
    SagaWinbarFolderName = { fg = c.comment },
    SagaWinbarFolder     = { fg = c.blue },
    ActionPreviewNormal  = "SagaNormal",
    ActionPreviewBorder  = "SagaBorder",
    ActionPreviewTitle   = { fg = ui.title, bold = true },
    CodeActionText       = { fg = c.fg },
    CodeActionNumber     = { fg = c.orange },
    CodeActionCursorLine = { bg = ui.bg_sel },
    HoverNormal          = "SagaNormal",
    RenameBorder         = "SagaBorder",
    RenameNormal         = { fg = c.orange, bg = ui.bg_float },
    RenameMatch          = "IncSearch",
    DiagnosticBorder     = "SagaBorder",
    DiagnosticNormal     = "SagaNormal",
    DiagnosticShowNormal = "SagaNormal",
    DiagnosticShowBorder = "SagaBorder",
    TerminalBorder       = "SagaBorder",
    TerminalNormal       = "SagaNormal",
  }
  -- `DiagnosticErrorReverse` etc.: a severity-colored badge
  for name, color in pairs({ Error = d.error, Warn = d.warn, Info = d.info, Hint = d.hint }) do
    hl["Diagnostic" .. name .. "Reverse"] = { fg = ui.on_badge, bg = color }
  end
  -- outline / finder kind icons match the code they stand for; lspsaga's own
  -- `SagaText` and `SagaFolder` (set above) win over the kinds of that name
  local kinds = require("kissaten.groups.lsp").kind_groups({
    SagaTypeAlias = "LspKindStruct",
    SagaParameter = "@variable.parameter",
    SagaStaticMethod = "LspKindMethod",
    SagaMacro = "@function.macro",
  }, "Saga%s")
  return vim.tbl_extend("keep", hl, kinds)
end

return M
