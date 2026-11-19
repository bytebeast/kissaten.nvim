-- st (suckless terminal): replaces colorname[] and the default* lines in
-- config.h. Layout follows st's config.def.h: 16 ANSI colors, then the
-- cursor, reverse cursor, foreground and background at 256..259.
local M = {}

---@param c kissaten.Colors
function M.generate(c)
  local out = {
    ("/* %s for st: replace colorname[] and the default* lines in config.h */"):format(c._display),
    "/* upstream: " .. c._upstream .. " */",
    "static const char *colorname[] = {",
  }
  for _, color in ipairs(require("kissaten.extras").ansi(c)) do
    out[#out + 1] = ('\t"%s",'):format(color)
  end
  vim.list_extend(out, {
    "",
    "\t[255] = 0,",
    "",
    ('\t"%s", /* 256: cursor */'):format(c.fg),
    ('\t"%s", /* 257: reverse cursor */'):format(c.bg),
    ('\t"%s", /* 258: foreground */'):format(c.fg),
    ('\t"%s", /* 259: background */'):format(c.bg),
    "};",
    "",
    "unsigned int defaultfg = 258;",
    "unsigned int defaultbg = 259;",
    "unsigned int defaultcs = 256;",
    "static unsigned int defaultrcs = 257;",
  })
  return table.concat(out, "\n") .. "\n"
end

return M
