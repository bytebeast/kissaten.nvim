---@mod kissaten.groups.semantic_tokens LSP semantic tokens (:h lsp-semantic-highlight)
--- Mostly links to treesitter captures so LSP and treesitter agree. Where the
--- server knows more than the parser (readonly, defaultLibrary, mutable...)
--- we use it to add information instead of just repainting.
local M = {}

---@type kissaten.HighlightsFn
function M.get(c, opts)
  local s = c.syn
  local st = opts.styles

  -- stylua: ignore
  local hl = {
    ["@lsp.type.boolean"]                      = "@boolean",
    ["@lsp.type.builtinType"]                  = "@type.builtin",
    ["@lsp.type.class"]                        = "@type",
    ["@lsp.type.comment"]                      = {}, -- let treesitter keep TODO/NOTE highlighting
    ["@lsp.type.decorator"]                    = "@attribute",
    ["@lsp.type.deriveHelper"]                 = "@attribute",
    ["@lsp.type.enum"]                         = "@type",
    ["@lsp.type.enumMember"]                   = "@constant",
    ["@lsp.type.escapeSequence"]               = "@string.escape",
    ["@lsp.type.event"]                        = "@type",
    ["@lsp.type.formatSpecifier"]              = "@punctuation.special",
    ["@lsp.type.function"]                     = "@function",
    ["@lsp.type.generic"]                      = "@variable",
    ["@lsp.type.interface"]                    = { fg = s.type, italic = true }, -- interfaces read as "types, but abstract"
    ["@lsp.type.keyword"]                      = "@keyword",
    ["@lsp.type.lifetime"]                     = "@keyword.modifier",
    ["@lsp.type.macro"]                        = "@function.macro",
    ["@lsp.type.method"]                       = "@function.method",
    ["@lsp.type.modifier"]                     = "@keyword.modifier",
    ["@lsp.type.namespace"]                    = "@module",
    ["@lsp.type.namespace.python"]             = "@variable",
    ["@lsp.type.number"]                       = "@number",
    ["@lsp.type.operator"]                     = "@operator",
    ["@lsp.type.parameter"]                    = "@variable.parameter",
    ["@lsp.type.property"]                     = "@property",
    ["@lsp.type.regexp"]                       = "@string.regexp",
    ["@lsp.type.selfKeyword"]                  = "@variable.builtin",
    ["@lsp.type.selfTypeKeyword"]              = "@variable.builtin",
    ["@lsp.type.string"]                       = "@string",
    ["@lsp.type.struct"]                       = "@type",
    ["@lsp.type.type"]                         = "@type",
    ["@lsp.type.typeAlias"]                    = "@type.definition",
    ["@lsp.type.typeParameter"]                = { fg = s.type, italic = true },
    ["@lsp.type.unresolvedReference"]          = { undercurl = true, sp = c.diag.error },
    ["@lsp.type.variable"]                     = {}, -- treesitter handles plain variables better

    ["@lsp.mod.deprecated"]                    = { strikethrough = true },
    ["@lsp.typemod.class.defaultLibrary"]      = "@type.builtin",
    ["@lsp.typemod.enum.defaultLibrary"]       = "@type.builtin",
    ["@lsp.typemod.enumMember.defaultLibrary"] = "@constant.builtin",
    ["@lsp.typemod.function.defaultLibrary"]   = "@function.builtin",
    ["@lsp.typemod.function.builtin"]          = "@function.builtin",
    ["@lsp.typemod.keyword.async"]             = "@keyword.coroutine",
    ["@lsp.typemod.keyword.injected"]          = "@keyword",
    ["@lsp.typemod.macro.defaultLibrary"]      = "@function.builtin",
    ["@lsp.typemod.method.defaultLibrary"]     = "@function.builtin",
    ["@lsp.typemod.operator.injected"]         = "@operator",
    ["@lsp.typemod.string.injected"]           = "@string",
    ["@lsp.typemod.struct.defaultLibrary"]     = "@type.builtin",
    ["@lsp.typemod.type.defaultLibrary"]       = "@type.builtin",
    ["@lsp.typemod.typeAlias.defaultLibrary"]  = "@type.builtin",
    ["@lsp.typemod.variable.callable"]         = "@function",
    ["@lsp.typemod.variable.defaultLibrary"]   = "@variable.builtin",
    ["@lsp.typemod.variable.injected"]         = "@variable",
    ["@lsp.typemod.variable.static"]           = "@constant",
  }

  -- Modifiers the language server knows and the parser doesn't (the
  -- JetBrains-style distinctions). Each is an attribute-only style that
  -- stacks on the token's color; an empty style leaves the group undefined.
  --   mutable   rust-analyzer: `mut` bindings (default: underlined)
  --   readonly  const / readonly / final (TypeScript, C++, C#, Java, ...)
  --   statics   static members and variables
  --   globals   global scope (clangd `globalScope`, LuaLS `global`)
  local function mod(groups, style)
    if style and next(style) then
      for _, group in ipairs(groups) do
        hl[group] = { style = style }
      end
    end
  end
  mod({ "@lsp.mod.mutable", "@lsp.typemod.variable.mutable.rust" }, st.mutable)
  if st.mutable and next(st.mutable) then
    -- Rust parameters keep their color: the mut style just stacks on it
    hl["@lsp.typemod.parameter.mutable.rust"] = { fg = s.parameter, style = st.mutable }
  end
  mod({ "@lsp.mod.readonly" }, st.readonly)
  mod({ "@lsp.mod.static" }, st.statics)
  mod({ "@lsp.mod.global", "@lsp.mod.globalScope" }, st.globals)

  -- `rainbow_variables`: one group per color (see kissaten.semantic)
  for i, color in ipairs(c.variables or {}) do
    hl["KissatenVariable" .. i] = { fg = color }
  end
  return hl
end

return M
