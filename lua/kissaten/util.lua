---@mod kissaten.util Color math and small helpers
local M = {}

---@param hex string "#rrggbb"
---@return integer r, integer g, integer b
function M.rgb(hex)
  hex = hex:gsub("^#", "")
  assert(#hex == 6, ("kissaten: invalid hex color '%s'"):format(hex))
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

---@return string
function M.hex(r, g, b)
  local function clamp(v)
    return math.min(255, math.max(0, math.floor(v + 0.5)))
  end
  return ("#%02x%02x%02x"):format(clamp(r), clamp(g), clamp(b))
end

---@param s any
---@return boolean
function M.is_hex(s)
  return type(s) == "string" and s:match("^#%x%x%x%x%x%x$") ~= nil
end

--- Mix `fg` over `bg`. `alpha = 1` returns fg, `alpha = 0` returns bg.
---@param fg string
---@param bg string
---@param alpha number
---@return string
function M.blend(fg, bg, alpha)
  if not (M.is_hex(fg) and M.is_hex(bg)) then
    return fg
  end
  local fr, fg_, fb = M.rgb(fg)
  local br, bg_, bb = M.rgb(bg)
  return M.hex(alpha * fr + (1 - alpha) * br, alpha * fg_ + (1 - alpha) * bg_, alpha * fb + (1 - alpha) * bb)
end

-- Set by kissaten.colors before groups are built, so groups can blend
-- against the active background/foreground without passing them around.
M.bg = "#000000"
M.fg = "#ffffff"

-- Set by kissaten.colors from the palette's `_tint` (default 1).
M.tint_scale = 1

--- Mix an accent into a background to make a tinted background (selection,
--- diff, diagnostic and badge backgrounds). Scaled by the palette's `_tint`,
--- so a near-black palette can mix in a little more color and keep these
--- tints as visible as they are on a lighter background.
---@param color string
---@param bg string
---@param amount number 0..1
function M.tint(color, bg, amount)
  return M.blend(color, bg, math.min(1, amount * M.tint_scale))
end

--- Tint a color toward the active background (`amount` of the color is kept).
function M.blend_bg(hex, amount, bg)
  return M.blend(hex, bg or M.bg, amount)
end

--- Tint a color toward the active foreground.
function M.blend_fg(hex, amount, fg)
  return M.blend(hex, fg or M.fg, amount)
end

---@return number h, number s, number l (h in [0,360), s/l in [0,1])
function M.to_hsl(hex)
  local r, g, b = M.rgb(hex)
  r, g, b = r / 255, g / 255, b / 255
  local max, min = math.max(r, g, b), math.min(r, g, b)
  local h, s, l = 0, 0, (max + min) / 2
  if max ~= min then
    local d = max - min
    s = l > 0.5 and d / (2 - max - min) or d / (max + min)
    if max == r then
      h = (g - b) / d + (g < b and 6 or 0)
    elseif max == g then
      h = (b - r) / d + 2
    else
      h = (r - g) / d + 4
    end
    h = h * 60
  end
  return h, s, l
end

function M.from_hsl(h, s, l)
  local function f(n)
    local k = (n + h / 30) % 12
    local a = s * math.min(l, 1 - l)
    return l - a * math.max(-1, math.min(k - 3, 9 - k, 1))
  end
  return M.hex(f(0) * 255, f(8) * 255, f(4) * 255)
end

--- Lighten (positive) or darken (negative) in HSL lightness space.
function M.shade(hex, amount)
  local h, s, l = M.to_hsl(hex)
  return M.from_hsl(h, s, math.min(1, math.max(0, l + amount)))
end

--- Brighter variant used for the bright half of the terminal palette.
function M.brighten(hex, amount)
  local h, s, l = M.to_hsl(hex)
  amount = amount or 0.06
  return M.from_hsl(h, math.min(1, s + amount), math.min(1, l + amount))
end

--- WCAG 2.x relative luminance.
function M.luminance(hex)
  local function ch(v)
    v = v / 255
    return v <= 0.03928 and v / 12.92 or ((v + 0.055) / 1.055) ^ 2.4
  end
  local r, g, b = M.rgb(hex)
  return 0.2126 * ch(r) + 0.7152 * ch(g) + 0.0722 * ch(b)
end

--- WCAG 2.x contrast ratio between two colors (1..21).
function M.contrast(a, b)
  local la, lb = M.luminance(a), M.luminance(b)
  if la < lb then
    la, lb = lb, la
  end
  return (la + 0.05) / (lb + 0.05)
end

--- Move `hex` toward `toward` until it reaches `ratio` contrast against `bg`.
--- Used by the `contrast = "high"` option. Returns the input if already met.
function M.ensure_contrast(hex, bg, ratio, toward)
  if not (M.is_hex(hex) and M.is_hex(bg)) then
    return hex
  end
  local out = hex
  for i = 1, 20 do
    if M.contrast(out, bg) >= ratio then
      break
    end
    out = M.blend(toward, hex, i * 0.05)
  end
  return out
end

--- Blend `hex` toward `bg` until its contrast against `bg` drops to `ratio`
--- (bisection; contrast falls monotonically as the blend approaches bg).
--- Returns the input unchanged if it is already at or below `ratio`.
function M.reduce_contrast(hex, bg, ratio)
  if not (M.is_hex(hex) and M.is_hex(bg)) or M.contrast(hex, bg) <= ratio then
    return hex
  end
  local lo, hi = 0, 1 -- amount of `hex` kept
  for _ = 1, 24 do
    local mid = (lo + hi) / 2
    if M.contrast(M.blend(hex, bg, mid), bg) > ratio then
      hi = mid
    else
      lo = mid
    end
  end
  return M.blend(hex, bg, hi)
end

-- ── OKLab ──────────────────────────────────────────────────────────────
-- A perceptual color space: L is lightness as the eye sees it, a/b carry hue
-- and chroma. Changing chroma here keeps a color's perceived lightness, which
-- HSL can't do (an HSL-desaturated yellow looks darker, a blue lighter).

local function to_linear(v)
  v = v / 255
  return v <= 0.04045 and v / 12.92 or ((v + 0.055) / 1.055) ^ 2.4
end

local function from_linear(v)
  v = math.min(1, math.max(0, v))
  return 255 * (v <= 0.0031308 and 12.92 * v or 1.055 * v ^ (1 / 2.4) - 0.055)
end

local function cbrt(x)
  return x < 0 and -((-x) ^ (1 / 3)) or x ^ (1 / 3)
end

---@return number L, number a, number b
function M.to_oklab(hex)
  local r, g, b = M.rgb(hex)
  r, g, b = to_linear(r), to_linear(g), to_linear(b)
  local l = cbrt(0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b)
  local m = cbrt(0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b)
  local s = cbrt(0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b)
  return 0.2104542553 * l + 0.7936177850 * m - 0.0040720468 * s,
    1.9779984951 * l - 2.4285922050 * m + 0.4505937099 * s,
    0.0259040371 * l + 0.7827717662 * m - 0.8086757660 * s
end

---@return string
function M.from_oklab(L, a, b)
  local l = (L + 0.3963377774 * a + 0.2158037573 * b) ^ 3
  local m = (L - 0.1055613458 * a - 0.0638541728 * b) ^ 3
  local s = (L - 0.0894841775 * a - 1.2914855480 * b) ^ 3
  return M.hex(
    from_linear(4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s),
    from_linear(-1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s),
    from_linear(-0.0041960863 * l - 0.7034186147 * m + 1.7076127010 * s)
  )
end

--- Scale a color's chroma (0 = grey, 1 = unchanged), keeping its lightness.
function M.desaturate(hex, amount)
  if not M.is_hex(hex) or amount >= 1 then
    return hex
  end
  local L, a, b = M.to_oklab(hex)
  amount = math.max(0, amount)
  return M.from_oklab(L, a * amount, b * amount)
end

--- Adjust only the lightness of `hex` until its contrast against `bg` is
--- `ratio` (hue and chroma stay). Used to keep contrast exact after colors
--- change, e.g. after desaturating.
function M.match_contrast(hex, bg, ratio)
  if not (M.is_hex(hex) and M.is_hex(bg)) then
    return hex
  end
  local _, a, b = M.to_oklab(hex)
  local lighter = M.luminance(hex) >= M.luminance(bg)
  local lo, hi = 0, 1
  if lighter then
    lo = M.to_oklab(bg)
  else
    hi = M.to_oklab(bg)
  end
  for _ = 1, 20 do -- 2^-20 of the lightness range: far below one hex step
    local mid = (lo + hi) / 2
    local c = M.contrast(M.from_oklab(mid, a, b), bg)
    -- moving away from bg raises contrast
    if (c < ratio) == lighter then
      lo = mid
    else
      hi = mid
    end
  end
  return M.from_oklab(lighter and hi or lo, a, b)
end

--- Resolve lazily-evaluated table values (lets on_colors users use functions).
function M.resolve(groups)
  for name, hl in pairs(groups) do
    if type(hl) == "function" then
      groups[name] = hl()
    end
  end
  return groups
end

function M.notify(msg, level)
  vim.notify(msg, level or vim.log.levels.WARN, { title = "kissaten.nvim" })
end

return M
