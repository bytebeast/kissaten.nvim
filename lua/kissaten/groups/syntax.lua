---@mod kissaten.groups.syntax Legacy :syntax groups (:h group-name)
--- Treesitter and LSP groups link back to these, so changing a role here
--- (or in colors.syn) reaches every language.
local M = {}

---@type kissaten.HighlightsFn
function M.get(c, opts)
  local s = c.syn
  local st = opts.styles

  -- stylua: ignore
  return {
    Comment        = { fg = s.comment, style = st.comments },
    SpecialComment = { fg = s.comment, style = st.comments },

    Constant       = { fg = s.constant, style = st.constants },
    String         = { fg = s.string, style = st.strings },
    Character      = { fg = s.character },
    Number         = { fg = s.number },
    Float          = "Number",
    Boolean        = { fg = s.boolean },

    Identifier     = { fg = s.variable, style = st.variables },
    Function       = { fg = s.func, style = st.functions },

    Statement      = { fg = s.keyword, style = st.keywords },
    Conditional    = { fg = s.keyword_flow, style = st.keywords },
    Repeat         = { fg = s.keyword_flow, style = st.keywords },
    Label          = { fg = s.label },
    Operator       = { fg = s.operator },
    Keyword        = { fg = s.keyword, style = st.keywords },
    Exception      = { fg = s.keyword_exception, style = st.keywords },

    PreProc        = { fg = s.preproc },
    Include        = { fg = s.keyword_import, style = st.keywords },
    Define         = { fg = s.macro },
    Macro          = { fg = s.macro },
    PreCondit      = { fg = s.preproc },

    Type           = { fg = s.type, style = st.types },
    StorageClass   = { fg = s.keyword, style = st.keywords },
    Structure      = { fg = s.type, style = st.types },
    Typedef        = { fg = s.type, style = st.types },

    Special        = { fg = s.special },
    SpecialChar    = { fg = s.escape },
    Tag            = { fg = s.tag },
    Delimiter      = { fg = s.punct },
    Debug          = { fg = c.orange },

    Underlined     = { underline = true },
    Bold           = { bold = true },
    Italic         = { italic = true },
    Ignore         = { fg = c.overlay0 },
    Error          = { fg = c.diag.error },
    Todo           = { fg = c.crust, bg = c.yellow, bold = true },

    -- a few filetypes whose legacy syntax is still common
    htmlH1         = { fg = c.rainbow[1], bold = true },
    htmlH2         = { fg = c.rainbow[2], bold = true },
    markdownCode   = { fg = c.teal },
    markdownCodeBlock = { fg = c.teal },
    markdownH1     = { fg = c.rainbow[1], bold = true },
    markdownH2     = { fg = c.rainbow[2], bold = true },
    markdownLinkText = { fg = c.blue, underline = true },
    dosIniLabel    = { fg = s.property },
    gitcommitSummary = { fg = c.fg, bold = true },
  }
end

return M
