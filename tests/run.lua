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
  vim.cmd("checkhealth kissaten")
  local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
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

test("extras generate for every style", function()
  local Extras = require("kissaten.extras")
  for name in pairs(Extras.extras) do
    for _, style in ipairs(styles) do
      local out = Extras.render(name, style)
      truthy(type(out) == "string" and #out > 50, name .. "/" .. style)
      truthy(not out:find("%${"), name .. "/" .. style .. " has unreplaced template variables")
    end
  end
end)

test(":checkhealth kissaten runs", function()
  vim.cmd("checkhealth kissaten")
  local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
  truthy(text:find("kissaten.nvim"), "health output")
  truthy(not text:find("ERROR"), "health has errors:\n" .. text)
end)

vim.notify = orig_notify
print(("\n%d passed, %d failed"):format(passed, #failures))
os.exit(#failures == 0 and 0 or 1)
