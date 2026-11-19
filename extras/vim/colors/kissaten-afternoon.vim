" Kissaten Afternoon for Vim (8.2+ with termguicolors, or gVim)
" upstream: https://github.com/bytebeast/kissaten.nvim
set background=dark
hi clear
if exists("syntax_on") | syntax reset | endif
let g:colors_name = "kissaten-afternoon"

hi Added guifg=#a9d881 gui=NONE cterm=NONE
hi Bold gui=bold cterm=NONE
hi Boolean guifg=#f3a06c gui=NONE cterm=NONE
hi Changed guifg=#e8c47e gui=NONE cterm=NONE
hi Character guifg=#a9d881 gui=NONE cterm=NONE
hi ColorColumn guibg=#212435 gui=NONE cterm=NONE
hi Comment guifg=#8890b6 gui=italic cterm=NONE
hi ComplHint guifg=#8890b6 gui=NONE cterm=NONE
hi ComplHintMore guifg=#8890b6 gui=NONE cterm=NONE
hi ComplMatchIns guifg=#8890b6 gui=NONE cterm=NONE
hi Conceal guifg=#8890b6 gui=NONE cterm=NONE
hi Conditional guifg=#c6a0f6 gui=italic cterm=NONE
hi Constant guifg=#f3a06c gui=NONE cterm=NONE
hi! link CurSearch IncSearch
hi Cursor guifg=#282b3e guibg=#cdd5f6 gui=NONE cterm=NONE
hi CursorColumn guibg=#31354b gui=NONE cterm=NONE
hi! link CursorIM Cursor
hi CursorLine guibg=#31354b gui=NONE cterm=NONE
hi CursorLineFold guifg=#8890b6 gui=NONE cterm=NONE
hi CursorLineNr guifg=#f3a06c gui=bold cterm=NONE
hi CursorLineSign guibg=NONE gui=NONE cterm=NONE
hi Debug guifg=#f3a06c gui=NONE cterm=NONE
hi Define guifg=#f4b8e4 gui=NONE cterm=NONE
hi Delimiter guifg=#b0b9dd gui=NONE cterm=NONE
hi DiagnosticDeprecated guisp=#6a7194 gui=strikethrough cterm=NONE
hi DiagnosticError guifg=#f690ac gui=NONE cterm=NONE
hi DiagnosticFloatingError guifg=#f690ac gui=NONE cterm=NONE
hi DiagnosticFloatingHint guifg=#7fd3c4 gui=NONE cterm=NONE
hi DiagnosticFloatingInfo guifg=#abd6ee gui=NONE cterm=NONE
hi DiagnosticFloatingOk guifg=#a9d881 gui=NONE cterm=NONE
hi DiagnosticFloatingWarn guifg=#e8c47e gui=NONE cterm=NONE
hi DiagnosticHint guifg=#7fd3c4 gui=NONE cterm=NONE
hi DiagnosticInfo guifg=#abd6ee gui=NONE cterm=NONE
hi DiagnosticOk guifg=#a9d881 gui=NONE cterm=NONE
hi DiagnosticSignError guifg=#f690ac gui=NONE cterm=NONE
hi DiagnosticSignHint guifg=#7fd3c4 gui=NONE cterm=NONE
hi DiagnosticSignInfo guifg=#abd6ee gui=NONE cterm=NONE
hi DiagnosticSignOk guifg=#a9d881 gui=NONE cterm=NONE
hi DiagnosticSignWarn guifg=#e8c47e gui=NONE cterm=NONE
hi DiagnosticUnderlineError guisp=#f690ac gui=undercurl cterm=NONE
hi DiagnosticUnderlineHint guisp=#7fd3c4 gui=undercurl cterm=NONE
hi DiagnosticUnderlineInfo guisp=#abd6ee gui=undercurl cterm=NONE
hi DiagnosticUnderlineOk guisp=#a9d881 gui=undercurl cterm=NONE
hi DiagnosticUnderlineWarn guisp=#e8c47e gui=undercurl cterm=NONE
hi DiagnosticUnnecessary guifg=#6a7194 gui=italic cterm=NONE
hi DiagnosticVirtualLinesError guifg=#f690ac gui=NONE cterm=NONE
hi DiagnosticVirtualLinesHint guifg=#7fd3c4 gui=NONE cterm=NONE
hi DiagnosticVirtualLinesInfo guifg=#abd6ee gui=NONE cterm=NONE
hi DiagnosticVirtualLinesWarn guifg=#e8c47e gui=NONE cterm=NONE
hi DiagnosticVirtualTextError guifg=#f690ac guibg=#383347 gui=NONE cterm=NONE
hi DiagnosticVirtualTextHint guifg=#7fd3c4 guibg=#2f3849 gui=NONE cterm=NONE
hi DiagnosticVirtualTextInfo guifg=#abd6ee guibg=#32394c gui=NONE cterm=NONE
hi DiagnosticVirtualTextOk guifg=#a9d881 guibg=#323943 gui=NONE cterm=NONE
hi DiagnosticVirtualTextWarn guifg=#e8c47e guibg=#373743 gui=NONE cterm=NONE
hi DiagnosticWarn guifg=#e8c47e gui=NONE cterm=NONE
hi DiffAdd guibg=#3a4445 gui=NONE cterm=NONE
hi DiffChange guibg=#323851 gui=NONE cterm=NONE
hi DiffDelete guifg=#a46880 guibg=#4d3d52 gui=NONE cterm=NONE
hi DiffText guibg=#344165 guisp=#89aefe gui=underline cterm=NONE
hi DiffTextAdd guibg=#364638 guisp=#a9d881 gui=underline cterm=NONE
hi Directory guifg=#89aefe gui=NONE cterm=NONE
hi EndOfBuffer guifg=#282b3e gui=NONE cterm=NONE
hi Error guifg=#f690ac gui=NONE cterm=NONE
hi ErrorMsg guifg=#f690ac gui=NONE cterm=NONE
hi Exception guifg=#f690ac gui=italic cterm=NONE
hi! link Float Number
hi FloatBorder guifg=#5d73a8 guibg=#212435 gui=NONE cterm=NONE
hi FloatFooter guifg=#b0b9dd guibg=#212435 gui=NONE cterm=NONE
hi FloatShadow guibg=#1a1c2a gui=NONE cterm=NONE
hi FloatShadowThrough guibg=#1a1c2a gui=NONE cterm=NONE
hi FloatTitle guifg=#89aefe guibg=#212435 gui=bold cterm=NONE
hi FoldColumn guifg=#8890b6 guibg=#282b3e gui=NONE cterm=NONE
hi Folded guifg=#89aefe guibg=#232536 gui=NONE cterm=NONE
hi Function guifg=#89aefe gui=NONE cterm=NONE
hi Identifier guifg=#cdd5f6 gui=NONE cterm=NONE
hi Ignore guifg=#6a7194 gui=NONE cterm=NONE
hi IncSearch guifg=#1a1c2a guibg=#f3a06c gui=bold cterm=NONE
hi Include guifg=#f4b8e4 gui=italic cterm=NONE
hi Italic gui=italic cterm=NONE
hi Keyword guifg=#c6a0f6 gui=italic cterm=NONE
hi Label guifg=#abd6ee gui=NONE cterm=NONE
hi LineNr guifg=#6a7194 gui=NONE cterm=NONE
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi LspCodeLens guifg=#8890b6 gui=italic cterm=NONE
hi LspCodeLensSeparator guifg=#6a7194 gui=NONE cterm=NONE
hi! link LspInfoBorder FloatBorder
hi! link LspInfoTitle Title
hi LspInlayHint guifg=#8890b6 guibg=#2d3146 gui=italic cterm=NONE
hi LspKindArray guifg=#b0b9dd gui=NONE cterm=NONE
hi! link LspKindBoolean Boolean
hi! link LspKindClass Type
hi! link LspKindColor Special
hi! link LspKindConstant Constant
hi LspKindConstructor guifg=#e8c47e gui=NONE cterm=NONE
hi! link LspKindEnum Type
hi! link LspKindEnumMember Constant
hi! link LspKindEvent Special
hi LspKindField guifg=#7fd3c4 gui=NONE cterm=NONE
hi! link LspKindFile Normal
hi! link LspKindFolder Directory
hi! link LspKindFunction Function
hi LspKindInterface guifg=#e8c47e gui=italic cterm=NONE
hi LspKindKey guifg=#7fd3c4 gui=NONE cterm=NONE
hi! link LspKindKeyword Keyword
hi! link LspKindMethod Function
hi LspKindModule guifg=#b5bff8 gui=NONE cterm=NONE
hi LspKindNamespace guifg=#b5bff8 gui=NONE cterm=NONE
hi LspKindNull guifg=#f3a06c gui=NONE cterm=NONE
hi! link LspKindNumber Number
hi! link LspKindObject Constant
hi! link LspKindOperator Operator
hi LspKindPackage guifg=#b5bff8 gui=NONE cterm=NONE
hi LspKindProperty guifg=#7fd3c4 gui=NONE cterm=NONE
hi LspKindReference guifg=#7fd3c4 gui=NONE cterm=NONE
hi LspKindSnippet guifg=#7fd3c4 gui=NONE cterm=NONE
hi! link LspKindString String
hi! link LspKindStruct Type
hi LspKindText gui=NONE cterm=NONE
hi LspKindTypeParameter guifg=#e8c47e gui=italic cterm=NONE
hi! link LspKindUnit Type
hi! link LspKindValue String
hi LspKindVariable guifg=#cdd5f6 gui=NONE cterm=NONE
hi LspReferenceRead guibg=#3c4159 gui=NONE cterm=NONE
hi LspReferenceTarget guibg=#3c4159 gui=bold cterm=NONE
hi LspReferenceText guibg=#3c4159 gui=NONE cterm=NONE
hi LspReferenceWrite guibg=#5a4e67 gui=NONE cterm=NONE
hi LspSignatureActiveParameter guifg=#f3a06c guibg=#3c4159 gui=bold cterm=NONE
hi Macro guifg=#f4b8e4 gui=NONE cterm=NONE
hi MatchParen guifg=#f3a06c guibg=#4a506b gui=bold cterm=NONE
hi ModeMsg guifg=#b0b9dd gui=bold cterm=NONE
hi MoreMsg guifg=#89aefe gui=NONE cterm=NONE
hi MsgArea guifg=#b0b9dd gui=NONE cterm=NONE
hi MsgSeparator guifg=#464b65 guibg=#212435 gui=NONE cterm=NONE
hi NonText guifg=#606787 gui=NONE cterm=NONE
hi Normal guifg=#cdd5f6 guibg=#282b3e gui=NONE cterm=NONE
hi NormalFloat guifg=#cdd5f6 guibg=#212435 gui=NONE cterm=NONE
hi NormalNC guifg=#cdd5f6 guibg=#282b3e gui=NONE cterm=NONE
hi NormalSB guifg=#b0b9dd guibg=#212435 gui=NONE cterm=NONE
hi Number guifg=#f3a06c gui=NONE cterm=NONE
hi OkMsg guifg=#a9d881 gui=NONE cterm=NONE
hi Operator guifg=#abd6ee gui=NONE cterm=NONE
hi Pmenu guifg=#cdd5f6 guibg=#212435 gui=NONE cterm=NONE
hi PmenuBorder guifg=#5d73a8 guibg=#212435 gui=NONE cterm=NONE
hi PmenuExtra guifg=#8890b6 guibg=#212435 gui=NONE cterm=NONE
hi PmenuExtraSel guifg=#8890b6 guibg=#3c4159 gui=NONE cterm=NONE
hi PmenuKind guifg=#b5bff8 guibg=#212435 gui=NONE cterm=NONE
hi PmenuKindSel guifg=#b5bff8 guibg=#3c4159 gui=NONE cterm=NONE
hi PmenuMatch guifg=#89aefe guibg=#212435 gui=bold cterm=NONE
hi PmenuMatchSel guifg=#89aefe guibg=#3c4159 gui=bold cterm=NONE
hi PmenuSbar guibg=#31354b gui=NONE cterm=NONE
hi PmenuSel guibg=#3c4159 gui=bold cterm=NONE
hi PmenuThumb guibg=#4a506b gui=NONE cterm=NONE
hi PreCondit guifg=#f4b8e4 gui=NONE cterm=NONE
hi PreProc guifg=#f4b8e4 gui=NONE cterm=NONE
hi Question guifg=#89aefe gui=NONE cterm=NONE
hi QuickFixLine guibg=#374260 gui=bold cterm=NONE
hi Removed guifg=#f690ac gui=NONE cterm=NONE
hi Repeat guifg=#c6a0f6 gui=italic cterm=NONE
hi Search guifg=#cdd5f6 guibg=#524d4c gui=NONE cterm=NONE
hi SignColumn guifg=#6a7194 guibg=#282b3e gui=NONE cterm=NONE
hi SignColumnSB guifg=#6a7194 guibg=#212435 gui=NONE cterm=NONE
hi SnippetTabstop guibg=#3d415a gui=NONE cterm=NONE
hi SnippetTabstopActive guibg=#4b506d gui=NONE cterm=NONE
hi Special guifg=#7fd1f0 gui=NONE cterm=NONE
hi SpecialChar guifg=#f4b8e4 gui=NONE cterm=NONE
hi SpecialComment guifg=#8890b6 gui=italic cterm=NONE
hi SpecialKey guifg=#606787 gui=NONE cterm=NONE
hi SpellBad guisp=#f690ac gui=undercurl cterm=NONE
hi SpellCap guisp=#e8c47e gui=undercurl cterm=NONE
hi SpellLocal guisp=#abd6ee gui=undercurl cterm=NONE
hi SpellRare guisp=#7fd3c4 gui=undercurl cterm=NONE
hi Statement guifg=#c6a0f6 gui=italic cterm=NONE
hi StatusLine guifg=#b0b9dd guibg=#212435 gui=NONE cterm=NONE
hi StatusLineNC guifg=#8890b6 guibg=#212435 gui=NONE cterm=NONE
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link StderrMsg ErrorMsg
hi StdoutMsg guifg=#b0b9dd gui=NONE cterm=NONE
hi StorageClass guifg=#c6a0f6 gui=italic cterm=NONE
hi String guifg=#a9d881 gui=NONE cterm=NONE
hi Structure guifg=#e8c47e gui=NONE cterm=NONE
hi Substitute guifg=#1a1c2a guibg=#f690ac gui=NONE cterm=NONE
hi TabLine guifg=#8890b6 guibg=#212435 gui=NONE cterm=NONE
hi TabLineFill guibg=#1a1c2a gui=NONE cterm=NONE
hi TabLineSel guifg=#1a1c2a guibg=#89aefe gui=bold cterm=NONE
hi Tag guifg=#f690ac gui=NONE cterm=NONE
hi TermCursor guifg=#282b3e guibg=#cdd5f6 gui=NONE cterm=NONE
hi TermCursorNC guifg=#282b3e guibg=#6a7194 gui=NONE cterm=NONE
hi Title guifg=#89aefe gui=bold cterm=NONE
hi Todo guifg=#1a1c2a guibg=#e8c47e gui=bold cterm=NONE
hi Type guifg=#e8c47e gui=NONE cterm=NONE
hi Typedef guifg=#e8c47e gui=NONE cterm=NONE
hi Underlined gui=underline cterm=NONE
hi VertSplit guifg=#464b65 gui=NONE cterm=NONE
hi Visual guibg=#374260 gui=NONE cterm=NONE
hi VisualNOS guibg=#374260 gui=NONE cterm=NONE
hi WarningMsg guifg=#e8c47e gui=NONE cterm=NONE
hi Whitespace guifg=#565c7a gui=NONE cterm=NONE
hi WildMenu guibg=#3c4159 gui=NONE cterm=NONE
hi WinBar guifg=#b0b9dd guibg=#282b3e gui=NONE cterm=NONE
hi WinBarNC guifg=#8890b6 guibg=#282b3e gui=NONE cterm=NONE
hi WinSeparator guifg=#464b65 gui=bold cterm=NONE
hi debugBreakpoint guifg=#f690ac guibg=#473a4f gui=NONE cterm=NONE
hi debugPC guibg=#373f5b gui=NONE cterm=NONE
hi diffAdded guifg=#a9d881 gui=NONE cterm=NONE
hi diffChanged guifg=#e8c47e gui=NONE cterm=NONE
hi diffFile guifg=#89aefe gui=bold cterm=NONE
hi diffIndexLine guifg=#c6a0f6 gui=NONE cterm=NONE
hi diffLine guifg=#8890b6 gui=NONE cterm=NONE
hi diffNewFile guifg=#a9d881 gui=italic cterm=NONE
hi diffOldFile guifg=#f690ac gui=italic cterm=NONE
hi diffRemoved guifg=#f690ac gui=NONE cterm=NONE
hi dosIniLabel guifg=#7fd3c4 gui=NONE cterm=NONE
hi gitcommitSummary guifg=#cdd5f6 gui=bold cterm=NONE
hi healthError guifg=#f690ac gui=NONE cterm=NONE
hi healthSuccess guifg=#a9d881 gui=NONE cterm=NONE
hi healthWarning guifg=#e8c47e gui=NONE cterm=NONE
hi helpCommand guifg=#89aefe guibg=#31354b gui=NONE cterm=NONE
hi helpExample guifg=#8890b6 gui=NONE cterm=NONE
hi htmlH1 guifg=#89aefe gui=bold cterm=NONE
hi htmlH2 guifg=#e8c47e gui=bold cterm=NONE
hi! link lCursor Cursor
hi markdownCode guifg=#7fd3c4 gui=NONE cterm=NONE
hi markdownCodeBlock guifg=#7fd3c4 gui=NONE cterm=NONE
hi markdownH1 guifg=#89aefe gui=bold cterm=NONE
hi markdownH2 guifg=#e8c47e gui=bold cterm=NONE
hi markdownLinkText guifg=#89aefe gui=underline cterm=NONE
hi qfFileName guifg=#89aefe gui=NONE cterm=NONE
hi qfLineNr guifg=#8890b6 gui=NONE cterm=NONE

let g:terminal_ansi_colors = ["#3c4159", "#f690ac", "#a9d881", "#e8c47e", "#89aefe", "#f4b8e4", "#7fd3c4", "#b0b9dd", "#6a7194", "#faa5bd", "#b6e291", "#efcf90", "#a2bfff", "#d4b5fa", "#93dbf6", "#cdd5f6"]
