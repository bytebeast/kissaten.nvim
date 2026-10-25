-- Headless test suite. Run from the repo root:
--   nvim --headless -u NONE -i NONE -l tests/run.lua
-- Exits non-zero on failure (used by CI).
vim.opt.rtp:prepend(vim.fn.getcwd())
vim.cmd("runtime plugin/kissaten.lua") -- -u NONE skips plugin/, load the :Kissaten command

local Util = require("kissaten.util")
local styles = require("kissaten.config").styles

local failures, passed = {}, 0
local warnings = {}
local orig_notify = vim.notify
vim.notify = function(msg, level)
  warnings[#warnings + 1] = { msg = msg, level = level }
end

local function test(name, fn)
  warnings = {}
  local ok, err = xpcall(fn, debug.traceback)
  if ok then
    passed = passed + 1
    io.write("  ok  ", name, "\n")
  else
    failures[#failures + 1] = name
    io.write("  FAIL ", name, "\n    ", tostring(err):gsub("\n", "\n    "), "\n")
  end
end

local function eq(a, b, msg)
  if not vim.deep_equal(a, b) then
    error((msg or "not equal") .. ": expected " .. vim.inspect(b) .. ", got " .. vim.inspect(a), 2)
  end
end

local function truthy(v, msg)
  if not v then
    error(msg or "expected truthy", 2)
  end
end

local function hex(n)
  return n and ("#%06x"):format(n) or nil
end

local function hl(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end

local function reset()
  package.loaded["kissaten.config"].options = nil
  require("kissaten").last = {}
  vim.g.colors_name = nil
end

local nv = vim.version()
print(("kissaten.nvim tests (Neovim %d.%d.%d)"):format(nv.major, nv.minor, nv.patch))

--- Run :checkhealth and return the report text. Neovim 0.13+ fills the
--- report asynchronously, so wait until our section has been written.
local function checkhealth(name)
  vim.cmd("checkhealth " .. name)
  local buf = vim.api.nvim_get_current_buf()
  local function text()
    return table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n")
  end
  vim.wait(5000, function()
    local t = text()
    return t:find("Every syntax role") ~= nil or t:find("below WCAG") ~= nil or t:find("ERROR") ~= nil
  end, 20)
  return text()
end

for _, style in ipairs(styles) do
  test("loads kissaten-" .. style .. " without warnings", function()
    reset()
    require("kissaten").setup({ plugins = { all = true } })
    vim.cmd.colorscheme("kissaten-" .. style)
    eq(vim.g.colors_name, "kissaten-" .. style)
    eq(#warnings, 0, "warnings: " .. vim.inspect(warnings))
    eq(vim.o.background, style == "morning" and "light" or "dark")
  end)

  test(style .. ": every link resolves and every color is valid", function()
    local _, groups = require("kissaten").load({ plugins = { all = true } }, style)
    local n = 0
    for name, def in pairs(groups) do
      n = n + 1
      if def.link then
        truthy(groups[def.link] or vim.fn.hlexists(def.link) == 1, name .. " links to missing group " .. def.link)
      end
      for _, k in ipairs({ "fg", "bg", "sp" }) do
        local v = def[k]
        if v ~= nil then
          truthy(v == "NONE" or Util.is_hex(v), ("%s.%s = %s"):format(name, k, tostring(v)))
        end
      end
    end
    truthy(n > 900, "expected > 900 groups, got " .. n)
  end)

  test(style .. ": syntax roles meet WCAG AA against the background", function()
    local c = require("kissaten").colors(style)
    local skip = { comment = true, deprecated = true, tag_delimiter = true, punct = false }
    for role, color in pairs(c.syn) do
      if not skip[role] then
        local r = Util.contrast(color, c.bg)
        truthy(r >= 4.5, ("%s: syn.%s %s is %.2f:1"):format(style, role, color, r))
      end
    end
    truthy(Util.contrast(c.comment, c.bg) >= 4.0, "comments must be >= 4:1")
    truthy(Util.contrast(c.fg, c.ui.bg_visual) >= 4.5, "text in visual selection must be >= 4.5:1")
    truthy(Util.contrast(c.fg, c.ui.bg_cursorline) >= 7, "text on cursorline must be >= 7:1")
  end)
end

test("treesitter groups resolve to theme colors", function()
  reset()
  vim.cmd.colorscheme("kissaten-evening")
  local c = require("kissaten").colors("evening")
  eq(hex(hl("@keyword").fg), c.syn.keyword)
  eq(hex(hl("@function.call").fg), c.syn.func)
  eq(hex(hl("@variable.parameter").fg), c.syn.parameter)
  eq(hex(hl("@type").fg), c.syn.type)
  eq(hex(hl("@string").fg), c.syn.string)
  eq(hl("Comment").italic, true)
end)

test("on_palette / on_colors / on_highlights all apply", function()
  reset()
  require("kissaten").setup({
    on_palette = function(p)
      p.green = "#00ff00"
    end,
    on_colors = function(c)
      c.syn.keyword = "#ff0000"
    end,
    on_highlights = function(h, c)
      h.Function = { fg = c.yellow, bold = true }
      h.MyCustomGroup = { link = "Function" }
    end,
  })
  vim.cmd.colorscheme("kissaten-evening")
  eq(hex(hl("String").fg), "#00ff00", "palette change reaches String")
  eq(hex(hl("@keyword").fg), "#ff0000", "role change reaches treesitter")
  eq(hex(hl("Conditional").fg), "#c3a6ff", "keyword_flow is a separate role")
  eq(hl("Function").bold, true)
  eq(vim.fn.hlexists("MyCustomGroup"), 1)
end)

test("transparent + styles + kill switches", function()
  reset()
  require("kissaten").setup({
    transparent = true,
    no_italic = true,
    styles = { functions = { bold = true }, sidebars = "transparent", floats = "transparent" },
  })
  vim.cmd.colorscheme("kissaten-midnight")
  eq(hl("Normal").bg, nil, "Normal bg transparent")
  eq(hl("NormalFloat").bg, nil, "floats transparent")
  eq(hl("Comment").italic, nil, "no_italic removes italics")
  eq(hl("Function").bold, true, "styles.functions applied")
end)

test("contrast = 'high' lifts chrome colors only", function()
  reset()
  local normal = require("kissaten").colors("afternoon")
  require("kissaten").setup({ contrast = "high" })
  local high = require("kissaten").colors("afternoon")
  truthy(Util.contrast(high.comment, high.bg) >= 6.0, "high contrast comments >= 6:1")
  truthy(Util.contrast(high.overlay0, high.bg) > Util.contrast(normal.overlay0, normal.bg), "line numbers lifted")
  eq(high.blue, normal.blue, "accents untouched")
end)

test("invalid options warn and fall back instead of erroring", function()
  reset()
  require("kissaten").setup({ style = "dawn", contrast = "max", styles = { floats = "glass" }, transparent = "yes" })
  vim.cmd.colorscheme("kissaten")
  eq(vim.g.colors_name, "kissaten-evening")
  truthy(#warnings >= 1, "should warn")
  local opts = require("kissaten.config").options
  eq(opts.contrast, "normal")
  eq(opts.styles.floats, "dark")
  eq(opts.transparent, false)
end)

test("'background' switching swaps variants and remembers them", function()
  reset()
  require("kissaten").setup({})
  vim.cmd.colorscheme("kissaten-midnight")
  vim.o.background = "light"
  eq(vim.g.colors_name, "kissaten-morning")
  vim.o.background = "dark"
  eq(vim.g.colors_name, "kissaten-midnight", "returns to the last dark variant")
  vim.cmd.colorscheme("kissaten")
  eq(vim.g.colors_name, "kissaten-midnight")
end)

test("plugin selection: explicit on/off by module or repo name", function()
  reset()
  local Groups = require("kissaten.groups")
  local opts =
    require("kissaten.config").extend({ plugins = { all = false, auto = false, telescope = true, ["fzf-lua"] = true } })
  eq(Groups.enabled(opts), { "fzf", "telescope" })
  opts = require("kissaten.config").extend({ plugins = { all = true, snacks = false } })
  truthy(not vim.tbl_contains(Groups.enabled(opts), "snacks"))
  truthy(vim.tbl_contains(Groups.enabled(opts), "blink"))
end)

test("plugin auto-detection via lazy.nvim", function()
  reset()
  package.loaded["lazy.core.config"] = { plugins = { ["blink.cmp"] = {}, ["mini.icons"] = {}, ["snacks.nvim"] = {} } }
  package.loaded["lazy"] = {}
  local opts = require("kissaten.config").extend()
  local enabled = require("kissaten.groups").enabled(opts)
  package.loaded["lazy.core.config"], package.loaded["lazy"] = nil, nil
  eq(enabled, { "blink", "mini", "snacks" })
end)

test("dim_inactive darkens non-current windows", function()
  reset()
  require("kissaten").setup({ dim_inactive = true })
  vim.cmd.colorscheme("kissaten-evening")
  eq(hex(hl("NormalNC").bg), require("kissaten").colors("evening").mantle)
end)

test("vim.pack is only queried when the user loaded it", function()
  -- run in a fresh Neovim: reading `vim.pack` anywhere imports the module
  local code = [[
    vim.opt.rtp:prepend(vim.fn.getcwd())
    require("kissaten.groups").installed()
    io.write(package.loaded["vim.pack"] and "loaded" or "untouched")
  ]]
  local out =
    vim.fn.system({ vim.v.progpath, "--headless", "-u", "NONE", "-i", "NONE", "-c", "lua " .. code, "-c", "qa!" })
  eq(out, "untouched")
end)

-- ── subtle_comments ──────────────────────────────────────────────────────
local function comment_contrast(style)
  local c = require("kissaten").colors(style)
  return Util.contrast(c.syn.comment, c.bg), c
end

for _, style in ipairs(styles) do
  test(style .. ": subtle_comments fades by contrast, consistently and monotonically", function()
    reset()
    local base, c0 = comment_contrast(style)
    local prev = base
    for _, fade in ipairs({ 0.25, 0.5, 0.7, 1 }) do
      require("kissaten").setup({ subtle_comments = fade })
      local r = comment_contrast(style)
      local expected = base - fade * (base - 1.6)
      truthy(math.abs(r - expected) < 0.05, ("fade %.2f: %.2f, expected %.2f"):format(fade, r, expected))
      truthy(r < prev, "more fade must mean less contrast")
      prev = r
    end
    truthy(prev >= 1.59, "never fades below the 1.6:1 floor")
    require("kissaten").setup({ subtle_comments = 0 })
    eq(require("kissaten").colors(style).syn.comment, c0.syn.comment, "fade 0 is a no-op")
  end)
end

test("subtle_comments accepts true, numbers and tables", function()
  reset()
  require("kissaten").setup({ subtle_comments = 0.5 })
  local num = require("kissaten").colors("evening")
  require("kissaten").setup({ subtle_comments = true })
  local yes = require("kissaten").colors("evening")
  require("kissaten").setup({ subtle_comments = { fade = 0.5 } })
  local tbl = require("kissaten").colors("evening")
  require("kissaten").setup({ subtle_comments = {} })
  local empty = require("kissaten").colors("evening")
  eq(yes.syn.comment, num.syn.comment, "true == 0.5")
  eq(tbl.syn.comment, num.syn.comment, "{ fade = 0.5 } == 0.5")
  eq(empty.syn.comment, num.syn.comment, "{} defaults to 0.5")
  eq(#warnings, 0)
end)

test("subtle_comments: docstrings follow unless disabled; UI and TODO badges untouched", function()
  reset()
  local plain = require("kissaten").colors("midnight")
  require("kissaten").setup({ subtle_comments = { fade = 0.7 } })
  local faded = require("kissaten").colors("midnight")
  truthy(
    Util.contrast(faded.syn.string_doc, faded.bg) < Util.contrast(plain.syn.string_doc, plain.bg),
    "docstrings fade"
  )
  eq(faded.comment, plain.comment, "UI comment color (inlay hints, ghost text) unchanged")
  require("kissaten").setup({ subtle_comments = { fade = 0.7, docstrings = false } })
  eq(require("kissaten").colors("midnight").syn.string_doc, plain.syn.string_doc, "docstrings = false keeps them")

  vim.cmd.colorscheme("kissaten-midnight")
  local c = require("kissaten").colors("midnight")
  eq(hex(hl("Comment").fg), c.syn.comment)
  eq(hex(hl("@comment").fg), c.syn.comment)
  eq(hex(hl("@comment.todo").fg), c.blue, "TODO badges stay vivid")
  eq(hex(hl("LspInlayHint").fg), plain.comment)
end)

test("subtle_comments: on_colors still wins, works with contrast = 'high'", function()
  reset()
  require("kissaten").setup({
    subtle_comments = 0.7,
    on_colors = function(c)
      c.syn.comment = "#abcdef"
    end,
  })
  vim.cmd.colorscheme("kissaten-evening")
  eq(hex(hl("Comment").fg), "#abcdef")
  require("kissaten").setup({ subtle_comments = 0.5, contrast = "high" })
  local r = comment_contrast("evening")
  truthy(r > 3.0 and r < 6.0, ("high contrast + fade 0.5 lands between: %.2f"):format(r))
end)

test("subtle_comments: :checkhealth reports it and doesn't flag faded docstrings", function()
  reset()
  require("kissaten").setup({ subtle_comments = { fade = 0.9 } })
  vim.cmd.colorscheme("kissaten-evening")
  local text = checkhealth("kissaten")
  truthy(text:find("subtle_comments: fade 0.90"), "reports the fade")
  truthy(not text:find("string_doc"), "faded docstrings are intentional, not a warning")
  truthy(not text:find("below WCAG") and not text:find("ERROR"), text)
  truthy(text:find("Neovim %d+%.%d+%.%d+"), "version is printed as numbers")
  vim.cmd("bwipeout!")
end)

test("subtle_comments: invalid values warn and fall back to off", function()
  for _, bad in ipairs({ 1.5, -0.1, "yes", 0 / 0, { fade = 2 }, { fade = "a" }, { docstrings = "no" } }) do
    reset()
    warnings = {}
    require("kissaten").setup({ subtle_comments = bad })
    truthy(#warnings == 1, "should warn for " .. vim.inspect(bad))
    eq(require("kissaten.config").options.subtle_comments, false)
    vim.cmd.colorscheme("kissaten-evening")
    eq(vim.g.colors_name, "kissaten-evening")
  end
end)

test("terminal colors are set", function()
  reset()
  vim.cmd.colorscheme("kissaten-evening")
  for i = 0, 15 do
    truthy(Util.is_hex(vim.g["terminal_color_" .. i]), "terminal_color_" .. i)
  end
end)

test("lualine themes build for every style", function()
  for _, style in ipairs(styles) do
    local t = dofile("lua/lualine/themes/kissaten-" .. style .. ".lua")
    for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "inactive" }) do
      truthy(Util.is_hex(t[mode].a.fg), style .. " " .. mode)
    end
  end
end)

test("extras generate for every style and variant", function()
  local Extras = require("kissaten.extras")
  for name in pairs(Extras.extras) do
    for _, style in ipairs(styles) do
      for _, file in ipairs(Extras.files(name)) do
        local label = ("%s/%s/%s"):format(name, style, file[2])
        local out = Extras.render(name, style, file[2])
        truthy(type(out) == "string" and #out > 50, label)
        truthy(not out:find("%${"), label .. " has unreplaced template variables")
      end
    end
  end
end)

-- Minimal YAML reader for the flat, two-space-indented files the eza/k9s
-- generators emit: returns { ["a.b.c"] = "value" } for every leaf.
local function yaml_leaves(text)
  local out, stack = {}, {}
  for line in text:gmatch("[^\n]+") do
    if not line:match("^%s*#") and line:match("%S") then
      local indent, key, rest = line:match("^(%s*)([%w_]+):%s*(.-)%s*$")
      if key then
        local depth = #indent / 2
        for i = #stack, depth + 1, -1 do
          stack[i] = nil
        end
        stack[depth + 1] = key
        local path = table.concat(stack, ".", 1, depth + 1)
        if rest ~= "" then
          out[path] = rest
        end
      end
    end
  end
  return out
end

test("eza: every key exists in eza's UiStylesOverride and every style is explicit", function()
  -- from eza src/options/config.rs; eza silently ignores unknown keys
  local S = {}
  local function add(prefix, keys)
    for k in keys:gmatch("%S+") do
      S[prefix .. k] = true
    end
  end
  add("filekinds.", "normal directory symlink pipe block_device char_device socket special executable mount_point")
  add(
    "perms.",
    "user_read user_write user_execute_file user_execute_other group_read group_write group_execute other_read other_write other_execute special_user_file special_other attribute"
  )
  add(
    "size.",
    "major minor number_byte number_kilo number_mega number_giga number_huge unit_byte unit_kilo unit_mega unit_giga unit_huge"
  )
  add("users.", "user_you user_root user_other group_yours group_other group_root")
  add("links.", "normal multi_link_file")
  add("git.", "new modified deleted renamed typechange ignored conflicted")
  add("git_repo.", "branch_main branch_other git_clean git_dirty")
  add("security_context.", "none")
  add("security_context.selinux.", "colon user role typ range")
  add("file_type.", "image video music lossless crypto document compressed temp compiled build source")
  add(
    "",
    "punctuation date inode blocks header octal flags symlink_path control_char broken_symlink broken_path_overlay"
  )
  local allowed_attr =
    { foreground = true, background = true, is_bold = true, is_dimmed = true, is_italic = true, is_underline = true }
  for _, style in ipairs(styles) do
    local leaves = yaml_leaves(require("kissaten.extras").render("eza", style))
    local seen = 0
    for path, value in pairs(leaves) do
      if path ~= "colourful" then
        truthy(S[path], style .. ": unknown eza key " .. path)
        seen = seen + 1
        for attr, v in value:gmatch("([%w_]+):%s*([^,}]+)") do
          truthy(allowed_attr[attr], ("%s: %s has unknown attribute %s"):format(style, path, attr))
          if attr == "foreground" then
            truthy(v:match('^"#%x%x%x%x%x%x"$'), ("%s: %s color %s"):format(style, path, v))
          end
        end
        for _, attr in ipairs({ "is_bold", "is_dimmed", "is_italic", "is_underline" }) do
          truthy(
            value:find(attr, 1, true),
            ("%s: %s must set %s (eza keeps its default otherwise)"):format(style, path, attr)
          )
        end
      end
    end
    eq(seen, vim.tbl_count(S), style .. ": every eza style key is set")
  end
end)

test("k9s: every key exists in k9s's Style structs, colors are valid", function()
  -- from k9s internal/config/styles.go (yaml tags); k9s ignores unknown keys
  local K = {}
  local function add(prefix, keys)
    for k in keys:gmatch("%S+") do
      K["k9s." .. prefix .. k] = true
    end
  end
  add("body.", "fgColor bgColor logoColor logoColorMsg logoColorInfo logoColorWarn logoColorError")
  add("prompt.", "fgColor bgColor suggestColor")
  add("prompt.border.", "command default")
  add("help.", "fgColor bgColor sectionColor keyColor numKeyColor")
  add("frame.title.", "fgColor bgColor highlightColor counterColor filterColor")
  add("frame.border.", "fgColor focusColor")
  add("frame.menu.", "fgColor fgStyle keyColor numKeyColor")
  add("frame.crumbs.", "fgColor bgColor activeColor")
  add("frame.status.", "newColor modifyColor addColor pendingColor errorColor highlightColor killColor completedColor")
  add("info.", "sectionColor fgColor cpuColor memColor k9sRevColor")
  add("views.table.", "fgColor bgColor cursorFgColor cursorBgColor markColor")
  add("views.table.header.", "fgColor bgColor sorterColor selectedSortColumnColor")
  add("views.xray.", "fgColor bgColor cursorColor cursorTextColor graphicColor")
  add(
    "views.charts.",
    "bgColor dialBgColor chartBgColor defaultDialColors defaultChartColors resourceColors focusFgColor focusBgColor"
  )
  add("views.yaml.", "keyColor valueColor colonColor")
  add("views.picker.", "mainColor focusColor shortcutColor")
  add("views.logs.", "fgColor bgColor")
  add("views.logs.indicator.", "fgColor bgColor toggleOnColor toggleOffColor")
  add(
    "dialog.",
    "fgColor bgColor buttonFgColor buttonBgColor buttonFocusFgColor buttonFocusBgColor labelFgColor fieldFgColor"
  )
  local Extras = require("kissaten.extras")
  for _, style in ipairs(styles) do
    for _, file in ipairs(Extras.files("k9s")) do
      local leaves = yaml_leaves(Extras.render("k9s", style, file[2]))
      for path, value in pairs(leaves) do
        if not path:find("resourceColors", 1, true) then
          truthy(K[path], ("%s/%s: unknown k9s key %s"):format(style, file[2], path))
          local ok = value:match('^"#%x%x%x%x%x%x"$') or value == '"default"'
          truthy(ok, ("%s/%s: %s = %s"):format(style, file[2], path, value))
          if file[2] == "default" then
            truthy(value ~= '"default"', ("%s: %s must be a color in the opaque skin"):format(style, path))
          end
        end
      end
      if file[2] == "transparent" then
        eq(leaves["k9s.body.bgColor"], '"default"', style .. ": transparent skin uses the terminal background")
      end
    end
  end
end)

test("k9s: the selected row stays readable on every row color", function()
  -- k9s paints the selected row with the row's status color as background
  -- and cursorFgColor as text (internal/ui/select_table.go)
  for _, style in ipairs(styles) do
    local c = require("kissaten").colors(style)
    local skin = yaml_leaves(require("kissaten.extras").render("k9s", style))
    local cursor = skin["k9s.views.table.cursorFgColor"]:match("#%x+")
    for _, k in ipairs({ "fg", "blue", "lavender", "green", "orange", "red", "cyan", "purple" }) do
      local r = Util.contrast(cursor, c[k])
      truthy(r >= 4.5, ("%s: selected %s row %.2f:1"):format(style, k, r))
    end
  end
end)

test("bat: valid tmTheme, XML-safe comments, every rule resolves", function()
  for _, style in ipairs(styles) do
    local out = require("kissaten.extras").render("bat", style)
    truthy(out:find('^<%?xml version="1.0"'), style .. ": xml header")
    for comment in out:gmatch("<!%-%-(.-)%-%->") do
      truthy(not comment:find("--", 1, true), style .. ": XML comments may not contain a double dash")
    end
    local opens = select(2, out:gsub("<dict>", ""))
    local closes = select(2, out:gsub("</dict>", ""))
    eq(opens, closes, style .. ": balanced <dict>")
    for color in out:gmatch("<key>foreground</key>%s*<string>([^<]*)</string>") do
      truthy(Util.is_hex(color), style .. ": foreground " .. color)
    end
    truthy(out:find("<string>kissaten.nvim</string>", 1, true), style .. ": author")
  end
end)

test("bat: italics follow `styles` (comments and keywords by default)", function()
  reset()
  local out = require("kissaten.extras").render("bat", "evening")
  local comment_rule = out:match("<string>Comment</string>.-</dict>")
  truthy(comment_rule:find("italic"), "comments italic by default")
  require("kissaten").setup({ styles = { comments = { italic = false }, keywords = { bold = true } } })
  out = require("kissaten.extras").render("bat", "evening")
  truthy(not out:match("<string>Comment</string>.-</dict>"):find("italic"), "comment italics can be turned off")
  truthy(out:match("<string>Keyword</string>.-</dict>"):find("bold"), "keyword bold follows styles")
  reset()
end)

test("zettlr: CSS is balanced and every rule is scoped to one Zettlr mode", function()
  for _, style in ipairs(styles) do
    local css = require("kissaten.extras").render("zettlr", style):gsub("/%*.-%*/", "")
    eq(select(2, css:gsub("{", "")), select(2, css:gsub("}", "")), style .. ": balanced braces")
    local mode = style == "morning" and "html body:not(.dark)" or "html body.dark"
    for selectors in css:gmatch("([^{}]+){") do
      for sel in selectors:gmatch("[^,]+") do
        sel = vim.trim(sel)
        truthy(sel:sub(1, #mode) == mode, ("%s: unscoped selector %q"):format(style, sel))
        if style ~= "morning" then
          truthy(not sel:find("body:not(.dark)", 1, true), style .. ": dark file leaks into light mode")
        end
      end
    end
  end
end)

-- ── Options added in 1.0: colorblind, saturation, accent, rainbow, ───────
-- ── borderless, diagnostics, inlay hints, conditionals/loops ─────────────

local function colors(style, opts)
  reset()
  warnings = {}
  require("kissaten").setup(opts or {})
  return require("kissaten").colors(style)
end

local function load(style, opts)
  reset()
  warnings = {}
  require("kissaten").setup(opts or {})
  vim.cmd.colorscheme("kissaten-" .. style)
end

--- Color vision deficiency simulation (Machado, Oliveira & Fernandes 2009,
--- severity 1.0) and OKLab distance x100, to check colors stay apart.
local CVD = {
  protan = { { 0.152286, 1.052583, -0.204868 }, { 0.114503, 0.786281, 0.099216 }, { -0.003882, -0.048116, 1.051998 } },
  deutan = { { 0.367322, 0.860646, -0.227968 }, { 0.280085, 0.672501, 0.047413 }, { -0.011820, 0.042940, 0.968881 } },
  tritan = { { 1.255528, -0.076749, -0.178779 }, { -0.078411, 0.930809, 0.147602 }, { 0.004733, 0.691367, 0.303900 } },
}
local function simulate(color, kind)
  if kind == "normal" then
    return color
  end
  local function lin(v)
    v = v / 255
    return v <= 0.04045 and v / 12.92 or ((v + 0.055) / 1.055) ^ 2.4
  end
  local function enc(v)
    v = math.min(1, math.max(0, v))
    return 255 * (v <= 0.0031308 and 12.92 * v or 1.055 * v ^ (1 / 2.4) - 0.055)
  end
  local r, g, b = Util.rgb(color)
  local x = { lin(r), lin(g), lin(b) }
  local m = CVD[kind]
  local o = {}
  for i = 1, 3 do
    o[i] = enc(m[i][1] * x[1] + m[i][2] * x[2] + m[i][3] * x[3])
  end
  return Util.hex(o[1], o[2], o[3])
end
local function distance(a, b)
  local l1, a1, b1 = Util.to_oklab(a)
  local l2, a2, b2 = Util.to_oklab(b)
  return 100 * math.sqrt((l1 - l2) ^ 2 + (a1 - a2) ^ 2 + (b1 - b2) ^ 2)
end
--- Smallest simulated distance between any two of `list` under `kinds`.
local function separation(list, kinds)
  local worst, where = math.huge, ""
  for _, kind in ipairs(kinds) do
    for i = 1, #list do
      for j = i + 1, #list do
        local d = distance(simulate(list[i][2], kind), simulate(list[j][2], kind))
        if d < worst then
          worst, where = d, ("%s: %s/%s"):format(kind, list[i][1], list[j][1])
        end
      end
    end
  end
  return worst, where
end
local function pick(t, keys, prefix)
  local out = {}
  for _, k in ipairs(keys) do
    out[#out + 1] = { (prefix or "") .. k, t[k] }
  end
  return out
end

test("helpers: OKLab round-trips and the CVD model sees red/green collapse", function()
  for _, h in ipairs({ "#000000", "#ffffff", "#82aaff", "#c8153c", "#1f2133", "#f7a46f" }) do
    eq(Util.from_oklab(Util.to_oklab(h)), h, "round trip " .. h)
  end
  -- sanity check of the simulation itself: pure red vs green is obvious to
  -- normal vision and nearly gone for deuteranopia
  truthy(distance("#d03030", "#30a030") > 15, "normal vision tells them apart")
  truthy(distance(simulate("#d03030", "deutan"), simulate("#30a030", "deutan")) < 10, "deutan sees them close")
end)

test("colorblind: default colors collapse under red-green CVD (why the option exists)", function()
  local c = colors("evening")
  local worst = separation(pick(c.git, { "add", "change", "delete" }), { "deutan" })
  truthy(worst < 3, ("default git signs should collide for deutan, got %.1f"):format(worst))
end)

test("colorblind: diff, git and diagnostic colors stay apart in every style", function()
  -- thresholds: what the chosen mappings reach at their weakest (see
  -- colors.lua), with a little headroom. 3 is about the smallest
  -- difference you can see side by side.
  local modes = {
    ["red-green"] = { kinds = { "normal", "protan", "deutan" }, signs = 10, diag = 6, diff = 4.5 },
    ["blue-yellow"] = { kinds = { "normal", "tritan" }, signs = 10, diag = 8, diff = 4.5 },
  }
  for mode, want in pairs(modes) do
    for _, style in ipairs(styles) do
      local c = colors(style, { colorblind = mode })
      local where = ("%s/%s"):format(mode, style)
      local s, w = separation(pick(c.git, { "add", "change", "delete" }), want.kinds)
      truthy(s >= want.signs, ("%s git signs %.1f (%s)"):format(where, s, w))
      local d
      d, w = separation(pick(c.diag, { "error", "warn", "ok" }), want.kinds)
      truthy(d >= want.diag, ("%s error/warn/ok %.1f (%s)"):format(where, d, w))
      -- info and hint must not look like error or warn
      for _, soft in ipairs({ "info", "hint" }) do
        for _, hard in ipairs({ "error", "warn" }) do
          d, w = separation({ { soft, c.diag[soft] }, { hard, c.diag[hard] } }, want.kinds)
          truthy(d >= want.diag, ("%s %s vs %s %.1f (%s)"):format(where, soft, hard, d, w))
        end
      end
      local f
      f, w = separation(pick(c.diff, { "add", "delete" }), want.kinds)
      truthy(f >= want.diff, ("%s diff add/delete %.1f (%s)"):format(where, f, w))
      -- every remapped color is still a readable palette accent
      for _, role in ipairs({ "error", "warn", "info", "hint", "ok" }) do
        truthy(Util.contrast(c.diag[role], c.bg) >= 4.5, where .. " diag." .. role .. " contrast")
      end
    end
  end
end)

test("colorblind: highlight groups and plugins follow the remapped roles", function()
  load("evening", { colorblind = "red-green" })
  local c = require("kissaten").colors()
  eq(hex(hl("GitSignsAdd").fg), c.git.add, "gitsigns add")
  eq(c.git.add, c.blue, "red-green: added is blue (as in GitHub's colorblind themes)")
  eq(c.git.delete, c.orange, "red-green: deleted is orange")
  eq(hex(hl("DiffAdd").bg), c.diff.add, "DiffAdd")
  eq(hex(hl("DiagnosticError").fg), c.diag.error, "diagnostic error")
  eq(hex(hl("GrugFarResultsMatchAdded").bg), c.git.add, "grug-far uses the git role")
  eq(hex(hl("GrugFarResultsMatchRemoved").bg), c.git.delete, "grug-far removed")
  eq(hex(hl("MasonError").fg), c.diag.error, "mason uses the diagnostic role")
  eq(hex(hl("OctoStateOpen").fg), c.diag.ok, "octo open pill")
  eq(hex(hl("NeotestPassed").fg), c.diag.ok, "neotest passed")
  -- syntax keeps its colors: strings are still green
  eq(c.syn.string, c.green, "syntax untouched")
  -- on_colors still has the last word
  load("evening", {
    colorblind = "red-green",
    on_colors = function(cc)
      cc.git.add = cc.teal
    end,
  })
  eq(hex(hl("GitSignsAdd").fg), require("kissaten").colors().teal, "on_colors wins over colorblind")
  load("morning", { colorblind = "blue-yellow" })
  c = require("kissaten").colors()
  eq(c.diag.ok, c.blue, "blue-yellow: ok is blue")
  eq(c.git.change, c.yellow, "blue-yellow: changed is yellow")
end)

test("saturation: greys at 0, contrast and AA kept at every level", function()
  local base = colors("evening")
  local grey = colors("evening", { saturation = 0 })
  for _, k in ipairs({ "red", "green", "blue", "yellow", "purple", "bg" }) do
    local _, a, b = Util.to_oklab(grey[k])
    truthy(math.sqrt(a * a + b * b) < 0.01, k .. " is grey at saturation 0")
  end
  for _, style in ipairs(styles) do
    local plain = colors(style)
    for _, amount in ipairs({ 0, 0.4, 0.8 }) do
      local c = colors(style, { saturation = amount })
      for key, color in pairs(require("kissaten.colors").palette(style)) do
        if key ~= "bg" and Util.is_hex(color) then
          local want = Util.contrast(plain[key], plain.bg)
          local got = Util.contrast(c[key], c.bg)
          -- exact up to hex rounding
          truthy(
            math.abs(got - want) / want < 0.02,
            ("%s %s @%s: contrast %.2f vs %.2f"):format(style, key, amount, got, want)
          )
        end
      end
      for role, color in pairs(c.syn) do
        if role ~= "comment" and role ~= "deprecated" and role ~= "tag_delimiter" and role ~= "string_doc" then
          truthy(Util.contrast(color, c.bg) >= 4.4, ("%s syn.%s @%s below AA"):format(style, role, amount))
        end
      end
    end
  end
  eq(colors("evening", { saturation = 1 }).blue, base.blue, "1 = unchanged")
  colors("evening", { saturation = 1.5 })
  truthy(#warnings == 1 and warnings[1].msg:find("saturation"), "out-of-range saturation warns")
  eq(require("kissaten.config").options.saturation, 1, "and falls back to 1")
end)

test("accent: every accent works on every style, badges stay readable", function()
  for _, style in ipairs(styles) do
    for _, accent in ipairs(require("kissaten.config").accents) do
      local c = colors(style, { accent = accent })
      eq(c.ui.accent, c[accent], style .. " accent " .. accent)
      eq(c.ui.title, c[accent], "titles follow")
      truthy(
        Util.contrast(c.ui.on_badge, c.ui.accent) >= 4.5,
        ("%s/%s: badge text %.2f"):format(style, accent, Util.contrast(c.ui.on_badge, c.ui.accent))
      )
    end
  end
  load("evening", { accent = "pink" })
  local c = require("kissaten").colors()
  eq(hex(hl("TelescopeTitle").bg), c.pink, "picker title badge")
  eq(hex(hl("SnacksPickerMatch").fg), c.pink, "picker matches")
  eq(hex(hl("TabLineSel").bg), c.pink, "selected tab")
  eq(hex(hl("FloatTitle").fg), c.pink, "float titles")
  eq(require("lualine.themes.kissaten").normal.a.bg, c.pink, "lualine normal mode")
  eq(hex(hl("Function").fg), c.blue, "functions stay blue")
  eq(hex(hl("Directory").fg), c.blue, "directories stay blue")
  colors("evening", { accent = "chartreuse" })
  truthy(#warnings == 1 and warnings[1].msg:find("accent"), "unknown accent warns")
end)

test("badges: text on every colored badge meets 4.5:1 in every style", function()
  for _, style in ipairs(styles) do
    load(style)
    local c = require("kissaten").colors()
    local on, accents = c.ui.on_badge, {}
    for _, a in ipairs(require("kissaten.config").accents) do
      accents[c[a]] = true
    end
    local n = 0
    for name, h in pairs(vim.api.nvim_get_hl(0, {})) do
      if h.fg and h.bg and hex(h.fg) == on and accents[hex(h.bg)] then
        n = n + 1
        local ratio = Util.contrast(hex(h.fg), hex(h.bg))
        truthy(ratio >= 4.5, ("%s %s: %.2f"):format(style, name, ratio))
      end
    end
    truthy(n > 30, style .. ": found the badges")
  end
end)

test("rainbow: vivid, dimmed and mono brackets", function()
  for _, style in ipairs(styles) do
    local vivid = colors(style)
    eq(vivid.brackets.red, vivid.red, "vivid uses the palette")
    eq(vivid.scopes, vivid.rainbow, "vivid scopes")
    local dimmed = colors(style, { rainbow = "dimmed" })
    for name, color in pairs(dimmed.brackets) do
      local before, after = Util.contrast(vivid.brackets[name], vivid.bg), Util.contrast(color, dimmed.bg)
      truthy(after < before or before <= 3, style .. " dimmed " .. name .. " is softer")
      truthy(after >= 2.95, ("%s dimmed %s readable (%.2f)"):format(style, name, after))
    end
    local mono = colors(style, { rainbow = "mono" })
    local order = require("kissaten.colors").BRACKET_ORDER
    local last = math.huge
    for _, name in ipairs(order) do
      local ratio = Util.contrast(mono.brackets[name], mono.bg)
      truthy(ratio <= last + 1e-6, style .. " mono gets dimmer with depth")
      truthy(ratio >= 4, ("%s mono %s readable (%.2f)"):format(style, name, ratio))
      last = ratio
    end
    eq(mono.rainbow, vivid.rainbow, "headings keep their colors")
  end
  load("evening", { rainbow = "mono" })
  local c = require("kissaten").colors()
  eq(hex(hl("RainbowDelimiterRed").fg), c.brackets.red, "rainbow-delimiters follows")
  eq(hex(hl("SnacksIndent1").fg), Util.blend(c.scopes[1], c.bg, 0.4), "snacks rainbow indent follows")
end)

test("popups stand out from the editor on every style, even without borders", function()
  for _, style in ipairs(styles) do
    local c = colors(style)
    local ui = c.ui
    truthy(
      Util.contrast(ui.bg_popup, c.bg) >= 1.08,
      ("%s: completion menu vs editor %.3f"):format(style, Util.contrast(ui.bg_popup, c.bg))
    )
    truthy(
      Util.contrast(ui.bg_float, c.bg) >= 1.08,
      ("%s: floats vs editor %.3f"):format(style, Util.contrast(ui.bg_float, c.bg))
    )
    local sel = Util.contrast(ui.bg_sel, ui.bg_popup)
    truthy(sel >= (c.light and 1.1 or 1.3), ("%s: menu selection vs menu %.3f"):format(style, sel))
    truthy(Util.contrast(ui.bg_sel, ui.bg_sidebar) >= 1.1, style .. ": sidebar selection")
    truthy(Util.contrast(c.fg, ui.bg_sel) >= 4.5, style .. ": text on the selection")
    eq(ui.bg_sidebar, c.mantle, style .. ": sidebars stay on mantle")
  end
end)

test("bright_borders colors every popup border it can reach", function()
  for _, style in ipairs(styles) do
    load(style, { bright_borders = true, accent = "pink" })
    local accent = require("kissaten").colors().pink
    for _, g in ipairs({ "FloatBorder", "PmenuBorder", "BlinkCmpMenuBorder", "BlinkCmpDocBorder", "TelescopeBorder" }) do
      eq(hex(hl(g).fg), accent, style .. ": " .. g)
    end
    load(style)
    truthy(hex(hl("FloatBorder").fg) ~= require("kissaten").colors().blue, style .. ": subtle by default")
  end
end)

test("extras: badge text (tmux, kitty, wezterm, k9s) meets 4.5:1 on every style", function()
  local E = require("kissaten.extras")
  for _, style in ipairs(styles) do
    local tmux = E.render("tmux", style)
    local n = 0
    for fg, bg in tmux:gmatch("#%[fg=(#%x+),bg=(#%x+),bold%]") do
      n = n + 1
      truthy(Util.contrast(fg, bg) >= 4.5, ("%s tmux badge %s on %s"):format(style, fg, bg))
    end
    truthy(n >= 2, style .. ": found tmux badges")
    local kitty = E.render("kitty", style)
    local fg, bg = kitty:match("active_tab_foreground (#%x+)"), kitty:match("active_tab_background (#%x+)")
    truthy(Util.contrast(fg, bg) >= 4.5, style .. " kitty active tab")
    local wez = E.render("wezterm", style)
    bg, fg = wez:match('%[colors%.tab_bar%.active_tab%]\nbg_color = "(#%x+)"\nfg_color = "(#%x+)"')
    truthy(Util.contrast(fg, bg) >= 4.5, style .. " wezterm active tab")
    local k9s = E.render("k9s", style)
    fg, bg = k9s:match('crumbs:\n%s+fgColor: "(#%x+)"\n%s+bgColor: "(#%x+)"')
    truthy(Util.contrast(fg, bg) >= 4.5, style .. " k9s crumbs")
  end
end)

test("borderless: picker borders vanish, panels stay distinct", function()
  local function c_bg(style)
    return require("kissaten").colors(style).bg
  end
  local function c_mantle(style)
    return require("kissaten").colors(style).mantle
  end
  for _, style in ipairs(styles) do
    load(style, { borderless = true })
    local p = require("kissaten").colors().ui.picker
    for _, g in ipairs({
      "TelescopeBorder",
      "TelescopePromptBorder",
      "TelescopeResultsBorder",
      "TelescopePreviewBorder",
      "SnacksPickerBorder",
      "SnacksPickerInputBorder",
      "SnacksPickerListBorder",
      "SnacksPickerPreviewBorder",
      "SnacksPickerBoxBorder",
      "FzfLuaBorder",
      "FzfLuaPreviewBorder",
    }) do
      local h = hl(g)
      truthy(h.fg and h.fg == h.bg, style .. ": " .. g .. " is invisible")
    end
    eq(hex(hl("SnacksPickerInput").bg), p.prompt, "snacks prompt panel")
    eq(hex(hl("TelescopePreviewNormal").bg), p.preview, "telescope preview panel")
    truthy(Util.contrast(p.prompt, p.list) >= 1.15, style .. ": prompt stands out from the list")
    truthy(Util.contrast(p.sel, p.list) >= 1.1, style .. ": selection stands out in the list")
    truthy(p.sel ~= p.prompt, style .. ": selection doesn't match the prompt")
    truthy(
      Util.contrast(p.list, c_bg(style)) >= 1.05 or p.list ~= c_mantle(style),
      style .. ": list visible against the editor"
    )
    truthy(hl("TelescopePromptTitle").bg ~= hl("TelescopePromptNormal").bg, style .. ": titles stay badges")
  end
  load("evening", { borderless = true, transparent = true })
  truthy(hl("SnacksPickerList").bg ~= nil, "panels stay solid with transparent")
  load("evening")
  truthy(hl("TelescopeBorder").fg ~= hl("TelescopeBorder").bg, "off by default")
end)

test("diagnostics and inlay hints: underline, virtual text and styles", function()
  load("evening")
  truthy(hl("DiagnosticUnderlineError").undercurl, "undercurl by default")
  truthy(hl("DiagnosticVirtualTextError").bg, "tinted virtual text by default")
  truthy(hl("LspInlayHint").bg and hl("LspInlayHint").italic, "inlay hints tinted and italic")
  load("evening", { diagnostics = { underline = "underline" } })
  local u = hl("DiagnosticUnderlineWarn")
  truthy(u.underline and not u.undercurl and u.sp, "plain underline keeps its color")
  truthy(hl("DiagnosticVirtualTextError").bg, "virtual_text untouched by underline change")
  load("evening", { diagnostics = { underline = false, virtual_text = "plain" }, inlay_hints = "plain" })
  u = hl("DiagnosticUnderlineError")
  truthy(not u.underline and not u.undercurl, "no underline")
  eq(hl("DiagnosticVirtualTextError").bg, nil, "plain virtual text")
  truthy(hl("DiagnosticVirtualTextError").fg, "keeps its color")
  eq(hl("LspInlayHint").bg, nil, "plain inlay hints")
  -- options merge with the defaults, so turning an attribute off is explicit
  load("evening", { styles = { virtual_text = { italic = true }, inlay_hints = { italic = false } } })
  truthy(hl("DiagnosticVirtualTextHint").italic, "styles.virtual_text")
  truthy(not hl("LspInlayHint").italic, "styles.inlay_hints italic = false")
  load("evening", { styles = { virtual_text = { italic = true } }, no_italic = true })
  truthy(not hl("DiagnosticVirtualTextHint").italic, "no_italic still wins")
  load("evening", { diagnostics = "loud" })
  truthy(#warnings == 1 and warnings[1].msg:find("diagnostics"), "bad diagnostics warns once")
  truthy(hl("DiagnosticUnderlineError").undercurl, "and falls back to defaults")
  load("evening", { diagnostics = { underline = "squiggle" } })
  truthy(#warnings == 1 and warnings[1].msg:find("diagnostics.underline"), "bad nested value warns")
end)

test("styles: conditionals and loops follow keywords unless set", function()
  load("evening")
  truthy(hl("Conditional").italic and hl("Repeat").italic, "inherit keywords (italic)")
  load("evening", { styles = { conditionals = { bold = true } } })
  truthy(hl("Conditional").bold and not hl("Conditional").italic, "conditionals replaces the keyword style")
  truthy(hl("Repeat").italic and not hl("Repeat").bold, "loops still follow keywords")
  truthy(hl("Keyword").italic and not hl("Keyword").bold, "other keywords untouched")
  load("evening", { styles = { loops = { underline = true } } })
  truthy(hl("@keyword.repeat").underline or hl("Repeat").underline, "loops applied")
end)

test("saturation never merges status colors (alone or with colorblind)", function()
  for _, style in ipairs(styles) do
    for _, amount in ipairs({ 0, 0.3, 0.6 }) do
      local c = colors(style, { saturation = amount })
      local d, w = separation(pick(c.diag, { "error", "warn", "ok" }), { "normal" })
      truthy(d >= 5, ("%s @%s error/warn/ok %.1f (%s)"):format(style, amount, d, w))
      d, w = separation(pick(c.git, { "add", "change", "delete" }), { "normal" })
      truthy(d >= 5, ("%s @%s git %.1f (%s)"):format(style, amount, d, w))
      eq(Util.contrast(c.diag.error, c.bg) >= 4.4, true, style .. " error stays readable")
      for mode, kinds in pairs({ ["red-green"] = { "protan", "deutan" }, ["blue-yellow"] = { "tritan" } }) do
        local cb = colors(style, { saturation = amount, colorblind = mode })
        d, w = separation(pick(cb.git, { "add", "change", "delete" }), kinds)
        truthy(d >= 10, ("%s @%s %s git %.1f (%s)"):format(style, amount, mode, d, w))
      end
    end
  end
  -- syntax still follows saturation all the way down
  local _, a, b = Util.to_oklab(colors("evening", { saturation = 0 }).syn.string)
  truthy(math.sqrt(a * a + b * b) < 0.01, "syntax is grey at 0")
end)

test("accent: statusline modes never share a color", function()
  for _, accent in ipairs(require("kissaten.config").accents) do
    local m = colors("evening", { accent = accent }).ui.modes
    eq(m.normal, colors("evening", { accent = accent })[accent], "normal = accent")
    local seen = {}
    for mode, color in pairs(m) do
      truthy(not seen[color], ("accent %s: %s and %s share %s"):format(accent, mode, tostring(seen[color]), color))
      seen[color] = mode
    end
  end
  load("evening", { accent = "green" })
  local t = require("lualine.themes.kissaten")
  truthy(t.normal.a.bg ~= t.insert.a.bg, "lualine normal vs insert")
  truthy(hl("MiniStatuslineModeNormal").bg ~= hl("MiniStatuslineModeInsert").bg, "mini.statusline")
end)

test("rainbow_variables: distinct, readable colors on every style", function()
  local C = require("kissaten.colors")
  for _, style in ipairs(styles) do
    -- off by default: no colors, no groups
    eq(colors(style).variables, nil, style .. ": off by default")
    local c = colors(style, { rainbow_variables = true })
    eq(#c.variables, C.VARIABLE_COLORS, style .. ": 12 colors")
    for i, color in ipairs(c.variables) do
      truthy(Util.contrast(color, c.bg) >= 4.5, ("%s: variable %d below AA"):format(style, i))
      truthy(distance(color, c.fg) >= 4, ("%s: variable %d too close to plain text"):format(style, i))
    end
    local list = {}
    for i, color in ipairs(c.variables) do
      list[i] = { "v" .. i, color }
    end
    local d, w = separation(list, { "normal" })
    truthy(d >= 6.5, ("%s: variable colors %.1f apart (%s)"):format(style, d, w))
    -- colorblind: 6 colors on the axis that type keeps
    for mode, kinds in pairs({
      ["red-green"] = { "normal", "protan", "deutan" },
      ["blue-yellow"] = { "normal", "tritan" },
    }) do
      local cb = colors(style, { rainbow_variables = true, colorblind = mode })
      eq(#cb.variables, 6, style .. " " .. mode .. ": 6 colors")
      list = {}
      for i, color in ipairs(cb.variables) do
        truthy(Util.contrast(color, cb.bg) >= 4.5, ("%s %s: variable %d below AA"):format(style, mode, i))
        list[i] = { "v" .. i, color }
      end
      d, w = separation(list, kinds)
      truthy(d >= 5, ("%s %s: variable colors %.1f apart (%s)"):format(style, mode, d, w))
    end
    -- like status colors, they keep their hue under saturation
    local grey = colors(style, { rainbow_variables = true, saturation = 0 })
    list = {}
    for i, color in ipairs(grey.variables) do
      list[i] = { "v" .. i, color }
    end
    d = separation(list, { "normal" })
    truthy(d >= 4, ("%s @saturation 0: variable colors %.1f apart"):format(style, d))
  end
end)

test("rainbow_variables: groups, autocommand and token filtering", function()
  local sem = require("kissaten.semantic")
  -- stable, in range, spread out
  eq(sem.index("total", 12), sem.index("total", 12), "same name, same color")
  local used = {}
  for _, name in ipairs({ "a", "b", "item", "items", "sum", "total", "cart", "raw", "path", "x", "y", "i" }) do
    local i = sem.index(name, 12)
    truthy(i >= 1 and i <= 12, "index in range")
    used[i] = true
  end
  truthy(vim.tbl_count(used) >= 6, "names spread over the colors")

  load("evening", { rainbow_variables = true })
  eq(sem.count, 12, "enabled with 12 colors")
  local c = require("kissaten").colors()
  for i = 1, 12 do
    eq(hex(hl("KissatenVariable" .. i).fg), c.variables[i], "group " .. i)
  end
  truthy(#vim.api.nvim_get_autocmds({ group = sem.augroup, event = "LspTokenUpdate" }) == 1, "one autocommand")
  load("evening", { rainbow_variables = true }) -- reloading doesn't stack autocommands
  truthy(#vim.api.nvim_get_autocmds({ group = sem.augroup, event = "LspTokenUpdate" }) == 1, "still one")

  local function tok(type, mods)
    return { type = type, modifiers = mods or {}, line = 0, start_col = 0, end_col = 3 }
  end
  truthy(sem.group_for(tok("variable"), "sum"), "variables")
  truthy(sem.group_for(tok("parameter"), "item"), "parameters")
  truthy(sem.group_for(tok("variable", { readonly = true }), "MAX"), "const locals too")
  eq(sem.group_for(tok("property"), "sku"), nil, "properties keep their color")
  eq(sem.group_for(tok("function"), "add"), nil, "functions keep their color")
  eq(sem.group_for(tok("variable", { defaultLibrary = true }), "console"), nil, "library globals skipped")
  eq(sem.group_for(tok("variable"), "sum"), sem.group_for(tok("parameter"), "sum"), "by name, not by kind")

  load("evening", { rainbow_variables = true, colorblind = "red-green" })
  eq(sem.count, 6, "colorblind: 6 colors")
  load("evening")
  eq(sem.count, 0, "off again")
  eq(pcall(vim.api.nvim_get_autocmds, { group = sem.augroup }), false, "autocommand removed")
  eq(hl("KissatenVariable1").fg, nil, "groups cleared")
end)

test("semantic modifiers: readonly, statics, globals and mutable styles", function()
  load("evening")
  truthy(hl("@lsp.typemod.variable.mutable.rust").underline, "rust mut underlined by default")
  truthy(hl("@lsp.mod.mutable").underline, "any server's mutable too")
  eq(
    hex(hl("@lsp.typemod.parameter.mutable.rust").fg),
    require("kissaten").colors().syn.parameter,
    "mut params keep their color"
  )
  eq(next(hl("@lsp.mod.readonly")), nil, "readonly untouched by default")
  load("evening", {
    styles = {
      readonly = { italic = true },
      statics = { bold = true },
      globals = { underdotted = true },
      mutable = { underdouble = true },
    },
  })
  truthy(hl("@lsp.mod.readonly").italic, "readonly")
  truthy(hl("@lsp.mod.static").bold, "statics")
  truthy(hl("@lsp.mod.global").underdotted and hl("@lsp.mod.globalScope").underdotted, "globals (LuaLS and clangd)")
  local mut = hl("@lsp.typemod.variable.mutable.rust")
  truthy(mut.underdouble and not mut.underline, "mutable style replaces the underline")
  eq(hl("@lsp.mod.readonly").fg, nil, "modifiers only add attributes, never color")
  -- options merge with the defaults, so turning the underline off is explicit
  load("evening", { styles = { mutable = { underline = false } } })
  truthy(not hl("@lsp.mod.mutable").underline, "underline = false turns it off")
  truthy(not hl("@lsp.typemod.variable.mutable.rust").underline, "for rust too")
  load("evening", { styles = { readonly = { italic = true } }, no_italic = true })
  truthy(not hl("@lsp.mod.readonly").italic, "no_italic still wins")
  load("evening", { styles = { readonly = "italic" } })
  truthy(#warnings == 1 and warnings[1].msg:find("styles.readonly"), "invalid style warns")
end)

test("references: reads and writes look different on every style", function()
  for _, style in ipairs(styles) do
    load(style)
    local c = require("kissaten").colors()
    eq(hex(hl("LspReferenceRead").bg), c.ui.bg_read, style .. " read")
    eq(hex(hl("LspReferenceWrite").bg), c.ui.bg_write, style .. " write")
    local d, w = separation(
      { { "read", c.ui.bg_read }, { "write", c.ui.bg_write } },
      { "normal", "protan", "deutan", "tritan" }
    )
    truthy(d >= 5, ("%s: read vs write %.1f (%s)"):format(style, d, w))
    truthy(distance(c.ui.bg_write, c.ui.bg_search) >= 3.5, style .. ": write vs search")
    truthy(distance(c.ui.bg_write, c.ui.bg_visual) >= 3.5, style .. ": write vs selection")
    truthy(Util.contrast(c.fg, c.ui.bg_write) >= 4.5, style .. ": text on a write")
    truthy(Util.contrast(c.ui.bg_read, c.bg) >= 1.2, style .. ": reads visible")
  end
  eq(hl("IlluminatedWordWrite").bg, hl("LspReferenceWrite").bg, "vim-illuminate follows")
end)

test("recipes: OS dark mode (auto-dark-mode.nvim) and per-language overrides", function()
  -- auto-dark-mode.nvim's defaults just set 'background' like this
  load("midnight", { style = "midnight", light_style = "morning" })
  vim.api.nvim_set_option_value("background", "light", {})
  eq(vim.g.colors_name, "kissaten-morning", "OS switched to light")
  vim.api.nvim_set_option_value("background", "dark", {})
  eq(vim.g.colors_name, "kissaten-midnight", "and back to dark")

  -- per-language: treesitter captures and semantic tokens take a .<lang> suffix
  load("evening", {
    on_highlights = function(h, c)
      h["@variable.member.python"] = { fg = c.orange }
      h["@lsp.type.variable.lua"] = { fg = c.pink, italic = true }
      h["@markup.heading.1.markdown"] = { fg = c.yellow, bold = true }
    end,
  })
  local c = require("kissaten").colors()
  eq(hex(hl("@variable.member.python").fg), c.orange, "python members only")
  eq(hex(hl("@variable.member").fg), c.syn.property, "other languages untouched")
  truthy(hl("@lsp.type.variable.lua").italic, "semantic tokens per language")
  eq(hex(hl("@markup.heading.1.markdown").fg), c.yellow, "markdown headings")
  vim.o.background = "dark"
end)

test("options: every pair of options works together on every style", function()
  -- one representative value per option; each pair must load cleanly and
  -- keep the theme's guarantees
  local variants = {
    { colorblind = "red-green" },
    { colorblind = "blue-yellow" },
    { saturation = 0 },
    { saturation = 0.5 },
    { accent = "green" },
    { accent = "yellow" },
    { rainbow = "mono" },
    { rainbow = "dimmed" },
    { borderless = true },
    { diagnostics = { underline = false, virtual_text = "plain" }, inlay_hints = "plain" },
    { contrast = "high" },
    { subtle_comments = 0.7 },
    { transparent = true },
    { no_italic = true, no_underline = true },
    { bright_borders = true },
    { styles = { conditionals = { bold = true }, loops = { bold = true } } },
    { rainbow_variables = true },
    { styles = { readonly = { italic = true }, statics = { bold = true }, globals = { underdotted = true } } },
  }
  local skip = { comment = true, deprecated = true, tag_delimiter = true, string_doc = true }
  local pairs_run = 0
  for i = 1, #variants do
    for j = i + 1, #variants do
      local opts = vim.tbl_deep_extend("force", {}, variants[i], variants[j])
      if
        not (variants[i].colorblind and variants[j].colorblind)
        and not (variants[i].saturation and variants[j].saturation)
        and not (variants[i].accent and variants[j].accent)
        and not (variants[i].rainbow and variants[j].rainbow)
      then
        pairs_run = pairs_run + 1
        for _, style in ipairs(styles) do
          local c = colors(style, opts)
          local where = style .. " " .. vim.inspect(opts, { newline = " ", indent = "" })
          eq(#warnings, 0, where .. ": warnings")
          for role, color in pairs(c.syn) do
            if not skip[role] then
              truthy(Util.contrast(color, c.bg) >= 4.4, where .. ": syn." .. role .. " below AA")
            end
          end
          truthy(Util.contrast(c.ui.on_badge, c.ui.accent) >= 4.5, where .. ": badge text")
          local seen = {}
          for mode, color in pairs(c.ui.modes) do
            truthy(not seen[color], where .. ": modes " .. mode .. "/" .. tostring(seen[color]))
            seen[color] = mode
          end
          for i, color in ipairs(c.variables or {}) do
            truthy(Util.contrast(color, c.bg) >= 4.5, where .. ": variable color " .. i .. " below AA")
          end
          if opts.colorblind then
            local kinds = opts.colorblind == "red-green" and { "protan", "deutan" } or { "tritan" }
            local d = separation(pick(c.git, { "add", "change", "delete" }), kinds)
            truthy(d >= 10, where .. (": colorblind git %.1f"):format(d))
          end
        end
      end
    end
  end
  truthy(pairs_run > 100, "ran " .. pairs_run .. " pairs")
  -- and with highlight groups applied, for the options that touch groups
  load("morning", { borderless = true, bright_borders = true, transparent = true, no_underline = true })
  eq(hl("SnacksPickerBorder").fg, hl("SnacksPickerBorder").bg, "borderless beats bright_borders in pickers")
  truthy(hl("FloatBorder").fg ~= hl("NormalFloat").bg, "bright_borders still applies to other floats")
  truthy(not hl("DiagnosticUnderlineError").undercurl, "no_underline beats diagnostics.underline")
  reset()
end)

test("options: everything combined loads in every style without warnings", function()
  local all = {
    colorblind = "red-green",
    saturation = 0.6,
    accent = "teal",
    rainbow = "dimmed",
    borderless = true,
    diagnostics = { underline = "underline", virtual_text = "plain" },
    inlay_hints = "plain",
    contrast = "high",
    subtle_comments = 0.5,
    transparent = true,
    styles = { conditionals = { bold = true }, loops = { bold = true } },
  }
  for _, style in ipairs(styles) do
    load(style, all)
    eq(#warnings, 0, style .. ": no warnings")
    eq(vim.g.colors_name, "kissaten-" .. style)
  end
  load("evening", { colorblind = "blue-yellow", accent = "pink" })
  local text = checkhealth("kissaten")
  truthy(text:find('colorblind = "blue-yellow"', 1, true), "health lists the active options")
  truthy(text:find("Every syntax role meets WCAG AA"), "and AA still holds")
  vim.cmd("bwipeout!")
  load("evening", { colorblind = "deutan" })
  truthy(#warnings == 1 and warnings[1].msg:find("colorblind"), "unknown colorblind value warns")
  eq(require("kissaten.config").options.colorblind, false, "and turns it off")
  reset()
end)

test(":checkhealth kissaten runs", function()
  local text = checkhealth("kissaten")
  truthy(text:find("kissaten.nvim"), "health output")
  truthy(not text:find("ERROR"), "health has errors:\n" .. text)
end)

vim.notify = orig_notify
print(("\n%d passed, %d failed"):format(passed, #failures))
os.exit(#failures == 0 and 0 or 1)
