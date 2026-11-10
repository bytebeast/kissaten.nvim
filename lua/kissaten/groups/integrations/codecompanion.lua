local M = {}

M.url = "https://github.com/olimorris/codecompanion.nvim"

--- codecompanion links its quiet text to `Comment`, which `subtle_comments`
--- fades: use the UI comment color. It links deleted inline text to
--- `DiffTextDelete`, which Neovim doesn't define, so it showed nothing.
---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    CodeCompanionChatSubtext        = { fg = c.comment },
    CodeCompanionChatTokens         = { fg = c.comment },
    CodeCompanionVirtualText        = { fg = c.comment, italic = true },
    CodeCompanionDiffBannerInline   = { fg = c.comment },
    CodeCompanionCodeReviewHeader   = { fg = c.comment },
    CodeCompanionCodeReviewSent     = { fg = c.comment },
    CodeCompanionDiffTextDelete     = "DiffDelete",
  }
end

return M
