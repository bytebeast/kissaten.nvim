" Kissaten Evening for Vim (8.2+ with termguicolors, or gVim)
" upstream: https://github.com/bytebeast/kissaten.nvim
set background=dark
hi clear
if exists("syntax_on") | syntax reset | endif
let g:colors_name = "kissaten-evening"

hi Added guifg=#b5e08d gui=NONE cterm=NONE
hi Bold gui=bold cterm=NONE
hi Boolean guifg=#f7a46f gui=NONE cterm=NONE
hi Changed guifg=#ebcf8c gui=NONE cterm=NONE
hi Character guifg=#b5e08d gui=NONE cterm=NONE
hi ColorColumn guibg=#191a2a gui=NONE cterm=NONE
hi Comment guifg=#7f87b0 gui=italic cterm=NONE
hi ComplHint guifg=#7f87b0 gui=NONE cterm=NONE
hi ComplHintMore guifg=#7f87b0 gui=NONE cterm=NONE
hi ComplMatchIns guifg=#7f87b0 gui=NONE cterm=NONE
hi Conceal guifg=#7f87b0 gui=NONE cterm=NONE
hi Conditional guifg=#c3a6ff gui=italic cterm=NONE
hi Constant guifg=#f7a46f gui=NONE cterm=NONE
hi! link CurSearch IncSearch
hi Cursor guifg=#1f2133 guibg=#cad3f5 gui=NONE cterm=NONE
hi CursorColumn guibg=#272a40 gui=NONE cterm=NONE
hi! link CursorIM Cursor
hi CursorLine guibg=#272a40 gui=NONE cterm=NONE
hi CursorLineFold guifg=#7f87b0 gui=NONE cterm=NONE
hi CursorLineNr guifg=#f7a46f gui=bold cterm=NONE
hi CursorLineSign guibg=NONE gui=NONE cterm=NONE
hi Debug guifg=#f7a46f gui=NONE cterm=NONE
hi Define guifg=#f5bde6 gui=NONE cterm=NONE
hi Delimiter guifg=#aeb7dc gui=NONE cterm=NONE
hi DiagnosticDeprecated guisp=#5f668d gui=strikethrough cterm=NONE
hi DiagnosticError guifg=#f28fad gui=NONE cterm=NONE
hi DiagnosticFloatingError guifg=#f28fad gui=NONE cterm=NONE
hi DiagnosticFloatingHint guifg=#7fd8c8 gui=NONE cterm=NONE
hi DiagnosticFloatingInfo guifg=#acd9f2 gui=NONE cterm=NONE
hi DiagnosticFloatingOk guifg=#b5e08d gui=NONE cterm=NONE
hi DiagnosticFloatingWarn guifg=#ebcf8c gui=NONE cterm=NONE
hi DiagnosticHint guifg=#7fd8c8 gui=NONE cterm=NONE
hi DiagnosticInfo guifg=#acd9f2 gui=NONE cterm=NONE
hi DiagnosticOk guifg=#b5e08d gui=NONE cterm=NONE
hi DiagnosticSignError guifg=#f28fad gui=NONE cterm=NONE
hi DiagnosticSignHint guifg=#7fd8c8 gui=NONE cterm=NONE
hi DiagnosticSignInfo guifg=#acd9f2 gui=NONE cterm=NONE
hi DiagnosticSignOk guifg=#b5e08d gui=NONE cterm=NONE
hi DiagnosticSignWarn guifg=#ebcf8c gui=NONE cterm=NONE
hi DiagnosticUnderlineError guisp=#f28fad gui=undercurl cterm=NONE
hi DiagnosticUnderlineHint guisp=#7fd8c8 gui=undercurl cterm=NONE
hi DiagnosticUnderlineInfo guisp=#acd9f2 gui=undercurl cterm=NONE
hi DiagnosticUnderlineOk guisp=#b5e08d gui=undercurl cterm=NONE
hi DiagnosticUnderlineWarn guisp=#ebcf8c gui=undercurl cterm=NONE
hi DiagnosticUnnecessary guifg=#5f668d gui=italic cterm=NONE
hi DiagnosticVirtualLinesError guifg=#f28fad gui=NONE cterm=NONE
hi DiagnosticVirtualLinesHint guifg=#7fd8c8 gui=NONE cterm=NONE
hi DiagnosticVirtualLinesInfo guifg=#acd9f2 gui=NONE cterm=NONE
hi DiagnosticVirtualLinesWarn guifg=#ebcf8c gui=NONE cterm=NONE
hi DiagnosticVirtualTextError guifg=#f28fad guibg=#302a3d gui=NONE cterm=NONE
hi DiagnosticVirtualTextHint guifg=#7fd8c8 guibg=#27303f gui=NONE cterm=NONE
hi DiagnosticVirtualTextInfo guifg=#acd9f2 guibg=#2a3042 gui=NONE cterm=NONE
hi DiagnosticVirtualTextOk guifg=#b5e08d guibg=#2b303a gui=NONE cterm=NONE
hi DiagnosticVirtualTextWarn guifg=#ebcf8c guibg=#2f2f3a gui=NONE cterm=NONE
hi DiagnosticWarn guifg=#ebcf8c gui=NONE cterm=NONE
hi DiffAdd guibg=#394142 gui=NONE cterm=NONE
hi DiffChange guibg=#2b314b gui=NONE cterm=NONE
hi DiffDelete guifg=#9e637c guibg=#453549 gui=NONE cterm=NONE
hi DiffText guibg=#323f64 guisp=#82aaff gui=underline cterm=NONE
hi DiffTextAdd guibg=#354337 guisp=#b5e08d gui=underline cterm=NONE
hi Directory guifg=#82aaff gui=NONE cterm=NONE
hi EndOfBuffer guifg=#1f2133 gui=NONE cterm=NONE
hi Error guifg=#f28fad gui=NONE cterm=NONE
hi ErrorMsg guifg=#f28fad gui=NONE cterm=NONE
hi Exception guifg=#f28fad gui=italic cterm=NONE
hi! link Float Number
hi FloatBorder guifg=#556ca3 guibg=#191a2a gui=NONE cterm=NONE
hi FloatFooter guifg=#aeb7dc guibg=#191a2a gui=NONE cterm=NONE
hi FloatShadow guibg=#13141f gui=NONE cterm=NONE
hi FloatShadowThrough guibg=#13141f gui=NONE cterm=NONE
hi FloatTitle guifg=#82aaff guibg=#191a2a gui=bold cterm=NONE
hi FoldColumn guifg=#7f87b0 guibg=#1f2133 gui=NONE cterm=NONE
hi Folded guifg=#82aaff guibg=#191a29 gui=NONE cterm=NONE
hi Function guifg=#82aaff gui=NONE cterm=NONE
hi Identifier guifg=#cad3f5 gui=NONE cterm=NONE
hi Ignore guifg=#5f668d gui=NONE cterm=NONE
hi IncSearch guifg=#13141f guibg=#f7a46f gui=bold cterm=NONE
hi Include guifg=#f5bde6 gui=italic cterm=NONE
hi Italic gui=italic cterm=NONE
hi Keyword guifg=#c3a6ff gui=italic cterm=NONE
hi Label guifg=#acd9f2 gui=NONE cterm=NONE
hi LineNr guifg=#5f668d gui=NONE cterm=NONE
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi LspCodeLens guifg=#7f87b0 gui=italic cterm=NONE
hi LspCodeLensSeparator guifg=#5f668d gui=NONE cterm=NONE
hi! link LspInfoBorder FloatBorder
hi! link LspInfoTitle Title
hi LspInlayHint guifg=#7f87b0 guibg=#24263b gui=italic cterm=NONE
hi LspKindArray guifg=#aeb7dc gui=NONE cterm=NONE
hi! link LspKindBoolean Boolean
hi! link LspKindClass Type
hi! link LspKindColor Special
hi! link LspKindConstant Constant
hi LspKindConstructor guifg=#ebcf8c gui=NONE cterm=NONE
hi! link LspKindEnum Type
hi! link LspKindEnumMember Constant
hi! link LspKindEvent Special
hi LspKindField guifg=#7fd8c8 gui=NONE cterm=NONE
hi! link LspKindFile Normal
hi! link LspKindFolder Directory
hi! link LspKindFunction Function
hi LspKindInterface guifg=#ebcf8c gui=italic cterm=NONE
hi LspKindKey guifg=#7fd8c8 gui=NONE cterm=NONE
hi! link LspKindKeyword Keyword
hi! link LspKindMethod Function
hi LspKindModule guifg=#b7c1fb gui=NONE cterm=NONE
hi LspKindNamespace guifg=#b7c1fb gui=NONE cterm=NONE
hi LspKindNull guifg=#f7a46f gui=NONE cterm=NONE
hi! link LspKindNumber Number
hi! link LspKindObject Constant
hi! link LspKindOperator Operator
hi LspKindPackage guifg=#b7c1fb gui=NONE cterm=NONE
hi LspKindProperty guifg=#7fd8c8 gui=NONE cterm=NONE
hi LspKindReference guifg=#7fd8c8 gui=NONE cterm=NONE
hi LspKindSnippet guifg=#7fd8c8 gui=NONE cterm=NONE
hi! link LspKindString String
hi! link LspKindStruct Type
hi LspKindText gui=NONE cterm=NONE
hi LspKindTypeParameter guifg=#ebcf8c gui=italic cterm=NONE
hi! link LspKindUnit Type
hi! link LspKindValue String
hi LspKindVariable guifg=#cad3f5 gui=NONE cterm=NONE
hi LspReferenceRead guibg=#323650 gui=NONE cterm=NONE
hi LspReferenceTarget guibg=#323650 gui=bold cterm=NONE
hi LspReferenceText guibg=#323650 gui=NONE cterm=NONE
hi LspReferenceWrite guibg=#4f445c gui=NONE cterm=NONE
hi LspSignatureActiveParameter guifg=#f7a46f guibg=#323650 gui=bold cterm=NONE
hi Macro guifg=#f5bde6 gui=NONE cterm=NONE
hi MatchParen guifg=#f7a46f guibg=#3f4463 gui=bold cterm=NONE
hi ModeMsg guifg=#aeb7dc gui=bold cterm=NONE
hi MoreMsg guifg=#82aaff gui=NONE cterm=NONE
hi MsgArea guifg=#aeb7dc gui=NONE cterm=NONE
hi MsgSeparator guifg=#3c405c guibg=#191a2a gui=NONE cterm=NONE
hi NonText guifg=#555c80 gui=NONE cterm=NONE
hi Normal guifg=#cad3f5 guibg=#1f2133 gui=NONE cterm=NONE
hi NormalFloat guifg=#cad3f5 guibg=#191a2a gui=NONE cterm=NONE
hi NormalNC guifg=#cad3f5 guibg=#1f2133 gui=NONE cterm=NONE
hi NormalSB guifg=#aeb7dc guibg=#191a2a gui=NONE cterm=NONE
hi Number guifg=#f7a46f gui=NONE cterm=NONE
hi OkMsg guifg=#b5e08d gui=NONE cterm=NONE
hi Operator guifg=#acd9f2 gui=NONE cterm=NONE
hi Pmenu guifg=#cad3f5 guibg=#191a2a gui=NONE cterm=NONE
hi PmenuBorder guifg=#556ca3 guibg=#191a2a gui=NONE cterm=NONE
hi PmenuExtra guifg=#7f87b0 guibg=#191a2a gui=NONE cterm=NONE
hi PmenuExtraSel guifg=#7f87b0 guibg=#323650 gui=NONE cterm=NONE
hi PmenuKind guifg=#b7c1fb guibg=#191a2a gui=NONE cterm=NONE
hi PmenuKindSel guifg=#b7c1fb guibg=#323650 gui=NONE cterm=NONE
hi PmenuMatch guifg=#82aaff guibg=#191a2a gui=bold cterm=NONE
hi PmenuMatchSel guifg=#82aaff guibg=#323650 gui=bold cterm=NONE
hi PmenuSbar guibg=#272a40 gui=NONE cterm=NONE
hi PmenuSel guibg=#323650 gui=bold cterm=NONE
hi PmenuThumb guibg=#3f4463 gui=NONE cterm=NONE
hi PreCondit guifg=#f5bde6 gui=NONE cterm=NONE
hi PreProc guifg=#f5bde6 gui=NONE cterm=NONE
hi Question guifg=#82aaff gui=NONE cterm=NONE
hi QuickFixLine guibg=#353f60 gui=bold cterm=NONE
hi Removed guifg=#f28fad gui=NONE cterm=NONE
hi Repeat guifg=#c3a6ff gui=italic cterm=NONE
hi Search guifg=#cad3f5 guibg=#4c4747 gui=NONE cterm=NONE
hi SignColumn guifg=#5f668d guibg=#1f2133 gui=NONE cterm=NONE
hi SignColumnSB guifg=#5f668d guibg=#191a2a gui=NONE cterm=NONE
hi SnippetTabstop guibg=#363951 gui=NONE cterm=NONE
hi SnippetTabstopActive guibg=#454965 gui=NONE cterm=NONE
hi Special guifg=#89ddff gui=NONE cterm=NONE
hi SpecialChar guifg=#f5bde6 gui=NONE cterm=NONE
hi SpecialComment guifg=#7f87b0 gui=italic cterm=NONE
hi SpecialKey guifg=#555c80 gui=NONE cterm=NONE
hi SpellBad guisp=#f28fad gui=undercurl cterm=NONE
hi SpellCap guisp=#ebcf8c gui=undercurl cterm=NONE
hi SpellLocal guisp=#acd9f2 gui=undercurl cterm=NONE
hi SpellRare guisp=#7fd8c8 gui=undercurl cterm=NONE
hi Statement guifg=#c3a6ff gui=italic cterm=NONE
hi StatusLine guifg=#aeb7dc guibg=#191a2a gui=NONE cterm=NONE
hi StatusLineNC guifg=#7f87b0 guibg=#191a2a gui=NONE cterm=NONE
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link StderrMsg ErrorMsg
hi StdoutMsg guifg=#aeb7dc gui=NONE cterm=NONE
hi StorageClass guifg=#c3a6ff gui=italic cterm=NONE
hi String guifg=#b5e08d gui=NONE cterm=NONE
hi Structure guifg=#ebcf8c gui=NONE cterm=NONE
hi Substitute guifg=#13141f guibg=#f28fad gui=NONE cterm=NONE
hi TabLine guifg=#7f87b0 guibg=#191a2a gui=NONE cterm=NONE
hi TabLineFill guibg=#13141f gui=NONE cterm=NONE
hi TabLineSel guifg=#13141f guibg=#82aaff gui=bold cterm=NONE
hi Tag guifg=#f28fad gui=NONE cterm=NONE
hi TermCursor guifg=#1f2133 guibg=#cad3f5 gui=NONE cterm=NONE
hi TermCursorNC guifg=#1f2133 guibg=#5f668d gui=NONE cterm=NONE
hi Title guifg=#82aaff gui=bold cterm=NONE
hi Todo guifg=#13141f guibg=#ebcf8c gui=bold cterm=NONE
hi Type guifg=#ebcf8c gui=NONE cterm=NONE
hi Typedef guifg=#ebcf8c gui=NONE cterm=NONE
hi Underlined gui=underline cterm=NONE
hi VertSplit guifg=#3c405c gui=NONE cterm=NONE
hi Visual guibg=#353f60 gui=NONE cterm=NONE
hi VisualNOS guibg=#353f60 gui=NONE cterm=NONE
hi WarningMsg guifg=#ebcf8c gui=NONE cterm=NONE
hi Whitespace guifg=#4c5172 gui=NONE cterm=NONE
hi WildMenu guibg=#323650 gui=NONE cterm=NONE
hi WinBar guifg=#aeb7dc guibg=#1f2133 gui=NONE cterm=NONE
hi WinBarNC guifg=#7f87b0 guibg=#1f2133 gui=NONE cterm=NONE
hi WinSeparator guifg=#3c405c gui=bold cterm=NONE
hi debugBreakpoint guifg=#f28fad guibg=#3f3245 gui=NONE cterm=NONE
hi debugPC guibg=#2e3652 gui=NONE cterm=NONE
hi diffAdded guifg=#b5e08d gui=NONE cterm=NONE
hi diffChanged guifg=#ebcf8c gui=NONE cterm=NONE
hi diffFile guifg=#82aaff gui=bold cterm=NONE
hi diffIndexLine guifg=#c3a6ff gui=NONE cterm=NONE
hi diffLine guifg=#7f87b0 gui=NONE cterm=NONE
hi diffNewFile guifg=#b5e08d gui=italic cterm=NONE
hi diffOldFile guifg=#f28fad gui=italic cterm=NONE
hi diffRemoved guifg=#f28fad gui=NONE cterm=NONE
hi dosIniLabel guifg=#7fd8c8 gui=NONE cterm=NONE
hi gitcommitSummary guifg=#cad3f5 gui=bold cterm=NONE
hi healthError guifg=#f28fad gui=NONE cterm=NONE
hi healthSuccess guifg=#b5e08d gui=NONE cterm=NONE
hi healthWarning guifg=#ebcf8c gui=NONE cterm=NONE
hi helpCommand guifg=#82aaff guibg=#272a40 gui=NONE cterm=NONE
hi helpExample guifg=#7f87b0 gui=NONE cterm=NONE
hi htmlH1 guifg=#82aaff gui=bold cterm=NONE
hi htmlH2 guifg=#ebcf8c gui=bold cterm=NONE
hi! link lCursor Cursor
hi markdownCode guifg=#7fd8c8 gui=NONE cterm=NONE
hi markdownCodeBlock guifg=#7fd8c8 gui=NONE cterm=NONE
hi markdownH1 guifg=#82aaff gui=bold cterm=NONE
hi markdownH2 guifg=#ebcf8c gui=bold cterm=NONE
hi markdownLinkText guifg=#82aaff gui=underline cterm=NONE
hi qfFileName guifg=#82aaff gui=NONE cterm=NONE
hi qfLineNr guifg=#7f87b0 gui=NONE cterm=NONE

let g:terminal_ansi_colors = ["#323650", "#f28fad", "#b5e08d", "#ebcf8c", "#82aaff", "#f5bde6", "#7fd8c8", "#aeb7dc", "#5f668d", "#f7a3bd", "#c2e89e", "#f2d99f", "#9cbbff", "#d4c0ff", "#a3e4ff", "#cad3f5"]
