---@mod kissaten.semantic Per-variable colors (`rainbow_variables`)
---
--- JetBrains-style semantic highlighting: every local variable and parameter
--- gets a color picked from its name, so the same name has the same color
--- everywhere and different names are easy to tell apart. Driven by LSP
--- semantic tokens: each `variable`/`parameter` token is highlighted with
--- one of the `KissatenVariable<n>` groups (defined by the colorscheme).
local M = {}

M.group = "KissatenVariable"
M.augroup = "kissaten_rainbow_variables"

--- Number of `KissatenVariable<n>` groups currently defined (0 = off).
M.count = 0

--- Token types that get a per-name color. Properties, functions and types
--- keep their syntax colors: only names you invent locally are recolored.
M.types = { variable = true, parameter = true }

--- Stable string hash (djb2), so a name always maps to the same color.
---@param name string
---@param n integer number of colors
---@return integer 1..n
function M.index(name, n)
  local h = 5381
  for i = 1, #name do
    h = (h * 33 + name:byte(i)) % 4294967296
  end
  return h % n + 1
end

--- Group for a token, or nil when it shouldn't be recolored.
---@param token {type: string, modifiers: table<string, boolean>, line: integer, start_col: integer, end_col: integer}
---@param text string the token's text
---@return string?
function M.group_for(token, text)
  if M.count == 0 or not M.types[token.type] then
    return nil
  end
  -- library globals (console, window, print, ...) aren't "your" variables
  if token.modifiers and token.modifiers.defaultLibrary then
    return nil
  end
  if text == "" then
    return nil
  end
  return M.group .. M.index(text, M.count)
end

local function on_token(args)
  if not (vim.g.colors_name or ""):find("^kissaten") then
    return -- another colorscheme is active
  end
  local token = args.data.token
  local line = vim.api.nvim_buf_get_lines(args.buf, token.line, token.line + 1, false)[1]
  if not line then
    return
  end
  local group = M.group_for(token, line:sub(token.start_col + 1, token.end_col))
  if group then
    vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, group)
  end
end

--- Re-request semantic tokens so the change shows without editing.
local function refresh()
  local st = vim.lsp.semantic_tokens
  if not (st and st.force_refresh) then
    return
  end
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      pcall(st.force_refresh, buf)
    end
  end
end

--- Turn per-variable colors on (`count` groups) or off (0). Idempotent: the
--- autocommand is registered at most once, and only refreshes on a change.
---@param count integer
function M.setup(count)
  local changed = count ~= M.count
  -- clear groups this size no longer uses (switching 12 -> 6 -> off)
  for i = count + 1, M.count do
    vim.api.nvim_set_hl(0, M.group .. i, {})
  end
  M.count = count
  if count > 0 then
    local group = vim.api.nvim_create_augroup(M.augroup, { clear = true })
    vim.api.nvim_create_autocmd("LspTokenUpdate", { group = group, callback = on_token })
  else
    pcall(vim.api.nvim_del_augroup_by_name, M.augroup)
  end
  if changed then
    refresh()
  end
end

return M
