" Kissaten Morning for Vim (8.2+ with termguicolors, or gVim)
" upstream: https://github.com/bytebeast/kissaten.nvim
set background=light
hi clear
if exists("syntax_on") | syntax reset | endif
let g:colors_name = "kissaten-morning"

hi Added guifg=#24680c gui=NONE cterm=NONE
hi Bold gui=bold cterm=NONE
hi Boolean guifg=#9c3c00 gui=NONE cterm=NONE
hi Changed guifg=#805000 gui=NONE cterm=NONE
hi Character guifg=#24680c gui=NONE cterm=NONE
hi ColorColumn guibg=#e0e4ee gui=NONE cterm=NONE
hi Comment guifg=#686f8e gui=italic cterm=NONE
hi ComplHint guifg=#686f8e gui=NONE cterm=NONE
hi ComplHintMore guifg=#686f8e gui=NONE cterm=NONE
hi ComplMatchIns guifg=#686f8e gui=NONE cterm=NONE
hi Conceal guifg=#686f8e gui=NONE cterm=NONE
hi Conditional guifg=#7128df gui=italic cterm=NONE
hi Constant guifg=#9c3c00 gui=NONE cterm=NONE
hi! link CurSearch IncSearch
hi Cursor guifg=#eef0f6 guibg=#353a5c gui=NONE cterm=NONE
hi CursorColumn guibg=#e2e5ee gui=NONE cterm=NONE
hi! link CursorIM Cursor
hi CursorLine guibg=#e2e5ee gui=NONE cterm=NONE
hi CursorLineFold guifg=#686f8e gui=NONE cterm=NONE
hi CursorLineNr guifg=#9c3c00 gui=bold cterm=NONE
hi CursorLineSign guibg=NONE gui=NONE cterm=NONE
hi Debug guifg=#9c3c00 gui=NONE cterm=NONE
hi Define guifg=#9c2d7a gui=NONE cterm=NONE
hi Delimiter guifg=#4f5578 gui=NONE cterm=NONE
hi DiagnosticDeprecated guisp=#8f96b1 gui=strikethrough cterm=NONE
hi DiagnosticError guifg=#b7002f gui=NONE cterm=NONE
hi DiagnosticFloatingError guifg=#b7002f gui=NONE cterm=NONE
hi DiagnosticFloatingHint guifg=#00656a gui=NONE cterm=NONE
hi DiagnosticFloatingInfo guifg=#2a5f7f gui=NONE cterm=NONE
hi DiagnosticFloatingOk guifg=#24680c gui=NONE cterm=NONE
hi DiagnosticFloatingWarn guifg=#805000 gui=NONE cterm=NONE
hi DiagnosticHint guifg=#00656a gui=NONE cterm=NONE
hi DiagnosticInfo guifg=#2a5f7f gui=NONE cterm=NONE
hi DiagnosticOk guifg=#24680c gui=NONE cterm=NONE
hi DiagnosticSignError guifg=#b7002f gui=NONE cterm=NONE
hi DiagnosticSignHint guifg=#00656a gui=NONE cterm=NONE
hi DiagnosticSignInfo guifg=#2a5f7f gui=NONE cterm=NONE
hi DiagnosticSignOk guifg=#24680c gui=NONE cterm=NONE
hi DiagnosticSignWarn guifg=#805000 gui=NONE cterm=NONE
hi DiagnosticUnderlineError guisp=#b7002f gui=undercurl cterm=NONE
hi DiagnosticUnderlineHint guisp=#00656a gui=undercurl cterm=NONE
hi DiagnosticUnderlineInfo guisp=#2a5f7f gui=undercurl cterm=NONE
hi DiagnosticUnderlineOk guisp=#24680c gui=undercurl cterm=NONE
hi DiagnosticUnderlineWarn guisp=#805000 gui=undercurl cterm=NONE
hi DiagnosticUnnecessary guifg=#8f96b1 gui=italic cterm=NONE
hi DiagnosticVirtualLinesError guifg=#b7002f gui=NONE cterm=NONE
hi DiagnosticVirtualLinesHint guifg=#00656a gui=NONE cterm=NONE
hi DiagnosticVirtualLinesInfo guifg=#2a5f7f gui=NONE cterm=NONE
hi DiagnosticVirtualLinesWarn guifg=#805000 gui=NONE cterm=NONE
hi DiagnosticVirtualTextError guifg=#b7002f guibg=#e9d8e2 gui=NONE cterm=NONE
hi DiagnosticVirtualTextHint guifg=#00656a guibg=#d6e2e8 gui=NONE cterm=NONE
hi DiagnosticVirtualTextInfo guifg=#2a5f7f guibg=#dae2ea gui=NONE cterm=NONE
hi DiagnosticVirtualTextOk guifg=#24680c guibg=#dae2df gui=NONE cterm=NONE
hi DiagnosticVirtualTextWarn guifg=#805000 guibg=#e3e0dd gui=NONE cterm=NONE
hi DiagnosticWarn guifg=#805000 gui=NONE cterm=NONE
hi DiffAdd guibg=#c5d6c8 gui=NONE cterm=NONE
hi DiffChange guibg=#dae0f3 gui=NONE cterm=NONE
hi DiffDelete guifg=#cd607f guibg=#efc8d7 gui=NONE cterm=NONE
hi DiffText guibg=#c1d2fc guisp=#1d4fcf gui=underline cterm=NONE
hi DiffTextAdd guibg=#c1d8bf guisp=#24680c gui=underline cterm=NONE
hi Directory guifg=#1d4fcf gui=NONE cterm=NONE
hi EndOfBuffer guifg=#eef0f6 gui=NONE cterm=NONE
hi Error guifg=#b7002f gui=NONE cterm=NONE
hi ErrorMsg guifg=#b7002f gui=NONE cterm=NONE
hi Exception guifg=#b7002f gui=italic cterm=NONE
hi! link Float Number
hi FloatBorder guifg=#7b97e1 guibg=#e0e4ee gui=NONE cterm=NONE
hi FloatFooter guifg=#4f5578 guibg=#e0e4ee gui=NONE cterm=NONE
hi FloatShadow guibg=#d4d8e4 gui=NONE cterm=NONE
hi FloatShadowThrough guibg=#d4d8e4 gui=NONE cterm=NONE
hi FloatTitle guifg=#1d4fcf guibg=#e0e4ee gui=bold cterm=NONE
hi FoldColumn guifg=#686f8e guibg=#eef0f6 gui=NONE cterm=NONE
hi Folded guifg=#1d4fcf guibg=#f8f9fb gui=NONE cterm=NONE
hi Function guifg=#1d4fcf gui=NONE cterm=NONE
hi Identifier guifg=#353a5c gui=NONE cterm=NONE
hi Ignore guifg=#8f96b1 gui=NONE cterm=NONE
hi IncSearch guifg=#eef0f6 guibg=#9c3c00 gui=bold cterm=NONE
hi Include guifg=#9c2d7a gui=italic cterm=NONE
hi Italic gui=italic cterm=NONE
hi Keyword guifg=#7128df gui=italic cterm=NONE
hi Label guifg=#2a5f7f gui=NONE cterm=NONE
hi LineNr guifg=#8f96b1 gui=NONE cterm=NONE
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi LspCodeLens guifg=#686f8e gui=italic cterm=NONE
hi LspCodeLensSeparator guifg=#8f96b1 gui=NONE cterm=NONE
hi! link LspInfoBorder FloatBorder
hi! link LspInfoTitle Title
hi LspInlayHint guifg=#686f8e guibg=#e7e9f1 gui=italic cterm=NONE
hi LspKindArray guifg=#4f5578 gui=NONE cterm=NONE
hi! link LspKindBoolean Boolean
hi! link LspKindClass Type
hi! link LspKindColor Special
hi! link LspKindConstant Constant
hi LspKindConstructor guifg=#805000 gui=NONE cterm=NONE
hi! link LspKindEnum Type
hi! link LspKindEnumMember Constant
hi! link LspKindEvent Special
hi LspKindField guifg=#00656a gui=NONE cterm=NONE
hi! link LspKindFile Normal
hi! link LspKindFolder Directory
hi! link LspKindFunction Function
hi LspKindInterface guifg=#805000 gui=italic cterm=NONE
hi LspKindKey guifg=#00656a gui=NONE cterm=NONE
hi! link LspKindKeyword Keyword
hi! link LspKindMethod Function
hi LspKindModule guifg=#525494 gui=NONE cterm=NONE
hi LspKindNamespace guifg=#525494 gui=NONE cterm=NONE
hi LspKindNull guifg=#9c3c00 gui=NONE cterm=NONE
hi! link LspKindNumber Number
hi! link LspKindObject Constant
hi! link LspKindOperator Operator
hi LspKindPackage guifg=#525494 gui=NONE cterm=NONE
hi LspKindProperty guifg=#00656a gui=NONE cterm=NONE
hi LspKindReference guifg=#00656a gui=NONE cterm=NONE
hi LspKindSnippet guifg=#00656a gui=NONE cterm=NONE
hi! link LspKindString String
hi! link LspKindStruct Type
hi LspKindText gui=NONE cterm=NONE
hi LspKindTypeParameter guifg=#805000 gui=italic cterm=NONE
hi! link LspKindUnit Type
hi! link LspKindValue String
hi LspKindVariable guifg=#353a5c gui=NONE cterm=NONE
hi LspReferenceRead guibg=#d3d8e5 gui=NONE cterm=NONE
hi LspReferenceTarget guibg=#d3d8e5 gui=bold cterm=NONE
hi LspReferenceText guibg=#d3d8e5 gui=NONE cterm=NONE
hi LspReferenceWrite guibg=#d5b4d0 gui=NONE cterm=NONE
hi LspSignatureActiveParameter guifg=#9c3c00 guibg=#d3d8e5 gui=bold cterm=NONE
hi Macro guifg=#9c2d7a gui=NONE cterm=NONE
hi MatchParen guifg=#9c3c00 guibg=#c2c9dc gui=bold cterm=NONE
hi ModeMsg guifg=#4f5578 gui=bold cterm=NONE
hi MoreMsg guifg=#1d4fcf gui=NONE cterm=NONE
hi MsgArea guifg=#4f5578 gui=NONE cterm=NONE
hi MsgSeparator guifg=#c2c9dc guibg=#e0e4ee gui=NONE cterm=NONE
hi NonText guifg=#9da4bb gui=NONE cterm=NONE
hi Normal guifg=#353a5c guibg=#eef0f6 gui=NONE cterm=NONE
hi NormalFloat guifg=#353a5c guibg=#e0e4ee gui=NONE cterm=NONE
hi NormalNC guifg=#353a5c guibg=#eef0f6 gui=NONE cterm=NONE
hi NormalSB guifg=#4f5578 guibg=#e0e4ee gui=NONE cterm=NONE
hi Number guifg=#9c3c00 gui=NONE cterm=NONE
hi OkMsg guifg=#24680c gui=NONE cterm=NONE
hi Operator guifg=#2a5f7f gui=NONE cterm=NONE
hi Pmenu guifg=#353a5c guibg=#e0e4ee gui=NONE cterm=NONE
hi PmenuBorder guifg=#7b97e1 guibg=#e0e4ee gui=NONE cterm=NONE
hi PmenuExtra guifg=#686f8e guibg=#e0e4ee gui=NONE cterm=NONE
hi PmenuExtraSel guifg=#686f8e guibg=#d3d8e5 gui=NONE cterm=NONE
hi PmenuKind guifg=#525494 guibg=#e0e4ee gui=NONE cterm=NONE
hi PmenuKindSel guifg=#525494 guibg=#d3d8e5 gui=NONE cterm=NONE
hi PmenuMatch guifg=#1d4fcf guibg=#e0e4ee gui=bold cterm=NONE
hi PmenuMatchSel guifg=#1d4fcf guibg=#d3d8e5 gui=bold cterm=NONE
hi PmenuSbar guibg=#e2e5ee gui=NONE cterm=NONE
hi PmenuSel guibg=#d3d8e5 gui=bold cterm=NONE
hi PmenuThumb guibg=#c2c9dc gui=NONE cterm=NONE
hi PreCondit guifg=#9c2d7a gui=NONE cterm=NONE
hi PreProc guifg=#9c2d7a gui=NONE cterm=NONE
hi Question guifg=#1d4fcf gui=NONE cterm=NONE
hi QuickFixLine guibg=#c8d3ef gui=bold cterm=NONE
hi Removed guifg=#b7002f gui=NONE cterm=NONE
hi Repeat guifg=#7128df gui=italic cterm=NONE
hi Search guifg=#353a5c guibg=#d3c8b9 gui=NONE cterm=NONE
hi SignColumn guifg=#8f96b1 guibg=#eef0f6 gui=NONE cterm=NONE
hi SignColumnSB guifg=#8f96b1 guibg=#e0e4ee gui=NONE cterm=NONE
hi SnippetTabstop guibg=#d7d9e7 gui=NONE cterm=NONE
hi SnippetTabstopActive guibg=#c7c9de gui=NONE cterm=NONE
hi Special guifg=#00608c gui=NONE cterm=NONE
hi SpecialChar guifg=#9c2d7a gui=NONE cterm=NONE
hi SpecialComment guifg=#686f8e gui=italic cterm=NONE
hi SpecialKey guifg=#9da4bb gui=NONE cterm=NONE
hi SpellBad guisp=#b7002f gui=undercurl cterm=NONE
hi SpellCap guisp=#805000 gui=undercurl cterm=NONE
hi SpellLocal guisp=#2a5f7f gui=undercurl cterm=NONE
hi SpellRare guisp=#00656a gui=undercurl cterm=NONE
hi Statement guifg=#7128df gui=italic cterm=NONE
hi StatusLine guifg=#4f5578 guibg=#e0e4ee gui=NONE cterm=NONE
hi StatusLineNC guifg=#686f8e guibg=#e0e4ee gui=NONE cterm=NONE
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link StderrMsg ErrorMsg
hi StdoutMsg guifg=#4f5578 gui=NONE cterm=NONE
hi StorageClass guifg=#7128df gui=italic cterm=NONE
hi String guifg=#24680c gui=NONE cterm=NONE
hi Structure guifg=#805000 gui=NONE cterm=NONE
hi Substitute guifg=#eef0f6 guibg=#b7002f gui=NONE cterm=NONE
hi TabLine guifg=#686f8e guibg=#e0e4ee gui=NONE cterm=NONE
hi TabLineFill guibg=#d4d8e4 gui=NONE cterm=NONE
hi TabLineSel guifg=#eef0f6 guibg=#1d4fcf gui=bold cterm=NONE
hi Tag guifg=#b7002f gui=NONE cterm=NONE
hi TermCursor guifg=#eef0f6 guibg=#353a5c gui=NONE cterm=NONE
hi TermCursorNC guifg=#eef0f6 guibg=#8f96b1 gui=NONE cterm=NONE
hi Title guifg=#1d4fcf gui=bold cterm=NONE
hi Todo guifg=#eef0f6 guibg=#805000 gui=bold cterm=NONE
hi Type guifg=#805000 gui=NONE cterm=NONE
hi Typedef guifg=#805000 gui=NONE cterm=NONE
hi Underlined gui=underline cterm=NONE
hi VertSplit guifg=#c2c9dc gui=NONE cterm=NONE
hi Visual guibg=#c8d3ef gui=NONE cterm=NONE
hi VisualNOS guibg=#c8d3ef gui=NONE cterm=NONE
hi WarningMsg guifg=#805000 gui=NONE cterm=NONE
hi Whitespace guifg=#acb1c6 gui=NONE cterm=NONE
hi WildMenu guibg=#d3d8e5 gui=NONE cterm=NONE
hi WinBar guifg=#4f5578 guibg=#eef0f6 gui=NONE cterm=NONE
hi WinBarNC guifg=#686f8e guibg=#eef0f6 gui=NONE cterm=NONE
hi WinSeparator guifg=#c2c9dc gui=bold cterm=NONE
hi debugBreakpoint guifg=#b7002f guibg=#e6ccd8 gui=NONE cterm=NONE
hi debugPC guibg=#cfd8f0 gui=NONE cterm=NONE
hi diffAdded guifg=#24680c gui=NONE cterm=NONE
hi diffChanged guifg=#805000 gui=NONE cterm=NONE
hi diffFile guifg=#1d4fcf gui=bold cterm=NONE
hi diffIndexLine guifg=#7128df gui=NONE cterm=NONE
hi diffLine guifg=#686f8e gui=NONE cterm=NONE
hi diffNewFile guifg=#24680c gui=italic cterm=NONE
hi diffOldFile guifg=#b7002f gui=italic cterm=NONE
hi diffRemoved guifg=#b7002f gui=NONE cterm=NONE
hi dosIniLabel guifg=#00656a gui=NONE cterm=NONE
hi gitcommitSummary guifg=#353a5c gui=bold cterm=NONE
hi healthError guifg=#b7002f gui=NONE cterm=NONE
hi healthSuccess guifg=#24680c gui=NONE cterm=NONE
hi healthWarning guifg=#805000 gui=NONE cterm=NONE
hi helpCommand guifg=#1d4fcf guibg=#e2e5ee gui=NONE cterm=NONE
hi helpExample guifg=#686f8e gui=NONE cterm=NONE
hi htmlH1 guifg=#1d4fcf gui=bold cterm=NONE
hi htmlH2 guifg=#805000 gui=bold cterm=NONE
hi! link lCursor Cursor
hi markdownCode guifg=#00656a gui=NONE cterm=NONE
hi markdownCodeBlock guifg=#00656a gui=NONE cterm=NONE
hi markdownH1 guifg=#1d4fcf gui=bold cterm=NONE
hi markdownH2 guifg=#805000 gui=bold cterm=NONE
hi markdownLinkText guifg=#1d4fcf gui=underline cterm=NONE
hi qfFileName guifg=#1d4fcf gui=NONE cterm=NONE
hi qfLineNr guifg=#686f8e gui=NONE cterm=NONE

let g:terminal_ansi_colors = ["#4f5578", "#b7002f", "#24680c", "#805000", "#1d4fcf", "#9c2d7a", "#00656a", "#c2c9dc", "#686f8e", "#980027", "#1b4d09", "#613d00", "#1945b4", "#631eca", "#004b6d", "#d4d8e4"]
