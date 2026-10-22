---@mod kissaten.groups.treesitter Treesitter captures (:h treesitter-highlight-groups)
local Util = require("kissaten.util")

local M = {}

local function badge(color, bg)
  return { fg = color, bg = Util.blend(color, bg, 0.14), bold = true }
end

---@type kissaten.HighlightsFn
function M.get(c, opts)
  local s = c.syn
  local st = opts.styles

  -- stylua: ignore
  local hl = {
    -- identifiers
    ["@variable"]                   = { fg = s.variable, style = st.variables },
    ["@variable.builtin"]           = { fg = s.variable_builtin, style = st.variables },
    ["@variable.parameter"]         = { fg = s.parameter, style = st.parameters },
    ["@variable.parameter.builtin"] = { fg = s.parameter, italic = true },
    ["@variable.member"]            = { fg = s.property },
    ["@property"]                   = { fg = s.property },

    ["@constant"]                   = "Constant",
    ["@constant.builtin"]           = { fg = s.constant, style = st.constants },
    ["@constant.macro"]             = { fg = s.macro },

    ["@module"]                     = { fg = s.module },
    ["@module.builtin"]             = { fg = s.variable_builtin },
    ["@label"]                      = "Label",

    -- literals
    ["@string"]                     = "String",
    ["@string.documentation"]       = { fg = s.string_doc, style = st.comments },
    ["@string.regexp"]              = { fg = s.regex },
    ["@string.escape"]              = { fg = s.escape },
    ["@string.special"]             = { fg = s.string_special },
    ["@string.special.symbol"]      = { fg = s.string_special },
    ["@string.special.path"]        = { fg = s.string_special, underline = true },
    ["@string.special.url"]         = { fg = s.string_special, underline = true },
    ["@character"]                  = "Character",
    ["@character.special"]          = { fg = s.escape },
    ["@character.printf"]           = { fg = s.escape },
    ["@boolean"]                    = "Boolean",
    ["@number"]                     = "Number",
    ["@number.float"]               = "Float",

    -- types
    ["@type"]                       = "Type",
    ["@type.builtin"]               = { fg = s.type_builtin, style = st.types },
    ["@type.definition"]            = "Type",
    ["@type.qualifier"]             = "@keyword.modifier",
    ["@attribute"]                  = { fg = s.attribute },
    ["@attribute.builtin"]          = { fg = s.attribute, italic = true },

    -- functions
    ["@function"]                   = "Function",
    ["@function.builtin"]           = { fg = s.func_builtin, style = st.functions },
    ["@function.call"]              = "@function",
    ["@function.macro"]             = { fg = s.macro },
    ["@function.method"]            = "@function",
    ["@function.method.call"]       = "@function.method",
    ["@constructor"]                = { fg = s.constructor },
    ["@constructor.lua"]            = { fg = s.punct }, -- `{}` table constructors are just braces
    ["@operator"]                   = "Operator",

    -- keywords
    ["@keyword"]                    = "Keyword",
    ["@keyword.coroutine"]          = "@keyword",
    ["@keyword.function"]           = "@keyword",
    ["@keyword.operator"]           = "@keyword",
    ["@keyword.import"]             = "Include",
    ["@keyword.type"]               = "@keyword",
    ["@keyword.modifier"]           = "@keyword",
    ["@keyword.repeat"]             = "Repeat",
    ["@keyword.return"]             = { fg = s.keyword_flow, style = st.keywords },
    ["@keyword.debug"]              = "Debug",
    ["@keyword.exception"]          = "Exception",
    ["@keyword.conditional"]        = "Conditional",
    ["@keyword.conditional.ternary"] = "@operator",
    ["@keyword.directive"]          = "PreProc",
    ["@keyword.directive.define"]   = "Define",

    -- punctuation
    ["@punctuation.delimiter"]      = { fg = s.punct },
    ["@punctuation.bracket"]        = { fg = s.punct },
    ["@punctuation.special"]        = { fg = s.punct_special },

    -- comments
    ["@comment"]                    = "Comment",
    ["@comment.documentation"]      = "Comment",
    ["@comment.error"]              = badge(c.diag.error, c.bg),
    ["@comment.warning"]            = badge(c.diag.warn, c.bg),
    ["@comment.todo"]               = badge(c.blue, c.bg),
    ["@comment.note"]               = badge(c.diag.hint, c.bg),

    -- markup
    ["@markup"]                     = {},
    ["@markup.strong"]              = { bold = true },
    ["@markup.italic"]              = { italic = true },
    ["@markup.strikethrough"]       = { strikethrough = true },
    ["@markup.underline"]           = { underline = true },
    ["@markup.heading"]             = "Title",
    ["@markup.quote"]               = { fg = c.subtext, italic = true },
    ["@markup.math"]                = { fg = c.cyan },
    ["@markup.link"]                = { fg = c.teal },
    ["@markup.link.label"]          = { fg = c.blue },
    ["@markup.link.url"]            = { fg = c.teal, underline = true },
    ["@markup.raw"]                 = { fg = c.teal },
    ["@markup.raw.block"]           = { fg = c.fg },
    ["@markup.raw.markdown_inline"] = { fg = c.teal, bg = c.surface0 },
    ["@markup.list"]                = { fg = c.orange },
    ["@markup.list.checked"]        = { fg = c.green },
    ["@markup.list.unchecked"]      = { fg = c.overlay0 },
    ["@markup.environment"]         = "Macro",
    ["@markup.environment.name"]    = "Type",

    ["@diff.plus"]                  = "Added",
    ["@diff.minus"]                 = "Removed",
    ["@diff.delta"]                 = "Changed",

    -- tags (HTML/JSX/XML)
    ["@tag"]                        = { fg = s.tag },
    ["@tag.builtin"]                = { fg = s.tag },
    ["@tag.attribute"]              = { fg = s.tag_attribute, italic = true },
    ["@tag.delimiter"]              = { fg = s.tag_delimiter },
    -- JSX/TSX: custom components are capitalised types, HTML tags stay red
    ["@tag.tsx"]                    = { fg = s.type },
    ["@tag.javascript"]             = { fg = s.type },
    ["@tag.builtin.tsx"]            = { fg = s.tag },
    ["@tag.builtin.javascript"]     = { fg = s.tag },

    ["@none"]                       = {},
    ["@conceal"]                    = "Conceal",
    ["@spell"]                      = {},
    ["@nospell"]                    = {},

    -- language polish
    ["@keyword.directive.bash"]     = "Comment", -- shebang
    ["@function.builtin.bash"]      = { fg = s.func_builtin },
    ["@property.css"]               = { fg = s.property },
    ["@type.css"]                   = { fg = s.tag },
    ["@property.yaml"]              = { fg = s.property },
    ["@property.toml"]              = { fg = s.property },
    ["@property.json"]              = { fg = s.property },
    ["@label.json"]                 = { fg = s.property },
    ["@variable.member.go"]         = { fg = s.property },

    -- regex injections: one cyan family, with quantifiers/anchors/classes accented
    ["@punctuation.bracket.regex"]  = { fg = s.regex },
    ["@punctuation.delimiter.regex"] = { fg = s.regex },
    ["@operator.regex"]             = { fg = s.escape },
    ["@constant.regex"]             = { fg = s.string_special },
    ["@string.escape.regex"]        = { fg = s.escape },
    ["@variable.builtin.regex"]     = { fg = s.escape },
    ["@property.regex"]             = { fg = s.regex },
  }

  for i = 1, 6 do
    local color = c.rainbow[i]
    hl["@markup.heading." .. i] = { fg = color, bold = true }
    hl["@markup.heading." .. i .. ".markdown"] = { fg = color, bold = true }
  end
  return hl
end

return M
