local Util = require("kissaten.util")

local M = {}

M.url = "https://github.com/OXY2DEV/markview.nvim"

--- Same look as render-markdown. markview derives everything else (headings,
--- code icons) from `MarkviewPalette<n>`, and only creates groups that don't
--- exist yet, so these win. Its callouts and checkboxes reuse heading
--- palette slots for meaning (1 = error, 4 = ok), which assumes Catppuccin's
--- heading order: here they get the diagnostic roles instead.
---@type kissaten.HighlightsFn
function M.get(c)
  local d = c.diag
  -- stylua: ignore
  local hl = {
    MarkviewCode              = { bg = c.mantle },
    MarkviewCodeInfo          = { fg = c.comment, bg = c.mantle },
    MarkviewInlineCode        = { fg = c.teal, bg = c.surface0 },
    MarkviewTableBorder       = { fg = c.overlay0 },

    MarkviewBlockQuoteDefault = { fg = c.comment },
    MarkviewBlockQuoteNote    = { fg = d.info },
    MarkviewBlockQuoteOk      = { fg = d.ok },
    MarkviewBlockQuoteWarn    = { fg = d.warn },
    MarkviewBlockQuoteError   = { fg = d.error },
    MarkviewBlockQuoteSpecial = { fg = c.purple },

    MarkviewCheckboxChecked   = { fg = c.green },
    MarkviewCheckboxUnchecked = { fg = c.overlay0 },
    MarkviewCheckboxPending   = { fg = d.warn },
    MarkviewCheckboxProgress  = { fg = c.blue },
    MarkviewCheckboxCancelled = { fg = c.comment },
    MarkviewCheckboxStriked   = { fg = c.comment, strikethrough = true },
  }
  local function palette(n, color, bg)
    hl["MarkviewPalette" .. n] = { fg = color, bg = bg }
    hl["MarkviewPalette" .. n .. "Fg"] = { fg = color }
    hl["MarkviewPalette" .. n .. "Bg"] = { bg = bg }
    hl["MarkviewPalette" .. n .. "Sign"] = { fg = color }
  end
  palette(0, c.comment, c.surface0)
  for i = 1, 6 do
    palette(i, c.rainbow[i], Util.tint(c.rainbow[i], c.bg, 0.12))
  end
  return hl
end

return M
