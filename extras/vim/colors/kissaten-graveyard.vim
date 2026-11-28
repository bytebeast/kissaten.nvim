" Kissaten Graveyard for Vim (8.2+ with termguicolors, or gVim)
" upstream: https://github.com/bytebeast/kissaten.nvim
set background=dark
hi clear
if exists("syntax_on") | syntax reset | endif
let g:colors_name = "kissaten-graveyard"

hi Added guifg=#9dd081 gui=NONE cterm=NONE
hi Bold gui=bold cterm=NONE
hi Boolean guifg=#f09a62 gui=NONE cterm=NONE
hi Changed guifg=#ddbc66 gui=NONE cterm=NONE
hi Character guifg=#9dd081 gui=NONE cterm=NONE
hi ColorColumn guibg=#050507 gui=NONE cterm=NONE
hi Comment guifg=#7479a1 gui=italic cterm=NONE
hi ComplHint guifg=#7479a1 gui=NONE cterm=NONE
hi ComplHintMore guifg=#7479a1 gui=NONE cterm=NONE
hi ComplMatchIns guifg=#7479a1 gui=NONE cterm=NONE
hi Conceal guifg=#7479a1 gui=NONE cterm=NONE
hi Conditional guifg=#b392ee gui=italic cterm=NONE
hi Constant guifg=#f09a62 gui=NONE cterm=NONE
hi! link CurSearch IncSearch
hi Cursor guifg=#0a0a0d guibg=#bfc7e6 gui=NONE cterm=NONE
hi CursorColumn guibg=#171827 gui=NONE cterm=NONE
hi! link CursorIM Cursor
hi CursorLine guibg=#171827 gui=NONE cterm=NONE
hi CursorLineFold guifg=#7479a1 gui=NONE cterm=NONE
hi CursorLineNr guifg=#f09a62 gui=bold cterm=NONE
hi CursorLineSign guibg=NONE gui=NONE cterm=NONE
hi Debug guifg=#f09a62 gui=NONE cterm=NONE
hi Define guifg=#ebb9dd gui=NONE cterm=NONE
hi Delimiter guifg=#a1a9cd gui=NONE cterm=NONE
hi DiagnosticDeprecated guisp=#51577b gui=strikethrough cterm=NONE
hi DiagnosticError guifg=#ea83a0 gui=NONE cterm=NONE
hi DiagnosticFloatingError guifg=#ea83a0 gui=NONE cterm=NONE
hi DiagnosticFloatingHint guifg=#69d1c1 gui=NONE cterm=NONE
hi DiagnosticFloatingInfo guifg=#a0cfe6 gui=NONE cterm=NONE
hi DiagnosticFloatingOk guifg=#9dd081 gui=NONE cterm=NONE
hi DiagnosticFloatingWarn guifg=#ddbc66 gui=NONE cterm=NONE
hi DiagnosticHint guifg=#69d1c1 gui=NONE cterm=NONE
hi DiagnosticInfo guifg=#a0cfe6 gui=NONE cterm=NONE
hi DiagnosticOk guifg=#9dd081 gui=NONE cterm=NONE
hi DiagnosticSignError guifg=#ea83a0 gui=NONE cterm=NONE
hi DiagnosticSignHint guifg=#69d1c1 gui=NONE cterm=NONE
hi DiagnosticSignInfo guifg=#a0cfe6 gui=NONE cterm=NONE
hi DiagnosticSignOk guifg=#9dd081 gui=NONE cterm=NONE
hi DiagnosticSignWarn guifg=#ddbc66 gui=NONE cterm=NONE
hi DiagnosticUnderlineError guisp=#ea83a0 gui=undercurl cterm=NONE
hi DiagnosticUnderlineHint guisp=#69d1c1 gui=undercurl cterm=NONE
hi DiagnosticUnderlineInfo guisp=#a0cfe6 gui=undercurl cterm=NONE
hi DiagnosticUnderlineOk guisp=#9dd081 gui=undercurl cterm=NONE
hi DiagnosticUnderlineWarn guisp=#ddbc66 gui=undercurl cterm=NONE
hi DiagnosticUnnecessary guifg=#51577b gui=italic cterm=NONE
hi DiagnosticVirtualLinesError guifg=#ea83a0 gui=NONE cterm=NONE
hi DiagnosticVirtualLinesHint guifg=#69d1c1 gui=NONE cterm=NONE
hi DiagnosticVirtualLinesInfo guifg=#a0cfe6 gui=NONE cterm=NONE
hi DiagnosticVirtualLinesWarn guifg=#ddbc66 gui=NONE cterm=NONE
hi DiagnosticVirtualTextError guifg=#ea83a0 guibg=#1f151b gui=NONE cterm=NONE
hi DiagnosticVirtualTextHint guifg=#69d1c1 guibg=#131c1e gui=NONE cterm=NONE
hi DiagnosticVirtualTextInfo guifg=#a0cfe6 guibg=#181c21 gui=NONE cterm=NONE
hi DiagnosticVirtualTextOk guifg=#9dd081 guibg=#181c18 gui=NONE cterm=NONE
hi DiagnosticVirtualTextWarn guifg=#ddbc66 guibg=#1d1a15 gui=NONE cterm=NONE
hi DiagnosticWarn guifg=#ddbc66 gui=NONE cterm=NONE
hi DiffAdd guibg=#283325 gui=NONE cterm=NONE
hi DiffChange guibg=#181e2c gui=NONE cterm=NONE
hi DiffDelete guifg=#905365 guibg=#38232b gui=NONE cterm=NONE
hi DiffText guibg=#263353 guisp=#739aee gui=underline cterm=NONE
hi DiffTextAdd guibg=#27381f guisp=#9dd081 gui=underline cterm=NONE
hi Directory guifg=#739aee gui=NONE cterm=NONE
hi EndOfBuffer guifg=#0a0a0d gui=NONE cterm=NONE
hi Error guifg=#ea83a0 gui=NONE cterm=NONE
hi ErrorMsg guifg=#ea83a0 gui=NONE cterm=NONE
hi Exception guifg=#ea83a0 gui=italic cterm=NONE
hi! link Float Number
hi FloatBorder guifg=#445989 guibg=#16161f gui=NONE cterm=NONE
hi FloatFooter guifg=#a1a9cd guibg=#16161f gui=NONE cterm=NONE
hi FloatShadow guibg=#000000 gui=NONE cterm=NONE
hi FloatShadowThrough guibg=#000000 gui=NONE cterm=NONE
hi FloatTitle guifg=#739aee guibg=#16161f gui=bold cterm=NONE
hi FoldColumn guifg=#7479a1 guibg=#0a0a0d gui=NONE cterm=NONE
hi Folded guifg=#739aee guibg=#000000 gui=NONE cterm=NONE
hi Function guifg=#739aee gui=NONE cterm=NONE
hi Identifier guifg=#bfc7e6 gui=NONE cterm=NONE
hi Ignore guifg=#51577b gui=NONE cterm=NONE
hi IncSearch guifg=#000000 guibg=#f09a62 gui=bold cterm=NONE
hi Include guifg=#ebb9dd gui=italic cterm=NONE
hi Italic gui=italic cterm=NONE
hi Keyword guifg=#b392ee gui=italic cterm=NONE
hi Label guifg=#a0cfe6 gui=NONE cterm=NONE
hi LineNr guifg=#51577b gui=NONE cterm=NONE
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi LspCodeLens guifg=#7479a1 gui=italic cterm=NONE
hi LspCodeLensSeparator guifg=#51577b gui=NONE cterm=NONE
hi! link LspInfoBorder FloatBorder
hi! link LspInfoTitle Title
hi LspInlayHint guifg=#7479a1 guibg=#12121d gui=italic cterm=NONE
hi LspKindArray guifg=#a1a9cd gui=NONE cterm=NONE
hi! link LspKindBoolean Boolean
hi! link LspKindClass Type
hi! link LspKindColor Special
hi! link LspKindConstant Constant
hi LspKindConstructor guifg=#ddbc66 gui=NONE cterm=NONE
hi! link LspKindEnum Type
hi! link LspKindEnumMember Constant
hi! link LspKindEvent Special
hi LspKindField guifg=#69d1c1 gui=NONE cterm=NONE
hi! link LspKindFile Normal
hi! link LspKindFolder Directory
hi! link LspKindFunction Function
hi LspKindInterface guifg=#ddbc66 gui=italic cterm=NONE
hi LspKindKey guifg=#69d1c1 gui=NONE cterm=NONE
hi! link LspKindKeyword Keyword
hi! link LspKindMethod Function
hi LspKindModule guifg=#acb5f5 gui=NONE cterm=NONE
hi LspKindNamespace guifg=#acb5f5 gui=NONE cterm=NONE
hi LspKindNull guifg=#f09a62 gui=NONE cterm=NONE
hi! link LspKindNumber Number
hi! link LspKindObject Constant
hi! link LspKindOperator Operator
hi LspKindPackage guifg=#acb5f5 gui=NONE cterm=NONE
hi LspKindProperty guifg=#69d1c1 gui=NONE cterm=NONE
hi LspKindReference guifg=#69d1c1 gui=NONE cterm=NONE
hi LspKindSnippet guifg=#69d1c1 gui=NONE cterm=NONE
hi! link LspKindString String
hi! link LspKindStruct Type
hi LspKindText gui=NONE cterm=NONE
hi LspKindTypeParameter guifg=#ddbc66 gui=italic cterm=NONE
hi! link LspKindUnit Type
hi! link LspKindValue String
hi LspKindVariable guifg=#bfc7e6 gui=NONE cterm=NONE
hi LspReferenceRead guibg=#23253b gui=NONE cterm=NONE
hi LspReferenceTarget guibg=#23253b gui=bold cterm=NONE
hi LspReferenceText guibg=#23253b gui=NONE cterm=NONE
hi LspReferenceWrite guibg=#423641 gui=NONE cterm=NONE
hi LspSignatureActiveParameter guifg=#f09a62 guibg=#23253b gui=bold cterm=NONE
hi Macro guifg=#ebb9dd gui=NONE cterm=NONE
hi MatchParen guifg=#f09a62 guibg=#30344f gui=bold cterm=NONE
hi ModeMsg guifg=#a1a9cd gui=bold cterm=NONE
hi MoreMsg guifg=#739aee gui=NONE cterm=NONE
hi MsgArea guifg=#a1a9cd gui=NONE cterm=NONE
hi MsgSeparator guifg=#2a2d3f guibg=#050507 gui=NONE cterm=NONE
hi NonText guifg=#464b6b gui=NONE cterm=NONE
hi Normal guifg=#bfc7e6 guibg=#0a0a0d gui=NONE cterm=NONE
hi NormalFloat guifg=#bfc7e6 guibg=#16161f gui=NONE cterm=NONE
hi NormalNC guifg=#bfc7e6 guibg=#0a0a0d gui=NONE cterm=NONE
hi NormalSB guifg=#a1a9cd guibg=#050507 gui=NONE cterm=NONE
hi Number guifg=#f09a62 gui=NONE cterm=NONE
hi OkMsg guifg=#9dd081 gui=NONE cterm=NONE
hi Operator guifg=#a0cfe6 gui=NONE cterm=NONE
hi Pmenu guifg=#bfc7e6 guibg=#16161f gui=NONE cterm=NONE
hi PmenuBorder guifg=#445989 guibg=#16161f gui=NONE cterm=NONE
hi PmenuExtra guifg=#7479a1 guibg=#16161f gui=NONE cterm=NONE
hi PmenuExtraSel guifg=#7479a1 guibg=#30344f gui=NONE cterm=NONE
hi PmenuKind guifg=#acb5f5 guibg=#16161f gui=NONE cterm=NONE
hi PmenuKindSel guifg=#acb5f5 guibg=#30344f gui=NONE cterm=NONE
hi PmenuMatch guifg=#739aee guibg=#16161f gui=bold cterm=NONE
hi PmenuMatchSel guifg=#739aee guibg=#30344f gui=bold cterm=NONE
hi PmenuSbar guibg=#171827 gui=NONE cterm=NONE
hi PmenuSel guibg=#30344f gui=bold cterm=NONE
hi PmenuThumb guibg=#30344f gui=NONE cterm=NONE
hi PreCondit guifg=#ebb9dd gui=NONE cterm=NONE
hi PreProc guifg=#ebb9dd gui=NONE cterm=NONE
hi Question guifg=#739aee gui=NONE cterm=NONE
hi QuickFixLine guibg=#252e46 gui=bold cterm=NONE
hi Removed guifg=#ea83a0 gui=NONE cterm=NONE
hi Repeat guifg=#b392ee gui=italic cterm=NONE
hi Search guifg=#bfc7e6 guibg=#3f3724 gui=NONE cterm=NONE
hi SignColumn guifg=#51577b guibg=#0a0a0d gui=NONE cterm=NONE
hi SignColumnSB guifg=#51577b guibg=#050507 gui=NONE cterm=NONE
hi SnippetTabstop guibg=#262735 gui=NONE cterm=NONE
hi SnippetTabstopActive guibg=#393b50 gui=NONE cterm=NONE
hi Special guifg=#74c6f5 gui=NONE cterm=NONE
hi SpecialChar guifg=#ebb9dd gui=NONE cterm=NONE
hi SpecialComment guifg=#7479a1 gui=italic cterm=NONE
hi SpecialKey guifg=#464b6b gui=NONE cterm=NONE
hi SpellBad guisp=#ea83a0 gui=undercurl cterm=NONE
hi SpellCap guisp=#ddbc66 gui=undercurl cterm=NONE
hi SpellLocal guisp=#a0cfe6 gui=undercurl cterm=NONE
hi SpellRare guisp=#69d1c1 gui=undercurl cterm=NONE
hi Statement guifg=#b392ee gui=italic cterm=NONE
hi StatusLine guifg=#a1a9cd guibg=#050507 gui=NONE cterm=NONE
hi StatusLineNC guifg=#7479a1 guibg=#050507 gui=NONE cterm=NONE
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link StderrMsg ErrorMsg
hi StdoutMsg guifg=#a1a9cd gui=NONE cterm=NONE
hi StorageClass guifg=#b392ee gui=italic cterm=NONE
hi String guifg=#9dd081 gui=NONE cterm=NONE
hi Structure guifg=#ddbc66 gui=NONE cterm=NONE
hi Substitute guifg=#000000 guibg=#ea83a0 gui=NONE cterm=NONE
hi TabLine guifg=#7479a1 guibg=#050507 gui=NONE cterm=NONE
hi TabLineFill guibg=#000000 gui=NONE cterm=NONE
hi TabLineSel guifg=#000000 guibg=#739aee gui=bold cterm=NONE
hi Tag guifg=#ea83a0 gui=NONE cterm=NONE
hi TermCursor guifg=#0a0a0d guibg=#bfc7e6 gui=NONE cterm=NONE
hi TermCursorNC guifg=#0a0a0d guibg=#51577b gui=NONE cterm=NONE
hi Title guifg=#739aee gui=bold cterm=NONE
hi Todo guifg=#000000 guibg=#ddbc66 gui=bold cterm=NONE
hi Type guifg=#ddbc66 gui=NONE cterm=NONE
hi Typedef guifg=#ddbc66 gui=NONE cterm=NONE
hi Underlined gui=underline cterm=NONE
hi VertSplit guifg=#2a2d3f gui=NONE cterm=NONE
hi Visual guibg=#252e46 gui=NONE cterm=NONE
hi VisualNOS guibg=#252e46 gui=NONE cterm=NONE
hi WarningMsg guifg=#ddbc66 gui=NONE cterm=NONE
hi Whitespace guifg=#3c405a gui=NONE cterm=NONE
hi WildMenu guibg=#30344f gui=NONE cterm=NONE
hi WinBar guifg=#a1a9cd guibg=#0a0a0d gui=NONE cterm=NONE
hi WinBarNC guifg=#7479a1 guibg=#0a0a0d gui=NONE cterm=NONE
hi WinSeparator guifg=#2a2d3f gui=bold cterm=NONE
hi debugBreakpoint guifg=#ea83a0 guibg=#311f26 gui=NONE cterm=NONE
hi debugPC guibg=#1c2334 gui=NONE cterm=NONE
hi diffAdded guifg=#9dd081 gui=NONE cterm=NONE
hi diffChanged guifg=#ddbc66 gui=NONE cterm=NONE
hi diffFile guifg=#739aee gui=bold cterm=NONE
hi diffIndexLine guifg=#b392ee gui=NONE cterm=NONE
hi diffLine guifg=#7479a1 gui=NONE cterm=NONE
hi diffNewFile guifg=#9dd081 gui=italic cterm=NONE
hi diffOldFile guifg=#ea83a0 gui=italic cterm=NONE
hi diffRemoved guifg=#ea83a0 gui=NONE cterm=NONE
hi dosIniLabel guifg=#69d1c1 gui=NONE cterm=NONE
hi gitcommitSummary guifg=#bfc7e6 gui=bold cterm=NONE
hi healthError guifg=#ea83a0 gui=NONE cterm=NONE
hi healthSuccess guifg=#9dd081 gui=NONE cterm=NONE
hi healthWarning guifg=#ddbc66 gui=NONE cterm=NONE
hi helpCommand guifg=#739aee guibg=#171827 gui=NONE cterm=NONE
hi helpExample guifg=#7479a1 gui=NONE cterm=NONE
hi htmlH1 guifg=#739aee gui=bold cterm=NONE
hi htmlH2 guifg=#ddbc66 gui=bold cterm=NONE
hi! link lCursor Cursor
hi markdownCode guifg=#69d1c1 gui=NONE cterm=NONE
hi markdownCodeBlock guifg=#69d1c1 gui=NONE cterm=NONE
hi markdownH1 guifg=#739aee gui=bold cterm=NONE
hi markdownH2 guifg=#ddbc66 gui=bold cterm=NONE
hi markdownLinkText guifg=#739aee gui=underline cterm=NONE
hi qfFileName guifg=#739aee gui=NONE cterm=NONE
hi qfLineNr guifg=#7479a1 gui=NONE cterm=NONE

let g:terminal_ansi_colors = ["#23253b", "#ea83a0", "#9dd081", "#ddbc66", "#739aee", "#ebb9dd", "#69d1c1", "#a1a9cd", "#51577b", "#f196af", "#aadb90", "#e6c777", "#86a9f4", "#c2a6f4", "#89d1fa", "#bfc7e6"]
