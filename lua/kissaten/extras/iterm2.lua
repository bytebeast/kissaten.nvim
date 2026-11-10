-- iTerm2 color preset (.itermcolors, an XML property list). Keys are the
-- profile constants in sources/Settings/Profiles/ITAddressBookMgr.h; each
-- color is a dictionary of sRGB components (sources/Categories/NSColor+iTerm.m).
local Util = require("kissaten.util")

local M = {}

local function color(hex, alpha)
  local r, g, b = Util.rgb(hex)
  return table.concat({
    "\t<dict>",
    ("\t\t<key>Alpha Component</key>\n\t\t<real>%.4f</real>"):format(alpha or 1),
    ("\t\t<key>Blue Component</key>\n\t\t<real>%.6f</real>"):format(b / 255),
    "\t\t<key>Color Space</key>\n\t\t<string>sRGB</string>",
    ("\t\t<key>Green Component</key>\n\t\t<real>%.6f</real>"):format(g / 255),
    ("\t\t<key>Red Component</key>\n\t\t<real>%.6f</real>"):format(r / 255),
    "\t</dict>",
  }, "\n")
end

---@param c kissaten.Colors
function M.generate(c)
  local t = c.terminal
  -- stylua: ignore
  local entries = {
    { "Ansi 0 Color", t.black }, { "Ansi 1 Color", t.red }, { "Ansi 2 Color", t.green },
    { "Ansi 3 Color", t.yellow }, { "Ansi 4 Color", t.blue }, { "Ansi 5 Color", t.magenta },
    { "Ansi 6 Color", t.cyan }, { "Ansi 7 Color", t.white },
    { "Ansi 8 Color", t.black_bright }, { "Ansi 9 Color", t.red_bright }, { "Ansi 10 Color", t.green_bright },
    { "Ansi 11 Color", t.yellow_bright }, { "Ansi 12 Color", t.blue_bright }, { "Ansi 13 Color", t.magenta_bright },
    { "Ansi 14 Color", t.cyan_bright }, { "Ansi 15 Color", t.white_bright },
    { "Background Color", c.bg },
    { "Foreground Color", c.fg },
    { "Bold Color", c.fg },
    { "Cursor Color", c.fg },
    { "Cursor Text Color", c.bg },
    { "Selection Color", c.ui.bg_visual },
    { "Selected Text Color", c.fg },
    { "Link Color", c.teal },
    { "Match Background Color", c.ui.bg_search },
    { "Cursor Guide Color", c.ui.bg_cursorline },
    { "Badge Color", c.ui.accent, 0.5 },
  }
  table.sort(entries, function(a, b)
    return a[1] < b[1]
  end)
  local out = {
    '<?xml version="1.0" encoding="UTF-8"?>',
    '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">',
    ("<!-- %s: %s -->"):format(c._display, c._upstream),
    '<plist version="1.0">',
    "<dict>",
  }
  for _, e in ipairs(entries) do
    out[#out + 1] = ("\t<key>%s</key>"):format(e[1])
    out[#out + 1] = color(e[2], e[3])
  end
  out[#out + 1] = "</dict>"
  out[#out + 1] = "</plist>"
  return table.concat(out, "\n") .. "\n"
end

return M
