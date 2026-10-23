-- Zettlr theme as Custom CSS (https://docs.zettlr.com/en/guides/custom-css/).
-- Uses Zettlr's documented editor variables (--zettlr-editor-*) plus the
-- CodeMirror classes Zettlr assigns for syntax highlighting. Selectors are
-- prefixed with `html body` so they outrank Zettlr's built-in rules.
--
-- Each file applies in one Zettlr mode only: morning when dark mode is off,
-- the dark styles when it's on. Concatenate a light and a dark file to get a
-- theme that follows Zettlr's dark-mode toggle.
local Util = require("kissaten.util")

local M = {}

---@param c kissaten.Colors
function M.generate(c)
  local t = vim.deepcopy(c)
  t._mode = c.light and "html body:not(.dark)" or "html body.dark"
  -- extra id-level specificity for Zettlr's chrome, whose own rules carry Vue
  -- scoped attributes and per-platform classes
  t._boost = t._mode .. ":not(#kissaten)"
  t._mode_name = c.light and "light mode (dark mode off)" or "dark mode"
  t._cite_bg = Util.blend(c.orange, c.bg, 0.12)
  t._tag_bg = Util.blend(c.blue, c.bg, 0.12)
  t._comment_style = (c._styles and c._styles.comments and c._styles.comments.italic) and "italic" or "normal"
  t._keyword_style = (c._styles and c._styles.keywords and c._styles.keywords.italic) and "italic" or "normal"
  for i = 1, 6 do
    t["_h" .. i] = c.rainbow[i]
  end
  return require("kissaten.extras").template(
    [[
/*
 * ${_display} for Zettlr (applies in ${_mode_name})
 * upstream: ${_upstream}
 *
 * Install: Zettlr -> Assets Manager -> Custom CSS, paste this file, save.
 * To follow Zettlr's dark mode, paste a light and a dark file together, e.g.
 *   cat kissaten_morning.css kissaten_evening.css
 * Themes the editor, file manager, sidebar, menu bar, toolbar, tabs and
 * status bar.
 */

/* ── Editor colors (Zettlr's documented variables) ─────────────────────── */
${_mode} .cm-editor {
  --zettlr-editor-scroller-color: ${fg};
  --zettlr-editor-scroller-bg: ${bg};
  --zettlr-editor-primary-color: ${blue};
  --zettlr-editor-secondary-color: ${green};
  --zettlr-editor-selection-color: ${ui.bg_visual};
  --zettlr-editor-highlight-color: ${ui.bg_search};
  --zettlr-editor-code-color: ${teal};
  --zettlr-editor-code-bg: ${surface0};
  --zettlr-editor-citation-color: ${orange};
  --zettlr-editor-citation-bg: ${_cite_bg};
  --zettlr-editor-escape-color: ${pink};
  --zettlr-editor-accent-color: ${crust};
  --zettlr-editor-accent-bg: ${lavender};
  --zettlr-editor-error-color: ${red};
}

/* Zettlr's accent (selected files, toggles, focus) normally follows your OS
   accent color. Delete these two lines to keep that behavior. */
${_mode} { --system-accent-color: ${blue}; --system-accent-color-contrast: ${crust}; }

${_mode} .main-editor-wrapper { background-color: ${bg}; }
${_mode} .cm-editor .cm-gutters { background-color: ${bg}; color: ${ui.fg_gutter}; border-right-color: ${surface0}; }
${_mode} .cm-editor .cm-activeLineGutter { color: ${ui.fg_gutter_cur}; }
${_mode} .cm-editor .code-block-line-background { background-color: ${mantle}; }
${_mode} .cm-editor .inline-code-background { background-color: ${surface0}; }
${_mode} .cm-editor .cm-quote { color: ${subtext}; }
${_mode} .cm-editor .cm-code-mark { color: ${overlay0}; }
${_mode} .cm-editor .cm-zkn-tag { color: ${blue}; background-color: ${_tag_bg}; border-radius: 3px; }
${_mode} .cm-editor .cm-zkn-link { color: ${teal}; }

/* Headings: same colors as kissaten's markdown headings in Neovim */
${_mode} .cm-editor .cm-header-1 { color: ${_h1}; }
${_mode} .cm-editor .cm-header-2 { color: ${_h2}; }
${_mode} .cm-editor .cm-header-3 { color: ${_h3}; }
${_mode} .cm-editor .cm-header-4 { color: ${_h4}; }
${_mode} .cm-editor .cm-header-5 { color: ${_h5}; }
${_mode} .cm-editor .cm-header-6 { color: ${_h6}; }

/* ── Code block syntax highlighting (same roles as in Neovim) ────────────── */
${_mode} .cm-editor .cm-comment,
${_mode} .cm-editor .cm-line-comment,
${_mode} .cm-editor .cm-block-comment { color: ${syn.comment}; font-style: ${_comment_style}; }
${_mode} .cm-editor .cm-doc-comment,
${_mode} .cm-editor .cm-doc-string { color: ${syn.string_doc}; font-style: ${_comment_style}; }
${_mode} .cm-editor .cm-keyword,
${_mode} .cm-editor .cm-control-keyword,
${_mode} .cm-editor .cm-definition-keyword,
${_mode} .cm-editor .cm-operator-keyword,
${_mode} .cm-editor .cm-modifier { color: ${syn.keyword}; font-style: ${_keyword_style}; }
${_mode} .cm-editor .cm-module-keyword { color: ${syn.keyword_import}; font-style: ${_keyword_style}; }
${_mode} .cm-editor .cm-string { color: ${syn.string}; }
${_mode} .cm-editor .cm-character { color: ${syn.character}; }
${_mode} .cm-editor .cm-escape { color: ${syn.escape}; }
${_mode} .cm-editor .cm-regexp { color: ${syn.regex}; }
${_mode} .cm-editor .cm-number,
${_mode} .cm-editor .cm-integer,
${_mode} .cm-editor .cm-float,
${_mode} .cm-editor .cm-unit { color: ${syn.number}; }
${_mode} .cm-editor .cm-bool,
${_mode} .cm-editor .cm-null,
${_mode} .cm-editor .cm-atom { color: ${syn.boolean}; }
${_mode} .cm-editor .cm-literal,
${_mode} .cm-editor .cm-color { color: ${syn.constant}; }
${_mode} .cm-editor .cm-type-name,
${_mode} .cm-editor .cm-class-name { color: ${syn.type}; }
${_mode} .cm-editor .cm-namespace { color: ${syn.module}; }
${_mode} .cm-editor .cm-variable-name { color: ${syn.variable}; }
${_mode} .cm-editor .cm-self { color: ${syn.variable_builtin}; }
${_mode} .cm-editor .cm-property-name { color: ${syn.property}; }
${_mode} .cm-editor .cm-macro-name { color: ${syn.macro}; }
${_mode} .cm-editor .cm-annotation,
${_mode} .cm-editor .cm-meta { color: ${syn.attribute}; }
${_mode} .cm-editor .cm-operator,
${_mode} .cm-editor .cm-arithmetic-operator,
${_mode} .cm-editor .cm-logic-operator,
${_mode} .cm-editor .cm-bitwise-operator,
${_mode} .cm-editor .cm-compare-operator,
${_mode} .cm-editor .cm-update-operator,
${_mode} .cm-editor .cm-definition-operator,
${_mode} .cm-editor .cm-type-operator,
${_mode} .cm-editor .cm-control-operator,
${_mode} .cm-editor .cm-deref-operator { color: ${syn.operator}; }
${_mode} .cm-editor .cm-punctuation,
${_mode} .cm-editor .cm-separator,
${_mode} .cm-editor .cm-bracket,
${_mode} .cm-editor .cm-brace,
${_mode} .cm-editor .cm-paren,
${_mode} .cm-editor .cm-square-bracket { color: ${syn.punct}; }
${_mode} .cm-editor .cm-tag-name { color: ${syn.tag}; }
${_mode} .cm-editor .cm-angle-bracket { color: ${syn.tag_delimiter}; }
${_mode} .cm-editor .cm-attribute-name { color: ${syn.tag_attribute}; font-style: italic; }
${_mode} .cm-editor .cm-attribute-value { color: ${syn.string}; }
${_mode} .cm-editor .cm-inserted { color: ${git.add}; }
${_mode} .cm-editor .cm-deleted { color: ${git.delete}; }
${_mode} .cm-editor .cm-changed { color: ${git.change}; }
${_mode} .cm-editor .cm-invalid { color: ${diag.error}; text-decoration: underline wavy ${diag.error}; }

/* ── File manager and sidebar ─────────────────────────────────────────── */
/* Zettlr paints these per platform (body.linux / .darwin / .win32); the id
   selector outranks all of them. */
${_mode} #file-manager,
${_mode} #sidebar { background-color: ${mantle}; color: ${subtext}; }
${_mode} #file-manager #file-tree,
${_mode} #file-manager #file-list,
${_mode} #file-manager .tree-item.directory:not(.collapsed),
${_mode} #file-manager div.list-item-wrapper,
${_mode} #file-manager div.list-item,
${_mode} #file-manager div.list-item div.filename div.date { background-color: ${mantle}; }
${_mode} #file-manager div.list-item { border-bottom-color: ${surface0}; }
${_boost} #file-manager input.file-manager-filter-input { background-color: ${surface0}; color: ${fg}; border-color: ${surface1}; }
${_boost} #file-manager input.file-manager-filter-input::placeholder { color: ${comment}; }

/* ── Window chrome ────────────────────────────────────────────────────── */
/* `:not(#kissaten)` matches every element but counts as an id, so these
   outrank Zettlr's chrome rules (Vue scoped attributes, per-platform classes
   like body.linux.dark) without assuming any particular page structure. */
${_boost} div#window-content { background-color: ${mantle}; }
${_boost} #menubar { background-color: ${crust}; color: ${subtext}; }
${_boost} div#toolbar { background-color: ${mantle}; color: ${subtext}; }
${_boost} div#toolbar button { color: ${subtext}; border-color: ${surface2}; }
${_boost} div#toolbar button:hover,
${_boost} div#toolbar button.active { background-color: ${surface1}; color: ${fg}; }
${_boost} div.tab-container { background-color: ${crust}; }
${_boost} div.tab-container div[role="tab"] { background-color: ${crust}; color: ${comment}; border-color: ${surface0}; }
${_boost} div.tab-container div[role="tab"]:hover { background-color: ${surface0}; color: ${subtext}; }
${_boost} div.tab-container div[role="tab"].active { background-color: ${bg}; color: ${fg}; border-bottom-color: ${blue}; }
${_mode} .cm-editor .cm-panels,
${_mode} .cm-editor .cm-statusbar { background-color: ${mantle}; color: ${subtext}; }
]],
    t
  )
end

return M
