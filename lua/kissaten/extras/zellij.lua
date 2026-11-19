-- zellij theme in the named-style spec (zellij 0.42+): every style in
-- zellij-utils THEME_STYLES with all six components, plus the multiplayer
-- colors. RGB triplets, like zellij's bundled themes.
local Util = require("kissaten.util")

local M = {}

--- Style names in the order zellij lists them (zellij-utils/src/kdl/mod.rs).
-- stylua: ignore
M.styles = {
  "text_unselected", "text_selected", "ribbon_unselected", "ribbon_selected", "ribbon_hover",
  "table_title", "table_cell_unselected", "table_cell_selected", "list_unselected", "list_selected",
  "frame_unselected", "frame_selected", "frame_highlight", "exit_code_success", "exit_code_error",
}

---@param c kissaten.Colors
function M.generate(c)
  local ui = c.ui
  local function rgb(color)
    return ("%d %d %d"):format(Util.rgb(color))
  end
  -- emphasis_0..3 mark keys and matches; on badges they're pulled toward
  -- the badge text until they read at 4.5:1
  local function style(base, bg, toward)
    local out = { base = base, background = bg }
    for i, color in ipairs({ c.orange, c.sky, c.green, c.pink }) do
      out["emphasis_" .. (i - 1)] = Util.ensure_contrast(color, bg, 4.5, toward or c.fg)
    end
    return out
  end
  local unselected = style(c.fg, c.mantle)
  local selected = style(c.fg, ui.bg_sel)
  local defs = {
    text_unselected = unselected,
    text_selected = selected,
    ribbon_unselected = style(c.subtext, c.surface0),
    ribbon_selected = style(ui.on_badge, ui.accent, ui.on_badge),
    ribbon_hover = style(c.fg, c.surface1),
    table_title = style(ui.accent, c.mantle),
    table_cell_unselected = unselected,
    table_cell_selected = selected,
    list_unselected = unselected,
    list_selected = selected,
    frame_unselected = style(ui.border, c.bg),
    frame_selected = style(ui.accent, c.bg),
    frame_highlight = style(c.orange, c.bg),
    exit_code_success = style(c.diag.ok, c.bg),
    exit_code_error = style(c.diag.error, c.bg),
  }
  local out = {
    ("// %s for zellij"):format(c._display),
    "// upstream: " .. c._upstream,
    ('// Copy to ~/.config/zellij/themes/, then set `theme "kissaten_%s"`'):format(c.style),
    "themes {",
    ("    kissaten_%s {"):format(c.style),
  }
  for _, name in ipairs(M.styles) do
    local d = defs[name]
    out[#out + 1] = ("        %s {"):format(name)
    for _, k in ipairs({ "base", "background", "emphasis_0", "emphasis_1", "emphasis_2", "emphasis_3" }) do
      out[#out + 1] = ("            %s %s"):format(k, rgb(d[k]))
    end
    out[#out + 1] = "        }"
  end
  out[#out + 1] = "        multiplayer_user_colors {"
  local players = { c.pink, c.blue, c.orange, c.yellow, c.sky, c.green, c.red, c.lavender, c.teal, c.purple }
  for i, color in ipairs(players) do
    out[#out + 1] = ("            player_%d %s"):format(i, rgb(color))
  end
  out[#out + 1] = "        }"
  out[#out + 1] = "    }"
  out[#out + 1] = "}"
  return table.concat(out, "\n") .. "\n"
end

return M
