---@mod kissaten.health :checkhealth kissaten
local M = {}

function M.check()
  local h = vim.health
  h.start("kissaten.nvim")

  if vim.fn.has("nvim-0.9") == 1 then
    local v = vim.version()
    h.ok(("Neovim %d.%d.%d"):format(v.major, v.minor, v.patch))
  else
    h.error("Neovim >= 0.9 is required")
  end
  if vim.fn.has("nvim-0.10") == 0 then
    h.warn("Neovim < 0.10: some newer highlight groups are simply ignored")
  end

  if vim.o.termguicolors then
    h.ok("'termguicolors' is on")
  else
    h.warn("'termguicolors' is off (it is enabled when the theme loads)")
  end

  local name = vim.g.colors_name or ""
  if name:find("^kissaten") then
    h.ok("Active: " .. name .. " (background=" .. vim.o.background .. ")")
  else
    h.info("kissaten is not the active colorscheme (current: " .. (name ~= "" and name or "none") .. ")")
  end

  local opts = require("kissaten.config").extend()
  local Groups = require("kissaten.groups")
  local installed = Groups.installed()
  if installed then
    h.ok("Plugin manager detected (lazy.nvim / vim.pack): integrations are auto-enabled")
  else
    h.info("No supported plugin manager detected: all integrations are enabled")
  end
  local enabled = Groups.enabled(opts)
  h.info(("%d integrations enabled: %s"):format(#enabled, table.concat(enabled, ", ")))

  -- Fail loudly if a user override broke a color.
  local ok, colors = pcall(require("kissaten").colors)
  if not ok then
    h.error("Building colors failed: " .. tostring(colors))
    return
  end
  local Util = require("kissaten.util")
  local bad = {}
  for role, value in pairs(colors.syn) do
    if not Util.is_hex(value) then
      bad[#bad + 1] = "syn." .. role .. "=" .. tostring(value)
    end
  end
  if #bad > 0 then
    h.warn("Non-hex syntax roles (check on_colors): " .. table.concat(bad, ", "))
  else
    h.ok("All syntax roles are valid colors")
  end

  local subtle = require("kissaten.config").subtle_comments(opts)
  if subtle and subtle.fade > 0 then
    h.info(
      ("subtle_comments: fade %.2f, comments at %.1f:1 (normally ~4.5:1)"):format(
        subtle.fade,
        Util.contrast(colors.syn.comment, colors.bg)
      )
    )
  end

  local low = {}
  local bg = colors.bg
  for role, value in pairs(colors.syn) do
    local intentional = role == "comment"
      or role == "deprecated"
      or role == "tag_delimiter"
      or (role == "string_doc" and subtle and subtle.docstrings)
    if Util.is_hex(value) and not intentional then
      local ratio = Util.contrast(value, bg)
      if ratio < 4.5 then
        low[#low + 1] = ("%s %.1f:1"):format(role, ratio)
      end
    end
  end
  if #low > 0 then
    h.warn("Syntax roles below WCAG AA (4.5:1) against the background: " .. table.concat(low, ", "))
  else
    h.ok("Every syntax role meets WCAG AA (4.5:1) against the background")
  end
end

return M
