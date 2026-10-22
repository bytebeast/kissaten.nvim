local M = {}

M.url = "https://github.com/ibhagwan/fzf-lua"

---@type kissaten.HighlightsFn
function M.get(c)
  local fbg = c.ui.bg_float
  -- stylua: ignore
  return {
    FzfLuaNormal          = { fg = c.fg, bg = fbg },
    FzfLuaBorder          = { fg = c.ui.border_float, bg = fbg },
    FzfLuaTitle           = { fg = c.crust, bg = c.blue, bold = true },
    FzfLuaPreviewTitle    = { fg = c.crust, bg = c.green, bold = true },
    FzfLuaPreviewBorder   = { fg = c.ui.border_float, bg = fbg },
    FzfLuaCursor          = "IncSearch",
    FzfLuaCursorLine      = { bg = c.ui.bg_sel },
    FzfLuaCursorLineNr    = { fg = c.orange, bg = c.ui.bg_sel },
    FzfLuaSearch          = "IncSearch",
    FzfLuaScrollBorderFull = { fg = c.surface2 },
    FzfLuaScrollFloatFull = { bg = c.surface2 },
    FzfLuaDirPart         = { fg = c.comment },
    FzfLuaFilePart        = { fg = c.fg },
    FzfLuaPath            = "Directory",
    FzfLuaPathColNr       = { fg = c.comment },
    FzfLuaPathLineNr      = { fg = c.comment },
    FzfLuaBufName         = { fg = c.lavender },
    FzfLuaBufNr           = { fg = c.orange },
    FzfLuaBufFlagCur      = { fg = c.orange },
    FzfLuaBufFlagAlt      = { fg = c.blue },
    FzfLuaTabTitle        = { fg = c.teal, bold = true },
    FzfLuaTabMarker       = { fg = c.yellow, bold = true },
    FzfLuaHeaderBind      = { fg = c.orange },
    FzfLuaHeaderText      = { fg = c.comment },
    FzfLuaLiveSym         = { fg = c.orange },
    FzfLuaFzfNormal       = { fg = c.fg },
    FzfLuaFzfCursorLine   = { bg = c.ui.bg_sel },
    FzfLuaFzfMatch        = { fg = c.blue, bold = true },
    FzfLuaFzfBorder       = { fg = c.ui.border_float },
    FzfLuaFzfScrollbar    = { fg = c.surface2 },
    FzfLuaFzfSeparator    = { fg = c.overlay0 },
    FzfLuaFzfGutter       = { bg = fbg },
    FzfLuaFzfHeader       = { fg = c.comment },
    FzfLuaFzfInfo         = { fg = c.comment },
    FzfLuaFzfPointer      = { fg = c.pink },
    FzfLuaFzfMarker       = { fg = c.pink },
    FzfLuaFzfSpinner      = { fg = c.orange },
    FzfLuaFzfPrompt       = { fg = c.orange },
    FzfLuaFzfQuery        = { fg = c.fg },
  }
end

return M
