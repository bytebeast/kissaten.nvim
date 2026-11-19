-- zathura (PDF viewer) zathurarc. Option names from zathura/config.c.
-- Colors are quoted: zathurarc reads an unquoted "#" as a comment.
local Util = require("kissaten.util")

local M = {}

---@param c kissaten.Colors
function M.generate(c)
  local ui, d, on = c.ui, c.diag, c.ui.on_badge
  local function rgba(color, alpha)
    local r, g, b = Util.rgb(color)
    return ("rgba(%d,%d,%d,%s)"):format(r, g, b, alpha)
  end
  -- stylua: ignore
  local opts = {
    { "default-bg", c.bg },
    { "default-fg", c.fg },
    { "statusbar-bg", c.mantle },
    { "statusbar-fg", c.subtext },
    { "inputbar-bg", c.mantle },
    { "inputbar-fg", c.fg },
    { "completion-bg", ui.bg_popup },
    { "completion-fg", c.fg },
    { "completion-group-bg", ui.bg_popup },
    { "completion-group-fg", ui.title },
    { "completion-highlight-bg", ui.bg_sel },
    { "completion-highlight-fg", c.fg },
    { "notification-bg", c.surface0 },
    { "notification-fg", c.fg },
    { "notification-error-bg", d.error },
    { "notification-error-fg", on },
    { "notification-warning-bg", d.warn },
    { "notification-warning-fg", on },
    { "index-bg", c.bg },
    { "index-fg", c.fg },
    { "index-active-bg", ui.bg_sel },
    { "index-active-fg", c.fg },
    { "scrollbar-bg", c.mantle },
    { "scrollbar-fg", c.surface2 },
    { "render-loading-bg", c.bg },
    { "render-loading-fg", c.fg },
    -- recolor mode (:set recolor true) paints pages in the editor colors
    { "recolor-lightcolor", c.bg },
    { "recolor-darkcolor", c.fg },
    { "highlight-color", rgba(c.yellow, 0.4) },
    { "highlight-active-color", rgba(c.orange, 0.5) },
    { "visual-caret-color", rgba(c.fg, 0.7) },
    { "signature-success-color", rgba(d.ok, 0.9) },
    { "signature-warning-color", rgba(d.warn, 0.9) },
    { "signature-error-color", rgba(d.error, 0.9) },
  }
  local out = { ("# %s for zathura"):format(c._display), "# upstream: " .. c._upstream, "" }
  for _, o in ipairs(opts) do
    out[#out + 1] = ('set %s "%s"'):format(o[1], o[2])
  end
  return table.concat(out, "\n") .. "\n"
end

return M
