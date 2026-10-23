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
  }
  for i = 1, 6 do
    local color = c.rainbow[i]
    hl["RenderMarkdownH" .. i] = { fg = color, bold = true }
    hl["RenderMarkdownH" .. i .. "Bg"] = { bg = Util.tint(color, c.bg, 0.12) }
  end
  return hl
end

return M
