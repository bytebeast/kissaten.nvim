-- bat theme (Sublime .tmTheme). Built from kissaten's syntax roles rather
-- than hand-picked colors, so `bat` highlights code the way Neovim does.
-- bat names a theme after its file: kissaten_evening.tmTheme -> "kissaten_evening".
local Util = require("kissaten.util")

local M = {}

-- Ordered rules: { name, scopes, role (colors.syn key or "@path.to.color"), style? }
-- TextMate picks the most specific matching scope, so broad scopes
-- ("keyword") and narrow ones ("keyword.operator") can coexist.
-- `style` is "comments"/"keywords"/... to follow opts.styles, or literal
-- fontStyle words ("bold underline"). bat supports bold, italic, underline.
-- stylua: ignore
M.rules = {
  { "Comment", "comment, punctuation.definition.comment", "comment", "comments" },
  -- like Neovim: doc comments look like comments, Python docstrings like docstrings
  { "Doc comment", "comment.block.documentation, comment.line.documentation", "comment", "comments" },
  { "Docstring", "comment.block.documentation.python, string.quoted.docstring", "string_doc", "comments" },

  { "String", "string, string.quoted, string.template, string.unquoted, storage.type.string, punctuation.definition.string", "string", "strings" },
  { "String escape", "constant.character.escape, constant.character.format, constant.other.placeholder", "escape" },
  { "Format conversion", "storage.modifier.conversion", "macro" },
  { "Regex", "string.regexp, source.regexp, string.regexp constant, string.regexp keyword, string.regexp punctuation, string.regexp meta", "regex" },
  { "Symbol", "constant.other.symbol", "string_special" },
  { "Character", "constant.character", "character" },
  { "Interpolation", "punctuation.section.embedded, punctuation.definition.template-expression, punctuation.definition.interpolation", "punct_special" },

  { "Number", "constant.numeric", "number" },
  { "Boolean, null", "constant.language", "boolean" },
  { "Constant", "constant, variable.other.constant, support.constant, entity.name.constant, variable.other.enummember", "constant", "constants" },

  { "Keyword", "keyword, storage.type, storage.modifier, keyword.other", "keyword", "keywords" },
  { "Control flow", "keyword.control, keyword.control.flow, keyword.control.conditional, keyword.control.loop", "keyword_flow", "keywords" },
  { "Exception", "keyword.control.exception, keyword.control.trycatch, keyword.control.flow.raise, keyword.control.flow.throw, keyword.control.throw", "keyword_exception", "keywords" },
  { "Import", "keyword.control.import, keyword.control.export, keyword.control.from, keyword.other.import, keyword.other.using, keyword.control.directive.include, keyword.other.package, keyword.other.import", "keyword_import", "keywords" },
  { "Word operators", "keyword.operator.new, keyword.operator.expression, keyword.operator.word, keyword.operator.logical.python, keyword.operator.logical.lua", "keyword", "keywords" },
  { "Operator", "keyword.operator, punctuation.separator.key-value, punctuation.accessor", "operator" },
  { "Preprocessor", "meta.preprocessor, keyword.control.directive, punctuation.definition.directive", "preproc" },

  { "Function", "entity.name.function, support.function, meta.function-call entity.name.function, variable.function", "func", "functions" },
  { "Builtin function", "support.function.builtin, support.function.core, support.function.std", "func_builtin", "functions" },
  { "Macro", "entity.name.function.macro, support.macro, entity.name.macro", "macro" },
  { "Constructor", "entity.name.function.constructor, meta.class.instance.constructor", "constructor" },

  { "Type", "entity.name.type, entity.name.class, entity.name.struct, entity.name.enum, entity.name.union, entity.name.trait, entity.other.inherited-class, meta.type.annotation entity.name.type", "type", "types" },
  { "Interface", "entity.name.type.interface, entity.name.interface", "type", "italic" },
  -- support.* is TextMate's "provided by the language or its standard library"
  -- Neovim colors raised/constructed exceptions as constructors (plain type color)
  { "Exception class", "support.type.exception, support.class.exception", "type", "types" },
  { "Builtin type", "support.type, support.class, support.type.primitive, storage.type.primitive, storage.type.numeric, storage.type.built-in, support.type.builtin", "type_builtin", "types" },
  { "Namespace", "entity.name.namespace, entity.name.module, support.other.namespace, entity.name.package, meta.path entity.name.namespace, meta.import-path, meta.import-source", "module" },

  { "Variable", "variable, variable.other, variable.other.readwrite", "variable", "variables" },
  { "Builtin variable", "variable.language, variable.parameter.function.language.special.self, support.variable.self", "variable_builtin" },
  { "Parameter", "variable.parameter, meta.parameter variable, entity.name.variable.parameter", "parameter", "parameters" },
  { "Property", "variable.other.property, variable.other.member, variable.other.object.property, support.variable.property, meta.property-name, support.type.property-name, meta.object-literal.key, entity.name.variable.field, variable.object.property", "property" },
  { "Label", "entity.name.label, punctuation.definition.label", "label" },
  { "Lifetime", "storage.modifier.lifetime, entity.name.lifetime", "attribute" },
  { "Decorator", "meta.decorator, meta.annotation, entity.name.function.decorator, punctuation.decorator, storage.type.annotation, meta.attribute, punctuation.definition.annotation", "attribute" },

  { "Punctuation", "punctuation, meta.brace, punctuation.separator, punctuation.terminator", "punct" },

  { "Tag", "entity.name.tag", "tag" },
  { "Tag attribute", "entity.other.attribute-name", "tag_attribute", "italic" },
  { "Tag delimiter", "punctuation.definition.tag", "tag_delimiter" },

  -- data formats: keys are properties, not tags (YAML/TOML grammars use tag scopes)
  -- (JSON keys need the full inner scope to outrank the plain string rule)
  { "YAML/TOML/JSON/Lua keys", "entity.name.tag.yaml, meta.mapping.key.json string.quoted.double.json, meta.mapping.key.json punctuation.definition.string, string.unquoted.key, support.type.property-name.json, support.type.property-name.toml, keyword.key.toml, entity.name.tag.toml", "property" },
  -- Go puts type names in storage.type.go (its keywords are storage.type.keyword.*)
  { "Go types", "storage.type.go", "type", "types" },
  { "CSS selectors", "entity.other.attribute-name.class.css, entity.other.attribute-name.id.css, entity.other.attribute-name.pseudo-class.css", "type" },
  { "CSS units", "keyword.other.unit", "number" },

  -- markup (markdown, rst, ...)
  { "Heading", "markup.heading, entity.name.section, punctuation.definition.heading", "@blue", "bold" },
  { "Bold", "markup.bold", "@fg", "bold" },
  { "Italic", "markup.italic", "@fg", "italic" },
  { "Underline", "markup.underline", "@fg", "underline" },
  { "Inline code", "markup.raw, markup.inline.raw, markup.raw.inline", "@teal" },
  { "Code fence", "markup.raw.block, markup.fenced_code.block", "@fg" },
  { "Quote", "markup.quote", "@subtext", "italic" },
  { "List bullet", "markup.list punctuation.definition.list_item, punctuation.definition.list.begin, punctuation.definition.list_item", "@orange" },
  { "Link text", "markup.underline.link, string.other.link, meta.link.inline", "@teal", "underline" },
  { "Link url", "markup.underline.link.image, meta.link.reference.def, constant.other.reference.link", "@teal" },

  -- diffs (also used by delta when it falls back to the bat theme)
  { "Inserted", "markup.inserted, meta.diff.header.to-file, punctuation.definition.inserted", "@git.add" },
  { "Deleted", "markup.deleted, meta.diff.header.from-file, punctuation.definition.deleted", "@git.delete" },
  { "Changed", "markup.changed, punctuation.definition.changed", "@git.change" },
  { "Diff range", "meta.diff.range, meta.diff.index, meta.separator.diff", "@purple" },
  { "Diff header", "meta.diff.header", "@blue" },

  { "Invalid", "invalid, invalid.illegal", "@red", "underline" },
  { "Deprecated", "invalid.deprecated", "deprecated", "italic" },
}

