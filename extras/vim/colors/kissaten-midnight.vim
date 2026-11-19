" Kissaten Midnight for Vim (8.2+ with termguicolors, or gVim)
" upstream: https://github.com/bytebeast/kissaten.nvim
set background=dark
hi clear
if exists("syntax_on") | syntax reset | endif
let g:colors_name = "kissaten-midnight"

hi Added guifg=#a6d98a gui=NONE cterm=NONE
hi Bold gui=bold cterm=NONE
hi Boolean guifg=#f9a26a gui=NONE cterm=NONE
hi Changed guifg=#e6c56f gui=NONE cterm=NONE
hi Character guifg=#a6d98a gui=NONE cterm=NONE
hi ColorColumn guibg=#111118 gui=NONE cterm=NONE
hi Comment guifg=#7a80a8 gui=italic cterm=NONE
hi ComplHint guifg=#7a80a8 gui=NONE cterm=NONE
hi ComplHintMore guifg=#7a80a8 gui=NONE cterm=NONE
hi ComplMatchIns guifg=#7a80a8 gui=NONE cterm=NONE
hi Conceal guifg=#7a80a8 gui=NONE cterm=NONE
hi Conditional guifg=#bb9af7 gui=italic cterm=NONE
hi Constant guifg=#f9a26a gui=NONE cterm=NONE
hi! link CurSearch IncSearch
hi Cursor guifg=#16161f guibg=#c8d0f0 gui=NONE cterm=NONE
hi CursorColumn guibg=#1f2030 gui=NONE cterm=NONE
hi! link CursorIM Cursor
hi CursorLine guibg=#1f2030 gui=NONE cterm=NONE
hi CursorLineFold guifg=#7a80a8 gui=NONE cterm=NONE
hi CursorLineNr guifg=#f9a26a gui=bold cterm=NONE
hi CursorLineSign guibg=NONE gui=NONE cterm=NONE
hi Debug guifg=#f9a26a gui=NONE cterm=NONE
hi Define guifg=#f5c2e7 gui=NONE cterm=NONE
hi Delimiter guifg=#a9b1d6 gui=NONE cterm=NONE
hi DiagnosticDeprecated guisp=#575d82 gui=strikethrough cterm=NONE
hi DiagnosticError guifg=#f38ba8 gui=NONE cterm=NONE
hi DiagnosticFloatingError guifg=#f38ba8 gui=NONE cterm=NONE
hi DiagnosticFloatingHint guifg=#73daca gui=NONE cterm=NONE
hi DiagnosticFloatingInfo guifg=#a9d8f0 gui=NONE cterm=NONE
hi DiagnosticFloatingOk guifg=#a6d98a gui=NONE cterm=NONE
hi DiagnosticFloatingWarn guifg=#e6c56f gui=NONE cterm=NONE
hi DiagnosticHint guifg=#73daca gui=NONE cterm=NONE
hi DiagnosticInfo guifg=#a9d8f0 gui=NONE cterm=NONE
hi DiagnosticOk guifg=#a6d98a gui=NONE cterm=NONE
hi DiagnosticSignError guifg=#f38ba8 gui=NONE cterm=NONE
hi DiagnosticSignHint guifg=#73daca gui=NONE cterm=NONE
hi DiagnosticSignInfo guifg=#a9d8f0 gui=NONE cterm=NONE
hi DiagnosticSignOk guifg=#a6d98a gui=NONE cterm=NONE
hi DiagnosticSignWarn guifg=#e6c56f gui=NONE cterm=NONE
hi DiagnosticUnderlineError guisp=#f38ba8 gui=undercurl cterm=NONE
hi DiagnosticUnderlineHint guisp=#73daca gui=undercurl cterm=NONE
hi DiagnosticUnderlineInfo guisp=#a9d8f0 gui=undercurl cterm=NONE
hi DiagnosticUnderlineOk guisp=#a6d98a gui=undercurl cterm=NONE
hi DiagnosticUnderlineWarn guisp=#e6c56f gui=undercurl cterm=NONE
hi DiagnosticUnnecessary guifg=#575d82 gui=italic cterm=NONE
hi DiagnosticVirtualLinesError guifg=#f38ba8 gui=NONE cterm=NONE
hi DiagnosticVirtualLinesHint guifg=#73daca gui=NONE cterm=NONE
hi DiagnosticVirtualLinesInfo guifg=#a9d8f0 gui=NONE cterm=NONE
hi DiagnosticVirtualLinesWarn guifg=#e6c56f gui=NONE cterm=NONE
hi DiagnosticVirtualTextError guifg=#f38ba8 guibg=#281f2a gui=NONE cterm=NONE
hi DiagnosticVirtualTextHint guifg=#73daca guibg=#1d262d gui=NONE cterm=NONE
hi DiagnosticVirtualTextInfo guifg=#a9d8f0 guibg=#222630 gui=NONE cterm=NONE
hi DiagnosticVirtualTextOk guifg=#a6d98a guibg=#222628 gui=NONE cterm=NONE
hi DiagnosticVirtualTextWarn guifg=#e6c56f guibg=#272425 gui=NONE cterm=NONE
hi DiagnosticWarn guifg=#e6c56f gui=NONE cterm=NONE
hi DiffAdd guibg=#303932 gui=NONE cterm=NONE
hi DiffChange guibg=#222739 gui=NONE cterm=NONE
hi DiffDelete guifg=#9b5c71 guibg=#3e2b38 gui=NONE cterm=NONE
hi DiffText guibg=#2d3959 guisp=#7aa2f7 gui=underline cterm=NONE
hi DiffTextAdd guibg=#2f3e2c guisp=#a6d98a gui=underline cterm=NONE
hi Directory guifg=#7aa2f7 gui=NONE cterm=NONE
hi EndOfBuffer guifg=#16161f gui=NONE cterm=NONE
hi Error guifg=#f38ba8 gui=NONE cterm=NONE
hi ErrorMsg guifg=#f38ba8 gui=NONE cterm=NONE
hi Exception guifg=#f38ba8 gui=italic cterm=NONE
hi! link Float Number
hi FloatBorder guifg=#4d6396 guibg=#1f2030 gui=NONE cterm=NONE
hi FloatFooter guifg=#a9b1d6 guibg=#1f2030 gui=NONE cterm=NONE
hi FloatShadow guibg=#0c0c12 gui=NONE cterm=NONE
hi FloatShadowThrough guibg=#0c0c12 gui=NONE cterm=NONE
hi FloatTitle guifg=#7aa2f7 guibg=#1f2030 gui=bold cterm=NONE
hi FoldColumn guifg=#7a80a8 guibg=#16161f gui=NONE cterm=NONE
hi Folded guifg=#7aa2f7 guibg=#0c0c12 gui=NONE cterm=NONE
hi Function guifg=#7aa2f7 gui=NONE cterm=NONE
hi Identifier guifg=#c8d0f0 gui=NONE cterm=NONE
hi Ignore guifg=#575d82 gui=NONE cterm=NONE
hi IncSearch guifg=#0c0c12 guibg=#f9a26a gui=bold cterm=NONE
hi Include guifg=#f5c2e7 gui=italic cterm=NONE
hi Italic gui=italic cterm=NONE
hi Keyword guifg=#bb9af7 gui=italic cterm=NONE
hi Label guifg=#a9d8f0 gui=NONE cterm=NONE
hi LineNr guifg=#575d82 gui=NONE cterm=NONE
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi LspCodeLens guifg=#7a80a8 gui=italic cterm=NONE
hi LspCodeLensSeparator guifg=#575d82 gui=NONE cterm=NONE
hi! link LspInfoBorder FloatBorder
hi! link LspInfoTitle Title
hi LspInlayHint guifg=#7a80a8 guibg=#1b1c29 gui=italic cterm=NONE
hi LspKindArray guifg=#a9b1d6 gui=NONE cterm=NONE
hi! link LspKindBoolean Boolean
hi! link LspKindClass Type
hi! link LspKindColor Special
hi! link LspKindConstant Constant
hi LspKindConstructor guifg=#e6c56f gui=NONE cterm=NONE
hi! link LspKindEnum Type
hi! link LspKindEnumMember Constant
hi! link LspKindEvent Special
hi LspKindField guifg=#73daca gui=NONE cterm=NONE
hi! link LspKindFile Normal
hi! link LspKindFolder Directory
hi! link LspKindFunction Function
hi LspKindInterface guifg=#e6c56f gui=italic cterm=NONE
hi LspKindKey guifg=#73daca gui=NONE cterm=NONE
hi! link LspKindKeyword Keyword
hi! link LspKindMethod Function
hi LspKindModule guifg=#b4befe gui=NONE cterm=NONE
hi LspKindNamespace guifg=#b4befe gui=NONE cterm=NONE
hi LspKindNull guifg=#f9a26a gui=NONE cterm=NONE
hi! link LspKindNumber Number
hi! link LspKindObject Constant
hi! link LspKindOperator Operator
hi LspKindPackage guifg=#b4befe gui=NONE cterm=NONE
hi LspKindProperty guifg=#73daca gui=NONE cterm=NONE
hi LspKindReference guifg=#73daca gui=NONE cterm=NONE
hi LspKindSnippet guifg=#73daca gui=NONE cterm=NONE
hi! link LspKindString String
hi! link LspKindStruct Type
hi LspKindText gui=NONE cterm=NONE
hi LspKindTypeParameter guifg=#e6c56f gui=italic cterm=NONE
hi! link LspKindUnit Type
hi! link LspKindValue String
hi LspKindVariable guifg=#c8d0f0 gui=NONE cterm=NONE
hi LspReferenceRead guibg=#2a2c42 gui=NONE cterm=NONE
hi LspReferenceTarget guibg=#2a2c42 gui=bold cterm=NONE
hi LspReferenceText guibg=#2a2c42 gui=NONE cterm=NONE
hi LspReferenceWrite guibg=#473c4b gui=NONE cterm=NONE
hi LspSignatureActiveParameter guifg=#f9a26a guibg=#2a2c42 gui=bold cterm=NONE
hi Macro guifg=#f5c2e7 gui=NONE cterm=NONE
hi MatchParen guifg=#f9a26a guibg=#363a56 gui=bold cterm=NONE
hi ModeMsg guifg=#a9b1d6 gui=bold cterm=NONE
hi MoreMsg guifg=#7aa2f7 gui=NONE cterm=NONE
hi MsgArea guifg=#a9b1d6 gui=NONE cterm=NONE
hi MsgSeparator guifg=#33364c guibg=#111118 gui=NONE cterm=NONE
hi NonText guifg=#4d5273 gui=NONE cterm=NONE
hi Normal guifg=#c8d0f0 guibg=#16161f gui=NONE cterm=NONE
hi NormalFloat guifg=#c8d0f0 guibg=#1f2030 gui=NONE cterm=NONE
hi NormalNC guifg=#c8d0f0 guibg=#16161f gui=NONE cterm=NONE
hi NormalSB guifg=#a9b1d6 guibg=#111118 gui=NONE cterm=NONE
hi Number guifg=#f9a26a gui=NONE cterm=NONE
hi OkMsg guifg=#a6d98a gui=NONE cterm=NONE
hi Operator guifg=#a9d8f0 gui=NONE cterm=NONE
hi Pmenu guifg=#c8d0f0 guibg=#1f2030 gui=NONE cterm=NONE
hi PmenuBorder guifg=#4d6396 guibg=#1f2030 gui=NONE cterm=NONE
hi PmenuExtra guifg=#7a80a8 guibg=#1f2030 gui=NONE cterm=NONE
hi PmenuExtraSel guifg=#7a80a8 guibg=#363a56 gui=NONE cterm=NONE
hi PmenuKind guifg=#b4befe guibg=#1f2030 gui=NONE cterm=NONE
hi PmenuKindSel guifg=#b4befe guibg=#363a56 gui=NONE cterm=NONE
hi PmenuMatch guifg=#7aa2f7 guibg=#1f2030 gui=bold cterm=NONE
hi PmenuMatchSel guifg=#7aa2f7 guibg=#363a56 gui=bold cterm=NONE
hi PmenuSbar guibg=#1f2030 gui=NONE cterm=NONE
hi PmenuSel guibg=#363a56 gui=bold cterm=NONE
hi PmenuThumb guibg=#363a56 gui=NONE cterm=NONE
hi PreCondit guifg=#f5c2e7 gui=NONE cterm=NONE
hi PreProc guifg=#f5c2e7 gui=NONE cterm=NONE
hi Question guifg=#7aa2f7 gui=NONE cterm=NONE
hi QuickFixLine guibg=#2c354f gui=bold cterm=NONE
hi Removed guifg=#f38ba8 gui=NONE cterm=NONE
hi Repeat guifg=#bb9af7 gui=italic cterm=NONE
hi Search guifg=#c8d0f0 guibg=#443d31 gui=NONE cterm=NONE
hi SignColumn guifg=#575d82 guibg=#16161f gui=NONE cterm=NONE
hi SignColumnSB guifg=#575d82 guibg=#111118 gui=NONE cterm=NONE
hi SnippetTabstop guibg=#2e2f40 gui=NONE cterm=NONE
hi SnippetTabstopActive guibg=#3e4057 gui=NONE cterm=NONE
hi Special guifg=#7dcfff gui=NONE cterm=NONE
hi SpecialChar guifg=#f5c2e7 gui=NONE cterm=NONE
hi SpecialComment guifg=#7a80a8 gui=italic cterm=NONE
hi SpecialKey guifg=#4d5273 gui=NONE cterm=NONE
hi SpellBad guisp=#f38ba8 gui=undercurl cterm=NONE
hi SpellCap guisp=#e6c56f gui=undercurl cterm=NONE
hi SpellLocal guisp=#a9d8f0 gui=undercurl cterm=NONE
hi SpellRare guisp=#73daca gui=undercurl cterm=NONE
hi Statement guifg=#bb9af7 gui=italic cterm=NONE
hi StatusLine guifg=#a9b1d6 guibg=#111118 gui=NONE cterm=NONE
hi StatusLineNC guifg=#7a80a8 guibg=#111118 gui=NONE cterm=NONE
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link StderrMsg ErrorMsg
hi StdoutMsg guifg=#a9b1d6 gui=NONE cterm=NONE
hi StorageClass guifg=#bb9af7 gui=italic cterm=NONE
hi String guifg=#a6d98a gui=NONE cterm=NONE
hi Structure guifg=#e6c56f gui=NONE cterm=NONE
hi Substitute guifg=#0c0c12 guibg=#f38ba8 gui=NONE cterm=NONE
hi TabLine guifg=#7a80a8 guibg=#111118 gui=NONE cterm=NONE
hi TabLineFill guibg=#0c0c12 gui=NONE cterm=NONE
hi TabLineSel guifg=#0c0c12 guibg=#7aa2f7 gui=bold cterm=NONE
hi Tag guifg=#f38ba8 gui=NONE cterm=NONE
hi TermCursor guifg=#16161f guibg=#c8d0f0 gui=NONE cterm=NONE
hi TermCursorNC guifg=#16161f guibg=#575d82 gui=NONE cterm=NONE
hi Title guifg=#7aa2f7 gui=bold cterm=NONE
hi Todo guifg=#0c0c12 guibg=#e6c56f gui=bold cterm=NONE
hi Type guifg=#e6c56f gui=NONE cterm=NONE
hi Typedef guifg=#e6c56f gui=NONE cterm=NONE
hi Underlined gui=underline cterm=NONE
hi VertSplit guifg=#33364c gui=NONE cterm=NONE
hi Visual guibg=#2c354f gui=NONE cterm=NONE
hi VisualNOS guibg=#2c354f gui=NONE cterm=NONE
hi WarningMsg guifg=#e6c56f gui=NONE cterm=NONE
hi Whitespace guifg=#444864 gui=NONE cterm=NONE
hi WildMenu guibg=#363a56 gui=NONE cterm=NONE
hi WinBar guifg=#a9b1d6 guibg=#16161f gui=NONE cterm=NONE
hi WinBarNC guifg=#7a80a8 guibg=#16161f gui=NONE cterm=NONE
hi WinSeparator guifg=#33364c gui=bold cterm=NONE
hi debugBreakpoint guifg=#f38ba8 guibg=#372834 gui=NONE cterm=NONE
hi debugPC guibg=#252b3f gui=NONE cterm=NONE
hi diffAdded guifg=#a6d98a gui=NONE cterm=NONE
hi diffChanged guifg=#e6c56f gui=NONE cterm=NONE
hi diffFile guifg=#7aa2f7 gui=bold cterm=NONE
hi diffIndexLine guifg=#bb9af7 gui=NONE cterm=NONE
hi diffLine guifg=#7a80a8 gui=NONE cterm=NONE
hi diffNewFile guifg=#a6d98a gui=italic cterm=NONE
hi diffOldFile guifg=#f38ba8 gui=italic cterm=NONE
hi diffRemoved guifg=#f38ba8 gui=NONE cterm=NONE
hi dosIniLabel guifg=#73daca gui=NONE cterm=NONE
hi gitcommitSummary guifg=#c8d0f0 gui=bold cterm=NONE
hi healthError guifg=#f38ba8 gui=NONE cterm=NONE
hi healthSuccess guifg=#a6d98a gui=NONE cterm=NONE
hi healthWarning guifg=#e6c56f gui=NONE cterm=NONE
hi helpCommand guifg=#7aa2f7 guibg=#1f2030 gui=NONE cterm=NONE
hi helpExample guifg=#7a80a8 gui=NONE cterm=NONE
hi htmlH1 guifg=#7aa2f7 gui=bold cterm=NONE
hi htmlH2 guifg=#e6c56f gui=bold cterm=NONE
hi! link lCursor Cursor
hi markdownCode guifg=#73daca gui=NONE cterm=NONE
hi markdownCodeBlock guifg=#73daca gui=NONE cterm=NONE
hi markdownH1 guifg=#7aa2f7 gui=bold cterm=NONE
hi markdownH2 guifg=#e6c56f gui=bold cterm=NONE
hi markdownLinkText guifg=#7aa2f7 gui=underline cterm=NONE
hi qfFileName guifg=#7aa2f7 gui=NONE cterm=NONE
hi qfLineNr guifg=#7a80a8 gui=NONE cterm=NONE

let g:terminal_ansi_colors = ["#2a2c42", "#f38ba8", "#a6d98a", "#e6c56f", "#7aa2f7", "#f5c2e7", "#73daca", "#a9b1d6", "#575d82", "#f8a0b8", "#b4e29a", "#edcf81", "#8fb2fb", "#cab0fb", "#97d8ff", "#c8d0f0"]
