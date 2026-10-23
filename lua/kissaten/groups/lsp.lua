---@mod kissaten.groups.lsp Diagnostics, LSP UI and completion kinds
local Util = require("kissaten.util")

local M = {}

--- LSP/completion kind -> highlight it should look like. Shared by every
--- completion and outline integration so icons always match the code.
M.kinds = {
  Array = "@punctuation.bracket",
  Boolean = "@boolean",
  Class = "@type",
  Color = "Special",
  Constant = "@constant",
  Constructor = "@constructor",
  Enum = "@type",
  EnumMember = "@constant",
  Event = "Special",
  Field = "@variable.member",
  File = "Normal",
  Folder = "Directory",
  Function = "@function",
  Interface = "@lsp.type.interface",
  Key = "@variable.member",
  Keyword = "@keyword",
  Method = "@function.method",
  Module = "@module",
  Namespace = "@module",
  Null = "@constant.builtin",
  Number = "@number",
  Object = "@constant",
  Operator = "@operator",
  Package = "@module",
  Property = "@property",
  Reference = "@markup.link",
  Snippet = "@markup.link",
  String = "@string",
  Struct = "@type",
  Text = "@markup",
  TypeParameter = "@lsp.type.typeParameter",
  Unit = "@type",
  Value = "@string",
  Variable = "@variable",
}

--- Add `<prefix><Kind>` groups (e.g. "BlinkCmpKind%s") linking to LspKind<Kind>.
---@param hl kissaten.Highlights
---@param pattern string
function M.kind_groups(hl, pattern)
  for kind in pairs(M.kinds) do
    hl[pattern:format(kind)] = "LspKind" .. kind
  end
  return hl
end

---@type kissaten.HighlightsFn
function M.get(c)
  local d = c.diag
  local function vt(color)
    return { fg = color, bg = Util.tint(color, c.bg, c.light and 0.1 or 0.08) }
  end

  -- stylua: ignore
  local hl = {
    DiagnosticError            = { fg = d.error },
    DiagnosticWarn             = { fg = d.warn },
    DiagnosticInfo             = { fg = d.info },
    DiagnosticHint             = { fg = d.hint },
    DiagnosticOk               = { fg = d.ok },
    DiagnosticVirtualTextError = vt(d.error),
    DiagnosticVirtualTextWarn  = vt(d.warn),
    DiagnosticVirtualTextInfo  = vt(d.info),
    DiagnosticVirtualTextHint  = vt(d.hint),
    DiagnosticVirtualTextOk    = vt(d.ok),
    DiagnosticVirtualLinesError = { fg = d.error },
    DiagnosticVirtualLinesWarn = { fg = d.warn },
    DiagnosticVirtualLinesInfo = { fg = d.info },
    DiagnosticVirtualLinesHint = { fg = d.hint },
    DiagnosticUnderlineError   = { undercurl = true, sp = d.error },
    DiagnosticUnderlineWarn    = { undercurl = true, sp = d.warn },
    DiagnosticUnderlineInfo    = { undercurl = true, sp = d.info },
    DiagnosticUnderlineHint    = { undercurl = true, sp = d.hint },
    DiagnosticUnderlineOk      = { undercurl = true, sp = d.ok },
    DiagnosticFloatingError    = { fg = d.error },
    DiagnosticFloatingWarn     = { fg = d.warn },
    DiagnosticFloatingInfo     = { fg = d.info },
    DiagnosticFloatingHint     = { fg = d.hint },
    DiagnosticFloatingOk       = { fg = d.ok },
    DiagnosticSignError        = { fg = d.error },
    DiagnosticSignWarn         = { fg = d.warn },
    DiagnosticSignInfo         = { fg = d.info },
    DiagnosticSignHint         = { fg = d.hint },
    DiagnosticSignOk           = { fg = d.ok },
    DiagnosticUnnecessary      = { fg = c.syn.deprecated, italic = true },
    DiagnosticDeprecated       = { strikethrough = true, sp = c.syn.deprecated },

    LspReferenceText           = { bg = c.surface1 },
    LspReferenceRead           = { bg = c.surface1 },
    LspReferenceWrite          = { bg = c.surface1, underline = true, sp = c.orange },
    LspReferenceTarget         = { bg = c.surface1, bold = true },
    LspInlayHint               = { fg = c.comment, bg = Util.blend(c.surface0, c.bg, 0.6), italic = true },
    LspCodeLens                = { fg = c.comment, italic = true },
    LspCodeLensSeparator       = { fg = c.overlay0 },
    LspSignatureActiveParameter = { fg = c.orange, bg = c.surface1, bold = true },
    LspInfoBorder              = "FloatBorder",
    LspInfoTitle               = "Title",
  }

  for kind, link in pairs(M.kinds) do
    hl["LspKind" .. kind] = link
  end
  return hl
end

return M
