-- fish theme file for `fish_config theme choose` (fish 3.4+). Keys are the
-- documented fish_color_* and fish_pager_color_* variables
-- (doc_src/interactive.rst); no [light]/[dark] sections, so older fish
-- reads it too. Colors are RRGGBB without "#".
local M = {}

---@param c kissaten.Colors
function M.generate(c)
  local s, d, ui = c.syn, c.diag, c.ui
  local function hex(color)
    return (color:gsub("^#", ""))
  end
  local function bg(color)
    return "--background=" .. hex(color)
  end
  local comment = hex(s.comment) .. ((c._styles.comments or {}).italic and " --italics" or "")
  -- stylua: ignore
  local vars = {
    { "fish_color_normal", hex(c.fg) },
    { "fish_color_command", hex(s.func) },
    { "fish_color_builtin", hex(s.func_builtin) },
    { "fish_color_function", hex(s.func) },
    { "fish_color_keyword", hex(s.keyword) },
    { "fish_color_param", hex(s.parameter) },
    { "fish_color_option", hex(s.attribute) },
    { "fish_color_quote", hex(s.string) },
    { "fish_color_escape", hex(s.escape) },
    { "fish_color_redirection", hex(s.operator) },
    { "fish_color_operator", hex(s.operator) },
    { "fish_color_end", hex(s.punct_special) },
    { "fish_color_comment", comment },
    { "fish_color_error", hex(d.error) },
    { "fish_color_valid_path", "--underline" },
    { "fish_color_autosuggestion", hex(c.comment) },
    { "fish_color_selection", bg(ui.bg_visual) },
    { "fish_color_search_match", bg(ui.bg_search) },
    { "fish_color_history_current", hex(c.teal) .. " --bold" },
    { "fish_color_cancel", hex(d.error) },
    { "fish_color_cwd", hex(c.teal) },
    { "fish_color_cwd_root", hex(d.error) },
    { "fish_color_user", hex(c.green) },
    { "fish_color_host", hex(c.blue) },
    { "fish_color_host_remote", hex(c.yellow) },
    { "fish_color_status", hex(d.error) },
    { "fish_pager_color_progress", hex(c.comment) },
    { "fish_pager_color_prefix", hex(ui.pmenu_match) .. " --bold" },
    { "fish_pager_color_completion", hex(c.fg) },
    { "fish_pager_color_description", hex(c.comment) },
    { "fish_pager_color_selected_background", bg(ui.bg_sel) },
  }
  local out = {
    ("# name: '%s'"):format(c._display),
    ("# url: '%s'"):format(c._upstream),
    "# preferred_background: " .. hex(c.bg),
    "",
  }
  for _, v in ipairs(vars) do
    out[#out + 1] = v[1] .. " " .. v[2]
  end
  return table.concat(out, "\n") .. "\n"
end

return M
