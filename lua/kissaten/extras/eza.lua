-- eza theme (https://eza.rocks). Keys follow eza's UiStylesOverride
-- (src/options/config.rs); eza silently ignores unknown keys, so the test
-- suite checks every key here against that list.
local Util = require("kissaten.util")

local M = {}

---@param c kissaten.Colors
function M.generate(c)
  local t = vim.deepcopy(c)
  -- quieter variants for "the same thing, but less important"
  t._dim_fg = c.subtext
  t._dim_meta = c.comment
  t._unit = Util.blend(c.comment, c.subtext, 0.5)
  local out = require("kissaten.extras").template(
    [[
# ${_display} for eza
# upstream: ${_upstream}
# Save as theme.yml in eza's config directory:
#   Linux:  ~/.config/eza/theme.yml
#   macOS:  ~/Library/Application Support/eza/theme.yml
#   or anywhere, with EZA_CONFIG_DIR pointing at the folder that holds it

colourful: true

filekinds:
  normal: { foreground: "${fg}" }
  directory: { foreground: "${blue}", is_bold: true }
  symlink: { foreground: "${cyan}" }
  pipe: { foreground: "${_dim_fg}" }
  block_device: { foreground: "${yellow}" }
  char_device: { foreground: "${yellow}" }
  socket: { foreground: "${_dim_fg}" }
  special: { foreground: "${pink}" }
  executable: { foreground: "${green}", is_bold: true }
  mount_point: { foreground: "${teal}", is_underline: true }

# read / write / execute keep one color each, so a column reads at a glance
perms:
  user_read: { foreground: "${yellow}", is_bold: true }
  user_write: { foreground: "${red}", is_bold: true }
  user_execute_file: { foreground: "${green}", is_bold: true }
  user_execute_other: { foreground: "${green}", is_bold: true }
  group_read: { foreground: "${yellow}" }
  group_write: { foreground: "${red}" }
  group_execute: { foreground: "${green}" }
  other_read: { foreground: "${yellow}" }
  other_write: { foreground: "${red}" }
  other_execute: { foreground: "${green}" }
  special_user_file: { foreground: "${pink}" }
  special_other: { foreground: "${pink}" }
  attribute: { foreground: "${_dim_meta}" }

# bigger files get warmer: bytes -> kilo -> mega -> giga -> huge
size:
  major: { foreground: "${_dim_fg}" }
  minor: { foreground: "${sky}" }
  number_byte: { foreground: "${fg}" }
  number_kilo: { foreground: "${sky}" }
  number_mega: { foreground: "${blue}" }
  number_giga: { foreground: "${purple}" }
  number_huge: { foreground: "${orange}" }
  unit_byte: { foreground: "${_unit}" }
  unit_kilo: { foreground: "${sky}" }
  unit_mega: { foreground: "${blue}" }
  unit_giga: { foreground: "${purple}" }
  unit_huge: { foreground: "${orange}" }

users:
  user_you: { foreground: "${fg}" }
  user_root: { foreground: "${red}", is_bold: true }
  user_other: { foreground: "${maroon}" }
  group_yours: { foreground: "${_dim_fg}" }
  group_other: { foreground: "${_dim_meta}" }
  group_root: { foreground: "${red}" }

links:
  normal: { foreground: "${cyan}" }
  multi_link_file: { foreground: "${orange}" }

git:
  new: { foreground: "${git.add}" }
  modified: { foreground: "${git.change}" }
  deleted: { foreground: "${git.delete}" }
  renamed: { foreground: "${teal}" }
  typechange: { foreground: "${purple}" }
  ignored: { foreground: "${git.ignore}" }
  conflicted: { foreground: "${git.conflict}", is_bold: true }

git_repo:
  branch_main: { foreground: "${_dim_fg}" }
  branch_other: { foreground: "${purple}" }
  git_clean: { foreground: "${git.add}" }
  git_dirty: { foreground: "${git.change}" }

security_context:
  none: { foreground: "${_dim_meta}" }
  selinux:
    colon: { foreground: "${overlay0}" }
    user: { foreground: "${_dim_fg}" }
    role: { foreground: "${purple}" }
    typ: { foreground: "${_dim_meta}" }
    range: { foreground: "${purple}" }

file_type:
  image: { foreground: "${purple}" }
  video: { foreground: "${pink}" }
  music: { foreground: "${teal}" }
  lossless: { foreground: "${teal}", is_bold: true }
  crypto: { foreground: "${orange}" }
  document: { foreground: "${fg}" }
  compressed: { foreground: "${red}" }
  temp: { foreground: "${_dim_meta}", is_italic: true }
  compiled: { foreground: "${_dim_meta}" }
  build: { foreground: "${yellow}", is_underline: true }
  source: { foreground: "${fg}" }

punctuation: { foreground: "${overlay0}" }
date: { foreground: "${lavender}" }
inode: { foreground: "${_dim_meta}" }
blocks: { foreground: "${_dim_meta}" }
header: { foreground: "${fg}", is_bold: true, is_underline: true }
octal: { foreground: "${teal}" }
flags: { foreground: "${purple}" }

symlink_path: { foreground: "${cyan}" }
control_char: { foreground: "${red}" }
broken_symlink: { foreground: "${red}", is_bold: true }
broken_path_overlay: { foreground: "${overlay0}", is_underline: true }
]],
    t
  )
  -- eza keeps its own default for any attribute a theme leaves out (e.g. its
  -- bold source files), so spell out every attribute on every style.
  local attrs = { "is_bold", "is_dimmed", "is_italic", "is_underline" }
  return (
    out:gsub('{ (foreground: "#%x+")(.-) }', function(fg, rest)
      for _, attr in ipairs(attrs) do
        if not rest:find(attr, 1, true) then
          rest = rest .. ", " .. attr .. ": false"
        end
      end
      return "{ " .. fg .. rest .. " }"
    end)
  )
end

return M
