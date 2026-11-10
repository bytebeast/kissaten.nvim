-- Zed theme family (one theme per file). Keys from zed's ThemeColorsContent
-- and StatusColorsContent (crates/settings_content/src/theme.rs); syntax
-- keys are the captures zed's bundled themes style (assets/themes/one).
-- Zed paints these behind text, so solid colors land exactly where Neovim's
-- do; only player selections stay translucent, as zed's own themes do.
local Util = require("kissaten.util")

local M = {}

local function str(s)
  return '"' .. s:gsub('[\\"]', "\\%0") .. '"'
end

---@param c kissaten.Colors
function M.generate(c)
  local s, ui, d, g, t = c.syn, c.ui, c.diag, c.git, c.terminal
  local st = c._styles or {}
  local function dim(color)
    return Util.blend(color, c.bg, 0.7)
  end
  local function soft(color) -- status backgrounds, like Neovim's tinted virtual text
    return Util.tint(color, c.bg, c.light and 0.1 or 0.08)
  end

  -- stylua: ignore
  local colors = {
    { "background", c.mantle },
    { "border", ui.border },
    { "border.variant", ui.border },
    { "border.focused", ui.border_float },
    { "border.selected", ui.accent },
    { "border.transparent", "#00000000" },
    { "border.disabled", c.surface1 },
    { "elevated_surface.background", ui.bg_popup },
    { "surface.background", ui.bg_sidebar },
    { "element.background", c.surface0 },
    { "element.hover", c.surface1 },
    { "element.active", c.surface2 },
    { "element.selected", ui.bg_sel },
    { "element.disabled", c.surface0 },
    { "element.selection_background", ui.bg_visual },
    { "drop_target.background", ui.bg_visual },
    { "drop_target.border", ui.accent },
    { "ghost_element.background", "#00000000" },
    { "ghost_element.hover", c.surface0 },
    { "ghost_element.active", c.surface1 },
    { "ghost_element.selected", ui.bg_sel },
    { "ghost_element.disabled", "#00000000" },
    { "text", c.fg },
    { "text.muted", c.subtext },
    { "text.placeholder", c.comment },
    { "text.disabled", c.overlay0 },
    { "text.accent", ui.accent },
    { "icon", c.subtext },
    { "icon.muted", c.comment },
    { "icon.disabled", c.overlay0 },
    { "icon.placeholder", c.comment },
    { "icon.accent", ui.accent },
    { "debugger.accent", d.error },
    { "status_bar.background", ui.bg_statusline },
    { "title_bar.background", c.mantle },
    { "title_bar.inactive_background", c.crust },
    { "toolbar.background", c.bg },
    { "tab_bar.background", c.crust },
    { "tab.inactive_background", c.mantle },
    { "tab.active_background", c.bg },
    { "search.match_background", ui.bg_search },
    { "search.active_match_background", Util.tint(c.orange, c.bg, 0.4) },
    { "panel.background", ui.bg_sidebar },
    { "panel.focused_border", ui.accent },
    { "panel.indent_guide", ui.indent },
    { "panel.indent_guide_hover", c.overlay0 },
    { "panel.indent_guide_active", ui.indent_scope },
    { "pane.focused_border", ui.accent },
    { "pane_group.border", ui.border },
    { "scrollbar.thumb.background", c.surface2 },
    { "scrollbar.thumb.hover_background", c.overlay0 },
    { "scrollbar.thumb.active_background", c.overlay0 },
    { "scrollbar.thumb.border", "#00000000" },
    { "scrollbar.track.background", "#00000000" },
    { "scrollbar.track.border", "#00000000" },
    { "editor.foreground", c.fg },
    { "editor.background", c.bg },
    { "editor.gutter.background", c.bg },
    { "editor.subheader.background", c.mantle },
    { "editor.active_line.background", ui.bg_cursorline },
    { "editor.highlighted_line.background", ui.bg_cursorline },
    { "editor.debugger_active_line.background", Util.tint(c.yellow, c.bg, 0.14) },
    { "editor.line_number", ui.fg_gutter },
    { "editor.active_line_number", ui.fg_gutter_cur },
    { "editor.hover_line_number", c.subtext },
    { "editor.invisible", ui.whitespace },
    { "editor.wrap_guide", ui.indent },
    { "editor.active_wrap_guide", c.overlay0 },
    { "editor.indent_guide", ui.indent },
    { "editor.indent_guide_active", ui.indent_scope },
    { "editor.document_highlight.read_background", ui.bg_read },
    { "editor.document_highlight.write_background", ui.bg_write },
    { "editor.document_highlight.bracket_background", ui.bg_match },
    { "editor.diff_hunk.added.background", c.diff.add },
    { "editor.diff_hunk.deleted.background", c.diff.delete },
    { "terminal.background", c.bg },
    { "terminal.foreground", c.fg },
    { "terminal.ansi.background", c.bg },
    { "terminal.bright_foreground", t.white_bright },
    { "terminal.dim_foreground", c.subtext },
    { "link_text.hover", c.teal },
    { "version_control.added", g.add },
    { "version_control.deleted", g.delete },
    { "version_control.modified", g.change },
    { "version_control.renamed", c.blue },
    { "version_control.conflict", g.conflict },
    { "version_control.ignored", g.ignore },
    { "version_control.word_added", c.diff.text_add },
    { "version_control.word_deleted", Util.tint(g.delete, c.bg, 0.32) },
    { "version_control.conflict_marker.ours", Util.tint(g.add, c.bg, 0.17) },
    { "version_control.conflict_marker.theirs", Util.tint(c.orange, c.bg, 0.17) },
    { "vim.normal.background", ui.modes.normal },
    { "vim.insert.background", ui.modes.insert },
    { "vim.replace.background", ui.modes.replace },
    { "vim.visual.background", ui.modes.visual },
    { "vim.visual_line.background", ui.modes.visual },
    { "vim.visual_block.background", ui.modes.visual },
    { "vim.helix_normal.background", ui.modes.normal },
    { "vim.helix_select.background", ui.modes.visual },
    { "vim.normal.foreground", ui.on_badge },
    { "vim.insert.foreground", ui.on_badge },
    { "vim.replace.foreground", ui.on_badge },
    { "vim.visual.foreground", ui.on_badge },
    { "vim.visual_line.foreground", ui.on_badge },
    { "vim.visual_block.foreground", ui.on_badge },
    { "vim.helix_normal.foreground", ui.on_badge },
    { "vim.helix_select.foreground", ui.on_badge },
    { "vim.helix_jump_label.foreground", c.pink },
    { "vim.yank.background", ui.bg_search },
  }
  -- stylua: ignore
  for _, name in ipairs({ "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }) do
    colors[#colors + 1] = { "terminal.ansi." .. name, t[name] }
    colors[#colors + 1] = { "terminal.ansi.bright_" .. name, t[name .. "_bright"] }
    colors[#colors + 1] = { "terminal.ansi.dim_" .. name, dim(t[name]) }
  end
  -- stylua: ignore
  local status = {
    { "conflict", g.conflict }, { "created", g.add }, { "deleted", g.delete }, { "modified", g.change },
    { "renamed", c.blue }, { "ignored", g.ignore }, { "hidden", c.overlay0 }, { "unreachable", c.overlay0 },
    { "error", d.error }, { "warning", d.warn }, { "info", d.info }, { "hint", d.hint }, { "success", d.ok },
    { "predictive", c.comment },
  }
  for _, kv in ipairs(status) do
    colors[#colors + 1] = kv
    colors[#colors + 1] = { kv[1] .. ".background", soft(kv[2]) }
    colors[#colors + 1] = { kv[1] .. ".border", Util.blend(kv[2], c.bg, 0.5) }
  end

  local function italic(attrs)
    return attrs and attrs.italic and "italic" or nil
  end
  -- { capture, color, font_style?, font_weight? }
  -- stylua: ignore
  local syntax = {
    { "attribute", s.attribute },
    { "boolean", s.boolean },
    { "comment", s.comment, italic(st.comments) },
    { "comment.doc", s.comment, italic(st.comments) },
    { "constant", s.constant },
    { "constructor", s.constructor },
    { "embedded", c.fg },
    { "emphasis", c.fg, "italic" },
    { "emphasis.strong", c.fg, nil, 700 },
    { "enum", s.type },
    { "function", s.func },
    { "hint", c.comment, italic(st.inlay_hints) },
    { "keyword", s.keyword, italic(st.keywords) },
    { "label", s.label },
    { "link_text", c.blue },
    { "link_uri", c.teal },
    { "namespace", s.module },
    { "number", s.number },
    { "operator", s.operator },
    { "predictive", c.comment, "italic" },
    { "preproc", s.preproc },
    { "primary", c.fg },
    { "property", s.property },
    { "punctuation", s.punct },
    { "punctuation.bracket", s.punct },
    { "punctuation.delimiter", s.punct },
    { "punctuation.list_marker", c.orange },
    { "punctuation.markup", c.overlay0 },
    { "punctuation.special", s.punct_special },
    { "selector", s.tag },
    { "selector.pseudo", s.tag_attribute },
    { "string", s.string },
    { "string.escape", s.escape },
    { "string.regex", s.regex },
    { "string.special", s.string_special },
    { "string.special.symbol", s.string_special },
    { "tag", s.tag },
    { "text.literal", c.teal },
    { "title", c.rainbow[1], nil, 700 },
    { "type", s.type },
    { "variable", s.variable },
    { "variable.parameter", s.parameter },
    { "variable.special", s.variable_builtin },
    { "variant", s.constant },
    { "diff.plus", g.add },
    { "diff.minus", g.delete },
  }

  local L = {}
  local function add(line)
    L[#L + 1] = line
  end
  add("{")
  add('  "$schema": "https://zed.dev/schema/themes/v0.2.0.json",')
  add(('  "name": %s,'):format(str(c._display)))
  add(('  "author": %s,'):format(str(c._upstream)))
  add('  "themes": [')
  add("    {")
  add(('      "name": %s,'):format(str(c._display)))
  add(('      "appearance": "%s",'):format(c.light and "light" or "dark"))
  add('      "style": {')
  for _, kv in ipairs(colors) do
    add(("        %s: %s,"):format(str(kv[1]), str(kv[2])))
  end
  local accents = {}
  for _, color in ipairs(c.rainbow) do
    accents[#accents + 1] = str(color)
  end
  add(('        "accents": [%s],'):format(table.concat(accents, ", ")))
  add('        "players": [')
  local players = { ui.accent, c.green, c.purple, c.orange, c.teal, c.pink, c.yellow, c.red }
  for i, color in ipairs(players) do
    add(
      ('          { "cursor": %s, "background": %s, "selection": %s }%s'):format(
        str(color),
        str(color),
        str(color .. (c.light and "33" or "3d")),
        i < #players and "," or ""
      )
    )
  end
  add("        ],")
  add('        "syntax": {')
  for i, e in ipairs(syntax) do
    local parts = { '"color": ' .. str(e[2]) }
    if e[3] then
      parts[#parts + 1] = '"font_style": ' .. str(e[3])
    end
    if e[4] then
      parts[#parts + 1] = '"font_weight": ' .. e[4]
    end
    add(("          %s: { %s }%s"):format(str(e[1]), table.concat(parts, ", "), i < #syntax and "," or ""))
  end
  add("        }")
  add("      }")
  add("    }")
  add("  ]")
  add("}")
  return table.concat(L, "\n") .. "\n"
end

return M
