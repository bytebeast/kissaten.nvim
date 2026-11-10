-- foot (Wayland terminal). foot has a dark and a light color section; the
-- light style fills [colors-light], which foot uses with
-- `initial-color-theme=light` or its theme-switch key bindings.
-- Colors are RRGGBB without "#" (foot.ini(5)).
local M = {}

---@param c kissaten.Colors
function M.generate(c)
  local function hex(color)
    return (color:gsub("^#", ""))
  end
  local t, on = c.terminal, hex(c.ui.on_badge)
  -- stylua: ignore
  local lines = {
    ("# %s: %s"):format(c._display, c._upstream),
    c.light and "# light style: set initial-color-theme=light in [main], or toggle with color-theme-toggle"
      or "# dark style: foot's default color section",
    c.light and "[colors-light]" or "[colors-dark]",
    "foreground=" .. hex(c.fg),
    "background=" .. hex(c.bg),
    ("cursor=%s %s"):format(hex(c.bg), hex(c.fg)),
    "selection-foreground=" .. hex(c.fg),
    "selection-background=" .. hex(c.ui.bg_visual),
    "urls=" .. hex(c.teal),
    ("jump-labels=%s %s"):format(on, hex(c.yellow)),
    ("scrollback-indicator=%s %s"):format(on, hex(c.blue)),
    ("search-box-no-match=%s %s"):format(on, hex(c.diag.error)),
    ("search-box-match=%s %s"):format(on, hex(c.yellow)),
    "",
    "regular0=" .. hex(t.black),
    "regular1=" .. hex(t.red),
    "regular2=" .. hex(t.green),
    "regular3=" .. hex(t.yellow),
    "regular4=" .. hex(t.blue),
    "regular5=" .. hex(t.magenta),
    "regular6=" .. hex(t.cyan),
    "regular7=" .. hex(t.white),
    "bright0=" .. hex(t.black_bright),
    "bright1=" .. hex(t.red_bright),
    "bright2=" .. hex(t.green_bright),
    "bright3=" .. hex(t.yellow_bright),
    "bright4=" .. hex(t.blue_bright),
    "bright5=" .. hex(t.magenta_bright),
    "bright6=" .. hex(t.cyan_bright),
    "bright7=" .. hex(t.white_bright),
    "16=" .. hex(c.orange),
    "17=" .. hex(c.red),
  }
  return table.concat(lines, "\n") .. "\n"
end

return M
