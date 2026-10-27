local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/MeanderingProgrammer/render-markdown.nvim"

---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  local hl = {
    RenderMarkdownCode       = { bg = c.mantle },
    RenderMarkdownCodeBorder = { bg = c.mantle },
    RenderMarkdownCodeInline = { fg = c.teal, bg = c.surface0 },
    RenderMarkdownBullet     = { fg = c.orange },
    RenderMarkdownDash       = { fg = c.overlay0 },
    RenderMarkdownQuote      = { fg = c.comment },
    RenderMarkdownLink       = { fg = c.teal },
    RenderMarkdownSign       = { fg = c.overlay0 },
    RenderMarkdownTableHead  = { fg = c.blue },
    RenderMarkdownTableRow   = { fg = c.overlay0 },
    RenderMarkdownTableFill  = "Conceal",
    RenderMarkdownChecked    = { fg = c.green },
    RenderMarkdownUnchecked  = { fg = c.overlay0 },
    RenderMarkdownTodo       = { fg = c.blue },
    RenderMarkdownSuccess    = { fg = c.diag.ok },
    RenderMarkdownInfo       = { fg = c.diag.info },
    RenderMarkdownHint       = { fg = c.diag.hint },
    RenderMarkdownWarn       = { fg = c.diag.warn },
    RenderMarkdownError      = { fg = c.diag.error },
    RenderMarkdownCodeInfo   = { fg = c.comment, bg = c.mantle, italic = true },
    RenderMarkdownCodeFallback = { fg = c.fg, bg = c.mantle },
    RenderMarkdownInlineHighlight = { fg = c.fg, bg = Util.tint(c.yellow, c.bg, 0.25) },
    RenderMarkdownMath       = { fg = c.cyan },
    RenderMarkdownIndent     = { fg = c.ui.indent },
    RenderMarkdownHtmlComment = { fg = c.comment, italic = true },
    RenderMarkdownLinkTitle  = { fg = c.teal, underline = true },
    RenderMarkdownWikiLink   = { fg = c.teal },
  }
  -- nested quotes step through the heading colors, muted like the quote text
  for i = 1, 6 do
    hl["RenderMarkdownQuote" .. i] = { fg = Util.blend(c.rainbow[i], c.comment, 0.5) }
  end
  for i = 1, 6 do
    local color = c.rainbow[i]
    hl["RenderMarkdownH" .. i] = { fg = color, bold = true }
    hl["RenderMarkdownH" .. i .. "Bg"] = { bg = Util.tint(color, c.bg, 0.12) }
  end
  return hl
end

return M
