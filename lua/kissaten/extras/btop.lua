-- btop theme. Keys are btop's Default_theme (src/btop_theme.cpp). Meters
-- that mean strain (temperature, CPU, memory used, processes) run green ->
-- yellow -> red; throughput and free memory use cool hues so the two kinds
-- don't read alike.
local M = {}

---@param c kissaten.Colors
function M.generate(c)
  local ui = c.ui
  -- stylua: ignore
  local keys = {
    { "main_bg", c.bg }, { "main_fg", c.fg }, { "title", c.fg }, { "hi_fg", ui.accent },
    { "selected_bg", ui.bg_sel }, { "selected_fg", c.fg }, { "inactive_fg", c.overlay0 },
    { "graph_text", c.subtext }, { "meter_bg", c.surface1 }, { "proc_misc", c.teal },
    { "cpu_box", c.blue }, { "mem_box", c.green }, { "net_box", c.purple }, { "proc_box", c.orange },
    { "div_line", ui.border },
    { "temp_start", c.green }, { "temp_mid", c.yellow }, { "temp_end", c.red },
    { "cpu_start", c.green }, { "cpu_mid", c.yellow }, { "cpu_end", c.red },
    { "free_start", c.teal }, { "free_mid", c.sky }, { "free_end", c.blue },
    { "cached_start", c.lavender }, { "cached_mid", c.blue }, { "cached_end", c.purple },
    { "available_start", c.teal }, { "available_mid", c.green }, { "available_end", c.green },
    { "used_start", c.green }, { "used_mid", c.yellow }, { "used_end", c.red },
    { "download_start", c.sky }, { "download_mid", c.blue }, { "download_end", c.lavender },
    { "upload_start", c.teal }, { "upload_mid", c.green }, { "upload_end", c.yellow },
    { "process_start", c.green }, { "process_mid", c.yellow }, { "process_end", c.red },
    { "proc_pause_bg", c.diag.error }, { "proc_follow_bg", c.blue },
    { "proc_banner_bg", c.surface1 }, { "proc_banner_fg", c.fg },
    { "followed_bg", c.blue }, { "followed_fg", ui.on_badge },
  }
  local out = { ("# %s: %s"):format(c._display, c._upstream) }
  for _, kv in ipairs(keys) do
    out[#out + 1] = ('theme[%s]="%s"'):format(kv[1], kv[2])
  end
  return table.concat(out, "\n") .. "\n"
end

return M
