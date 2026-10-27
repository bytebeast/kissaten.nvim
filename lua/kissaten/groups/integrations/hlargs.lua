local M = {}

M.url = "https://github.com/m-demare/hlargs.nvim"

--- Function arguments get the same color as parameters in the signature, so a
--- use of `x` deep in the body reads as "this came in as an argument".
--- hlargs only sets `Hlargs` itself when its `color` option is left alone.
---@type kissaten.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    Hlargs             = { fg = c.syn.parameter },
    HlargsUnused       = { fg = c.comment },
    ["@HlargsNamedParams"] = { fg = c.syn.parameter },
  }
end

return M