local function esc(s)
  return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

--- fontStyle from a rule's style: an opts.styles category or literal words.
local function font_style(style, styles)
  if not style then
    return nil
  end
  local cat = styles and styles[style]
  if type(cat) == "table" then
    local words = {}
    for _, attr in ipairs({ "bold", "italic", "underline" }) do
      if cat[attr] then
        words[#words + 1] = attr
      end
    end
    return table.concat(words, " ")
  end
  return style
end

local function resolve(c, role)
  if role:sub(1, 1) == "@" then
    local v = c
    for part in role:sub(2):gmatch("[^%.]+") do
      v = v[part]
    end
    return v
  end
  return c.syn[role]
end

local function setting(key, value)
  return ("\t\t\t\t<key>%s</key>\n\t\t\t\t<string>%s</string>"):format(key, esc(value))
end

---@param c kissaten.Colors
function M.generate(c)
  local out = {
    '<?xml version="1.0" encoding="UTF-8"?>',
    '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">',
    "<!--",
    ("  %s for bat (and any tool that reads .tmTheme: Sublime Text, delta, ...)"):format(c._display),
    "  upstream: " .. c._upstream,
    -- XML comments may not contain a double dash, so no command-line flags here
    "  Install: copy into the themes folder of bat's config directory, rebuild",
    ("  bat's cache, then select the theme kissaten_%s (see the README)."):format(c.style),
    "-->",
    '<plist version="1.0">',
    "<dict>",
    "\t<key>name</key>",
    ("\t<string>%s</string>"):format(esc(c._display)),
    "\t<key>author</key>",
    "\t<string>kissaten.nvim</string>",
    "\t<key>semanticClass</key>",
    ("\t<string>theme.%s.kissaten_%s</string>"):format(c.light and "light" or "dark", c.style),
    "\t<key>colorSpaceName</key>",
    "\t<string>sRGB</string>",
    "\t<key>settings</key>",
    "\t<array>",
    "\t\t<dict>",
    "\t\t\t<key>settings</key>",
    "\t\t\t<dict>",
  }

  -- global editor colors (bat uses foreground, background, gutter, line highlight)
  local globals = {
    { "background", c.bg },
    { "foreground", c.fg },
    { "caret", c.fg },
    { "lineHighlight", c.ui.bg_cursorline },
    { "selection", c.ui.bg_visual },
    { "selectionBorder", c.ui.bg_visual },
    { "inactiveSelection", Util.blend(c.ui.bg_visual, c.bg, 0.6) },
    { "findHighlight", c.ui.bg_search },
    { "findHighlightForeground", c.fg },
    { "gutter", c.bg },
    { "gutterForeground", c.ui.fg_gutter },
    { "invisibles", c.ui.whitespace },
    { "guide", c.ui.indent },
    { "activeGuide", c.ui.indent_scope },
    { "stackGuide", c.ui.indent },
    { "bracketsForeground", c.orange },
    { "bracketContentsForeground", c.orange },
    { "shadow", c.crust },
  }
  for _, g in ipairs(globals) do
    out[#out + 1] = setting(g[1], g[2])
  end
  out[#out + 1] = "\t\t\t</dict>"
  out[#out + 1] = "\t\t</dict>"

  for _, rule in ipairs(M.rules) do
    local name, scope, role, style = rule[1], rule[2], rule[3], rule[4]
    local color = resolve(c, role)
    assert(Util.is_hex(color), ("bat: rule '%s' has no color for role '%s'"):format(name, role))
    out[#out + 1] = "\t\t<dict>"
    out[#out + 1] = ("\t\t\t<key>name</key>\n\t\t\t<string>%s</string>"):format(esc(name))
    out[#out + 1] = ("\t\t\t<key>scope</key>\n\t\t\t<string>%s</string>"):format(esc(scope))
    out[#out + 1] = "\t\t\t<key>settings</key>"
    out[#out + 1] = "\t\t\t<dict>"
    out[#out + 1] = setting("foreground", color)
    local fs = font_style(style, c._styles)
    if fs then -- always write it, even empty, so a broader rule's style can't leak in
      out[#out + 1] = setting("fontStyle", fs)
    end
    out[#out + 1] = "\t\t\t</dict>"
    out[#out + 1] = "\t\t</dict>"
  end

  out[#out + 1] = "\t</array>"
  out[#out + 1] = "</dict>"
  out[#out + 1] = "</plist>"
  return table.concat(out, "\n") .. "\n"
end

return M
