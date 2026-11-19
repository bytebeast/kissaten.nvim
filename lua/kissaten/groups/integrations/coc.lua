local M = {}

M.url = "https://github.com/neoclide/coc.nvim"

--- coc hardcodes gruvbox-like hex for these (its ghost text, #504945, is
--- near invisible on dark styles). Diagnostics, semantic tokens and symbols
--- already link to groups kissaten themes.
---@type kissaten.HighlightsFn
function M.get(c)
  local ui = c.ui
  -- stylua: ignore
  return {
    CocVirtualText          = { fg = c.comment },
    CocInlineVirtualText    = { fg = c.comment, italic = true },
    CocCodeLens             = "LspCodeLens",
    CocInlayHint            = "LspInlayHint",
    CocSearch               = { fg = ui.pmenu_match, bold = true },
    CocSelectedText         = { fg = c.red },
    CocDisabled             = { fg = c.overlay0 },
    CocUnderline            = { underline = true },
    CocMarkdownLink         = "@markup.link.url",
    CocLink                 = { underline = true, sp = c.blue },
    CocNotificationProgress = { fg = ui.accent },
    CocNextEditInsert       = { fg = c.git.add, bg = c.diff.add },
    CocNextEditDelete       = { fg = c.git.delete, bg = c.diff.delete },
    CocHighlightText        = "LspReferenceText",
    CocHighlightRead        = "LspReferenceRead",
    CocHighlightWrite       = "LspReferenceWrite",
    CocUnusedHighlight      = "DiagnosticUnnecessary",
    CocDeprecatedHighlight  = "DiagnosticDeprecated",
    -- coc derives these from Normal by shifting lightness when it thinks
    -- floats look too much like the editor
    CocFloating             = "NormalFloat",
    CocPumMenu              = "Pmenu",
    CocMenuSel              = "PmenuSel",
    CocFloatThumb           = "PmenuThumb",
    CocFloatSbar            = "PmenuSbar",
    CocListLine             = "CursorLine",
  }
end

return M
