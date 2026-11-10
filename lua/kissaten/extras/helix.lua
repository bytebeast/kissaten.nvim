-- Helix theme. Scopes from book/src/themes.md (syntax and interface keys),
-- colored from the same roles and UI colors Neovim uses, so code, diffs,
-- diagnostics and selections look the same in both editors.
local Util = require("kissaten.util")

local M = {}

--- TOML inline table for one style: { fg, bg, underline = { color, style }, modifiers }
local function style(s)
  if type(s) == "string" then
    return ('"%s"'):format(s)
  end
  local parts = {}
  for _, k in ipairs({ "fg", "bg" }) do
    if s[k] then
      parts[#parts + 1] = ('%s = "%s"'):format(k, s[k])
    end
  end
  if s.underline then
    parts[#parts + 1] = ('underline = { color = "%s", style = "%s" }'):format(s.underline[1], s.underline[2])
  end
  if s.modifiers and #s.modifiers > 0 then
    parts[#parts + 1] = ('modifiers = ["%s"]'):format(table.concat(s.modifiers, '", "'))
  end
  return "{ " .. table.concat(parts, ", ") .. " }"
end

---@param c kissaten.Colors
function M.generate(c)
  local s, ui, d, g = c.syn, c.ui, c.diag, c.git
  local st = c._styles or {}
  local function with(fg, attrs)
    local mods = {}
    for attr, mod in pairs({ italic = "italic", bold = "bold", underline = "underlined" }) do
      if attrs and attrs[attr] then
        mods[#mods + 1] = mod
      end
    end
    table.sort(mods)
    return #mods > 0 and { fg = fg, modifiers = mods } or fg
  end
  local function inline(color) -- like Neovim's tinted diagnostic virtual text
    return { fg = color, bg = Util.tint(color, c.bg, c.light and 0.1 or 0.08) }
  end
  local function badge(bg)
    return { fg = ui.on_badge, bg = bg, modifiers = { "bold" } }
  end

  -- stylua: ignore
  local scopes = {
    { "attribute", s.attribute },
    { "type", with(s.type, st.types) },
    { "type.builtin", s.type_builtin },
    { "type.parameter", s.type },
    { "type.enum.variant", s.constant },
    { "constructor", s.constructor },
    { "constant", with(s.constant, st.constants) },
    { "constant.builtin", s.boolean },
    { "constant.builtin.boolean", s.boolean },
    { "constant.character", s.character },
    { "constant.character.escape", s.escape },
    { "constant.numeric", s.number },
    { "string", with(s.string, st.strings) },
    { "string.regexp", s.regex },
    { "string.special", s.string_special },
    { "string.special.path", s.string_special },
    { "string.special.url", { fg = s.string_special, modifiers = { "underlined" } } },
    { "string.special.symbol", s.string_special },
    { "comment", with(s.comment, st.comments) },
    { "comment.unused", s.deprecated },
    { "variable", with(s.variable, st.variables) },
    { "variable.builtin", s.variable_builtin },
    { "variable.parameter", with(s.parameter, st.parameters) },
    { "variable.other.member", s.property },
    { "label", s.label },
    { "punctuation", s.punct },
    { "punctuation.special", s.punct_special },
    { "keyword", with(s.keyword, st.keywords) },
    { "keyword.control.conditional", with(s.keyword_flow, st.conditionals or st.keywords) },
    { "keyword.control.repeat", with(s.keyword_flow, st.loops or st.keywords) },
    { "keyword.control.return", with(s.keyword_flow, st.keywords) },
    { "keyword.control.import", with(s.keyword_import, st.keywords) },
    { "keyword.control.exception", with(s.keyword_exception, st.keywords) },
    { "keyword.directive", s.preproc },
    { "operator", s.operator },
    { "function", with(s.func, st.functions) },
    { "function.builtin", s.func_builtin },
    { "function.macro", s.macro },
    { "function.special", s.preproc },
    { "tag", s.tag },
    { "namespace", s.module },
    { "special", s.special },
    { "embedded", c.fg },

    { "markup.heading.marker", c.overlay0 },
    { "markup.list", c.orange },
    { "markup.list.checked", c.green },
    { "markup.list.unchecked", c.overlay0 },
    { "markup.bold", { modifiers = { "bold" } } },
    { "markup.italic", { modifiers = { "italic" } } },
    { "markup.strikethrough", { modifiers = { "crossed_out" } } },
    { "markup.link.url", { fg = c.teal, modifiers = { "underlined" } } },
    { "markup.link.label", c.blue },
    { "markup.link.text", c.blue },
    { "markup.quote", { fg = c.subtext, modifiers = { "italic" } } },
    { "markup.raw", c.teal },
    { "markup.raw.block", c.fg },

    { "diff.plus", g.add },
    { "diff.minus", g.delete },
    { "diff.delta", g.change },
    { "diff.delta.conflict", g.conflict },

    { "ui.background", { bg = ui.bg } },
    { "ui.background.separator", ui.border },
    { "ui.cursor", { fg = c.bg, bg = c.overlay0 } },
    { "ui.cursor.primary", { fg = c.bg, bg = c.fg } },
    { "ui.cursor.primary.insert", { fg = c.bg, bg = ui.modes.insert } },
    { "ui.cursor.primary.select", { fg = c.bg, bg = ui.modes.visual } },
    { "ui.cursor.match", { fg = c.orange, bg = ui.bg_match, modifiers = { "bold" } } },
    { "ui.debug.breakpoint", d.error },
    { "ui.debug.active", c.yellow },
    { "ui.linenr", ui.fg_gutter },
    { "ui.linenr.selected", { fg = ui.fg_gutter_cur, modifiers = { "bold" } } },
    { "ui.statusline", { fg = ui.fg_sidebar, bg = ui.bg_statusline } },
    { "ui.statusline.inactive", { fg = c.comment, bg = ui.bg_statusline } },
    { "ui.statusline.normal", badge(ui.modes.normal) },
    { "ui.statusline.insert", badge(ui.modes.insert) },
    { "ui.statusline.select", badge(ui.modes.visual) },
    { "ui.statusline.separator", ui.border },
    { "ui.bufferline", { fg = c.comment, bg = c.mantle } },
    { "ui.bufferline.active", badge(ui.accent) },
    { "ui.bufferline.background", { bg = c.crust } },
    { "ui.popup", { fg = c.fg, bg = ui.bg_float } },
    { "ui.popup.info", { fg = c.fg, bg = ui.bg_float } },
    { "ui.picker.header.column.active", { fg = ui.accent, modifiers = { "bold" } } },
    { "ui.window", ui.border },
    { "ui.help", { fg = c.fg, bg = ui.bg_float } },
    { "ui.text", c.fg },
    { "ui.text.focus", { fg = c.fg, bg = ui.bg_sel, modifiers = { "bold" } } },
    { "ui.text.inactive", c.comment },
    { "ui.text.info", ui.fg_dim },
    { "ui.text.directory", c.blue },
    { "ui.text.symlink", c.teal },
    { "ui.virtual.ruler", { bg = c.mantle } },
    { "ui.virtual.whitespace", ui.whitespace },
    { "ui.virtual.indent-guide", ui.indent },
    { "ui.virtual.inlay-hint", { fg = c.comment, bg = Util.blend(c.surface0, c.bg, 0.6) } },
    { "ui.virtual.wrap", ui.nontext },
    { "ui.virtual.jump-label", badge(c.pink) },
    { "ui.menu", { fg = c.fg, bg = ui.bg_popup } },
    { "ui.menu.selected", { bg = ui.bg_sel, modifiers = { "bold" } } },
    { "ui.menu.scroll", { fg = c.surface2, bg = c.surface0 } },
    { "ui.selection", { bg = ui.bg_visual } },
    { "ui.highlight", { bg = ui.bg_visual } },
    { "ui.highlight.frameline", { bg = Util.tint(c.yellow, c.bg, 0.14) } },
    { "ui.cursorline.primary", { bg = ui.bg_cursorline } },
    { "ui.cursorcolumn.primary", { bg = ui.bg_cursorline } },

    { "error", d.error },
    { "warning", d.warn },
    { "info", d.info },
    { "hint", d.hint },
    { "error.diagnostic.inline", inline(d.error) },
    { "warning.diagnostic.inline", inline(d.warn) },
    { "info.diagnostic.inline", inline(d.info) },
    { "hint.diagnostic.inline", inline(d.hint) },
    { "diagnostic.error", { underline = { d.error, "curl" } } },
    { "diagnostic.warning", { underline = { d.warn, "curl" } } },
    { "diagnostic.info", { underline = { d.info, "curl" } } },
    { "diagnostic.hint", { underline = { d.hint, "curl" } } },
    { "diagnostic.unnecessary", { modifiers = { "dim" } } },
    { "diagnostic.deprecated", { modifiers = { "crossed_out" } } },
    { "tabstop", { bg = Util.tint(c.lavender, c.bg, 0.15) } },
  }
  for i = 1, 6 do
    table.insert(scopes, { "markup.heading." .. i, { fg = c.rainbow[i], modifiers = { "bold" } } })
  end

  local out = { ("# %s: %s"):format(c._display, c._upstream), "" }
  for _, kv in ipairs(scopes) do
    out[#out + 1] = ('"%s" = %s'):format(kv[1], style(kv[2]))
  end
  -- rainbow brackets in rainbow-delimiters' nesting order, as in Neovim
  local b = c.brackets
  out[#out + 1] = ('rainbow = ["%s"]'):format(
    table.concat({ b.red, b.yellow, b.blue, b.orange, b.green, b.violet, b.cyan }, '", "')
  )
  return table.concat(out, "\n") .. "\n"
end

return M
