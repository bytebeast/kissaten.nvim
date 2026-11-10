-- Yazi flavors: one kissaten-<style>.yazi/ folder per style, as yazi loads
-- them (flavors/<name>.yazi/flavor.toml + tmtheme.xml, yazi-config
-- src/theme/flavor.rs). Keys follow yazi's preset theme (theme-dark.toml);
-- tmtheme.xml is the bat theme, so previews highlight code the same way.
local M = {}

---@param c kissaten.Colors
function M.generate(c)
  local ui, d, g, on = c.ui, c.diag, c.git, c.ui.on_badge
  local function fg(color, extra)
    return ('{ fg = "%s"%s }'):format(color, extra or "")
  end
  local function badge(bg)
    return ('{ fg = "%s", bg = "%s", bold = true }'):format(on, bg)
  end
  local function alt(color)
    return ('{ fg = "%s", bg = "%s" }'):format(color, c.surface0)
  end
  local function marker(color)
    return ('{ fg = "%s", bg = "%s" }'):format(color, color)
  end
  local border = fg(ui.border_float)
  -- stylua: ignore
  local sections = {
    { "mgr", {
      { "cwd", fg(c.teal) },
      { "find_keyword", fg(c.yellow, ", bold = true, italic = true, underline = true") },
      { "find_position", fg(c.pink, ', bg = "reset", bold = true, italic = true') },
      { "symlink_target", fg(c.teal, ", italic = true") },
      { "marker_copied", marker(g.add) },
      { "marker_cut", marker(g.delete) },
      { "marker_marked", marker(c.teal) },
      { "marker_selected", marker(c.yellow) },
      { "count_copied", badge(g.add) },
      { "count_cut", badge(g.delete) },
      { "count_selected", badge(c.yellow) },
      { "border_style", fg(ui.border) },
    } },
    { "tabs", {
      { "active", badge(ui.accent) },
      { "inactive", ('{ fg = "%s", bg = "%s" }'):format(c.comment, c.mantle) },
    } },
    { "mode", {
      { "normal_main", badge(ui.modes.normal) }, { "normal_alt", alt(ui.modes.normal) },
      { "select_main", badge(ui.modes.visual) }, { "select_alt", alt(ui.modes.visual) },
      { "unset_main", badge(ui.modes.replace) }, { "unset_alt", alt(ui.modes.replace) },
    } },
    { "indicator", {
      { "current", ('{ bg = "%s", bold = true }'):format(ui.bg_sel) },
    } },
    { "status", {
      { "perm_sep", fg(c.overlay0) },
      { "perm_type", fg(c.blue) },
      { "perm_read", fg(c.yellow) },
      { "perm_write", fg(c.red) },
      { "perm_exec", fg(c.green) },
      { "progress_label", fg(c.fg, ", bold = true") },
      { "progress_normal", ('{ fg = "%s", bg = "%s" }'):format(ui.accent, c.surface1) },
      { "progress_error", ('{ fg = "%s", bg = "%s" }'):format(d.error, c.surface1) },
    } },
    { "which", {
      { "border", border },
      { "mask", ('{ bg = "%s" }'):format(ui.bg_float) },
      { "cand", fg(c.teal) },
      { "rest", fg(c.overlay0) },
      { "desc", fg(c.purple) },
      { "separator_style", fg(c.overlay0) },
    } },
    { "confirm", {
      { "border", border },
      { "title", fg(ui.title, ", bold = true") },
      { "btn_yes", badge(ui.accent) },
      { "btn_no", fg(c.subtext) },
    } },
    { "spot", {
      { "border", border },
      { "title", fg(ui.title, ", bold = true") },
      { "tbl_col", fg(c.blue) },
      { "tbl_cell", ('{ bg = "%s" }'):format(ui.bg_sel) },
    } },
    { "notify", {
      { "title_info", fg(d.info) },
      { "title_warn", fg(d.warn) },
      { "title_error", fg(d.error) },
    } },
    { "pick", { { "border", border }, { "active", fg(ui.accent, ", bold = true") } } },
    { "input", {
      { "border", border },
      { "title", fg(ui.title) },
      { "value", fg(c.fg) },
      { "hint", fg(c.comment, ", italic = true") },
      { "selected", ('{ bg = "%s" }'):format(ui.bg_visual) },
    } },
    { "cmp", { { "border", border }, { "active", ('{ bg = "%s", bold = true }'):format(ui.bg_sel) } } },
    { "tasks", { { "border", border }, { "title", fg(ui.title) }, { "hovered", fg(ui.accent, ", bold = true") } } },
    { "help", {
      { "border", border },
      { "chord", fg(c.teal) },
      { "hovered", ('{ bg = "%s", bold = true }'):format(ui.bg_sel) },
    } },
  }
  local out = { ("# %s: %s"):format(c._display, c._upstream) }
  for _, section in ipairs(sections) do
    out[#out + 1] = ""
    out[#out + 1] = ("[%s]"):format(section[1])
    for _, kv in ipairs(section[2]) do
      out[#out + 1] = ("%s = %s"):format(kv[1], kv[2])
    end
  end
  -- stylua: ignore
  local rules = {
    ('{ mime = "**/image/*", fg = "%s" }'):format(c.yellow),
    ('{ mime = "**/{audio,video}/*", fg = "%s" }'):format(c.purple),
    ('{ mime = "**/application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}", fg = "%s" }'):format(c.red),
    ('{ mime = "**/application/{pdf,doc,rtf}", fg = "%s" }'):format(c.teal),
    ('{ mime = "vfs/{absent,stale}", fg = "%s" }'):format(c.overlay0),
    ('{ url = "*", is = "orphan", fg = "%s" }'):format(d.error),
    ('{ url = "*", is = "exec", fg = "%s" }'):format(c.green),
    ('{ url = "*", is = "dummy", fg = "%s" }'):format(d.error),
    ('{ url = "*/", is = "dummy", fg = "%s" }'):format(d.error),
    ('{ url = "*", fg = "%s" }'):format(c.fg),
    ('{ url = "*/", fg = "%s" }'):format(c.blue),
  }
  out[#out + 1] = ""
  out[#out + 1] = "[filetype]"
  out[#out + 1] = "rules = ["
  for _, rule in ipairs(rules) do
    out[#out + 1] = "\t" .. rule .. ","
  end
  out[#out + 1] = "]"
  return table.concat(out, "\n") .. "\n"
end

--- One flavor folder per style.
function M.static()
  local Extras = require("kissaten.extras")
  local files = {}
  for _, style in ipairs(require("kissaten.config").styles) do
    local dir = "kissaten-" .. style .. ".yazi/"
    files[dir .. "flavor.toml"] = Extras.render("yazi", style)
    files[dir .. "tmtheme.xml"] = Extras.render("bat", style)
  end
  return files
end

return M
