#!/usr/bin/env python3
"""Build README images from raw screenshots and the Lua palettes.

usage: make_assets.py --shots DIR [--out assets] [--font-dir DIR]

Produces:
  assets/screenshots/*.png     copies of the framed screenshots
  assets/styles.png            grid of every style (rows of 3, last row centered)
  assets/palette.png           swatch sheet generated from lua/kissaten/palettes
  assets/social-preview.png    1280x640 GitHub social preview (< 1 MB)
"""
import argparse
import os
import re
import json
import shutil
import subprocess

from PIL import Image, ImageDraw, ImageFont

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STYLES = ["morning", "afternoon", "evening", "midnight", "graveyard"]
ACCENTS = ["red", "maroon", "orange", "yellow", "green", "teal", "cyan", "sky", "blue", "lavender", "purple", "pink"]
BASES = ["crust", "mantle", "bg", "surface0", "surface1", "surface2", "overlay0", "comment", "subtext", "fg"]


def palette(style):
    src = open(os.path.join(ROOT, "lua", "kissaten", "palettes", style + ".lua")).read()
    return dict(re.findall(r'^\s+(\w+)\s*=\s*"(#[0-9a-fA-F]{6})"', src, re.M))


def rgb(h):
    h = h.lstrip("#")
    return tuple(int(h[i : i + 2], 16) for i in (0, 2, 4))


def lum(h):
    def ch(v):
        v /= 255
        return v / 12.92 if v <= 0.03928 else ((v + 0.055) / 1.055) ** 2.4

    r, g, b = rgb(h)
    return 0.2126 * ch(r) + 0.7152 * ch(g) + 0.0722 * ch(b)


def fonts(font_dir):
    def f(name, size, nl=False):
        family = "JetBrainsMonoNLNerdFontMono" if nl else "JetBrainsMonoNerdFontMono"
        return ImageFont.truetype(os.path.join(font_dir, f"{family}-{name}.ttf"), size)

    return f


def rounded(img, radius):
    mask = Image.new("L", img.size, 0)
    ImageDraw.Draw(mask).rounded_rectangle([0, 0, img.width - 1, img.height - 1], radius=radius, fill=255)
    out = Image.new("RGBA", img.size)
    out.paste(img, (0, 0), mask)
    return out


def rows_layout(n, per_row):
    """Split n items into rows of `per_row`; the caller centers the last row."""
    return [list(range(i, min(i + per_row, n))) for i in range(0, n, per_row)]


def styles_grid(shots, out):
    imgs = [Image.open(os.path.join(shots, f"style-{s}.png")).convert("RGB") for s in STYLES]
    w, h = imgs[0].size
    sw, sh = w // 2, h // 2
    rows = rows_layout(len(imgs), 3)
    cols = max(len(r) for r in rows)
    grid = Image.new("RGB", (sw * cols, sh * len(rows)), (14, 14, 20))
    for ri, row in enumerate(rows):
        x0 = (cols - len(row)) * sw // 2
        for ci, i in enumerate(row):
            grid.paste(imgs[i].resize((sw, sh), Image.LANCZOS), (x0 + ci * sw, ri * sh))
    grid.save(out, optimize=True)


def palette_sheet(font, out):
    sw, sh, pad, label_w = 64, 56, 28, 170
    cols = len(BASES) + len(ACCENTS)
    W = pad * 2 + label_w + cols * sw + 24
    H = pad * 2 + len(STYLES) * (sh + 44)
    img = Image.new("RGB", (W, H), (14, 14, 20))
    d = ImageDraw.Draw(img)
    big, small = font("Bold", 20), font("Regular", 11)
    for r, style in enumerate(STYLES):
        p = palette(style)
        y = pad + r * (sh + 44)
        d.rounded_rectangle([pad - 10, y - 10, W - pad + 10, y + sh + 22], radius=10, fill=rgb(p["bg"]))
        d.text((pad + 4, y + sh // 2 - 14), style, font=big, fill=rgb(p["fg"]))
        x = pad + label_w
        for i, key in enumerate(BASES + ACCENTS):
            if i == len(BASES):
                x += 24
            c = p[key]
            d.rounded_rectangle([x + 3, y, x + sw - 3, y + sh - 18], radius=6, fill=rgb(c), outline=rgb(p["surface2"]))
            d.text((x + 4, y + sh - 15), c[1:], font=small, fill=rgb(p["subtext"]))
            x += sw
    img.save(out, optimize=True)


def social_preview(shots, font, out):
    W, H = 1280, 640
    p = palette("evening")
    img = Image.new("RGB", (W, H), rgb(p["crust"]))
    d = ImageDraw.Draw(img)

    # right: real screenshot crop with a soft left edge
    shot = Image.open(os.path.join(shots, "hero.png")).convert("RGB")
    crop = shot.crop((40, 40, 40 + 1100, 40 + 900))
    crop = crop.resize((int(crop.width * 0.6), int(crop.height * 0.6)), Image.LANCZOS)
    card = rounded(crop, 14)
    alpha = card.getchannel("A")
    edge = 90
    for x in range(edge):
        col = alpha.crop((x, 0, x + 1, alpha.height)).point(lambda v, f=(x / edge) ** 1.5: int(v * f))
        alpha.paste(col, (x, 0))
    card.putalpha(alpha)
    img.paste(card, (W - card.width + 40, 64), card)

    title, sub, small = font("Bold", 62), font("Regular", 24), font("Regular", 19)
    x0, y0 = 64, 150
    d.text((x0, y0), "kissaten", font=title, fill=rgb(p["fg"]))
    tw = d.textlength("kissaten", font=title)
    d.text((x0 + tw, y0), ".nvim", font=title, fill=rgb(p["blue"]))
    d.text((x0 + 4, y0 + 92), "A coffee-house colorscheme", font=sub, fill=rgb(p["subtext"]))
    d.text((x0 + 4, y0 + 126), "for Neovim and LazyVim", font=sub, fill=rgb(p["subtext"]))

    # style chips
    x, y = x0 + 2, y0 + 210
    chip = font("Regular", 17)
    for style in STYLES:
        sp = palette(style)
        w = d.textlength(style, font=chip) + 24
        d.rounded_rectangle([x, y, x + w, y + 36], radius=18, fill=rgb(sp["bg"]), outline=rgb(sp["surface2"]))
        d.text((x + 12, y + 7), style, font=chip, fill=rgb(sp["fg"]))
        x += w + 8

    # accent dots
    x, y = x0 + 6, y0 + 280
    for key in ACCENTS:
        d.ellipse([x, y, x + 26, y + 26], fill=rgb(p[key]))
        x += 34

    d.text((x0 + 4, H - 70), "WCAG-checked · 46 integrations · Neovim 0.9+", font=small, fill=rgb(p["comment"]))
    img.save(out, optimize=True)
    size = os.path.getsize(out)
    assert img.size == (1280, 640) and size < 1_000_000, (img.size, size)
    print(f"social preview: {img.size[0]}x{img.size[1]}, {size // 1024} KB")


def subtle_grid(shots, font, out):
    """off / 0.5 / 0.7 comparison for subtle_comments (rows: styles)."""
    rows = [st for st in ("evening", "morning") if os.path.exists(os.path.join(shots, f"subtle-{st}-off.png"))]
    if not rows:
        return False
    cols = [("off", "subtle_comments = false"), ("05", "subtle_comments = 0.5"), ("07", "subtle_comments = { fade = 0.7 }")]
    imgs = [[Image.open(os.path.join(shots, f"subtle-{st}-{c}.png")).convert("RGB") for c, _ in cols] for st in rows]
    scale = 0.6
    w, h = int(imgs[0][0].width * scale), int(imgs[0][0].height * scale)
    gap, label_h, pad = 14, 40, 24
    W = pad * 2 + 3 * w + 2 * gap
    H = pad * 2 + label_h + len(rows) * h + (len(rows) - 1) * gap
    p = palette("evening")
    img = Image.new("RGB", (W, H), rgb(p["crust"]))
    d = ImageDraw.Draw(img)
    f = font("Regular", 17)
    for i, (_, label) in enumerate(cols):
        x = pad + i * (w + gap)
        tw = d.textlength(label, font=f)
        d.text((x + (w - tw) / 2, pad + 6), label, font=f, fill=rgb(p["subtext"]))
    for r, row in enumerate(imgs):
        for i, im in enumerate(row):
            tile = rounded(im.resize((w, h), Image.LANCZOS), 10)
            img.paste(tile, (pad + i * (w + gap), pad + label_h + r * (h + gap)), tile)
    img.save(out, optimize=True)
    return True


def export_colors():
    """Computed colors for every style, straight from the plugin."""
    out = subprocess.run(
        ["nvim", "--headless", "-u", "NONE", "-i", "NONE", "-l", "scripts/export_colors.lua"],
        cwd=ROOT, check=True, capture_output=True, text=True,
    ).stdout
    return json.loads(out)


STYLE_NOTES = {
    "morning": "light · bright paper, AA-contrast inks",
    "afternoon": "dark · slate blue mid-tone",
    "evening": "dark · cool navy, warm accents · default",
    "midnight": "dark · near-black, low light",
    "graveyard": "dark · black, for OLED and dark rooms",
}

# (label, accessor, derived?) per section; accessor reads the exported data
SECTIONS = [
    ("BACKGROUNDS", [(k, ("palette", k), False) for k in ["crust", "mantle", "bg", "surface0", "surface1", "surface2", "overlay0"]]),
    ("TEXT", [("comment", ("palette", "comment"), False), ("subtext", ("palette", "subtext"), False), ("fg", ("palette", "fg"), False),
              ("comment 0.5", ("subtle", "0.5"), True), ("comment 0.7", ("subtle", "0.7"), True)]),
    ("COOL · STRUCTURE", [(k, ("palette", k), False) for k in ["purple", "blue", "cyan", "sky", "teal", "lavender"]]),
    ("WARM · DATA", [(k, ("palette", k), False) for k in ["red", "maroon", "orange", "yellow", "green", "pink"]]),
    ("SELECTION & DIFF", [("visual", ("ui", "bg_visual"), True), ("search", ("ui", "bg_search"), True), ("diff add", ("diff", "add"), True),
                          ("diff delete", ("diff", "delete"), True), ("diff change", ("diff", "change"), True), ("diff text", ("diff", "text"), True)]),
]

# (sample text, syn role, italic?) - italics follow the default `styles`
SYNTAX = [
    ("if return fn", "keyword", True), ("fetch_user()", "func", False), ("HashMap", "type", False), ('"hello"', "string", False),
    ("1_024", "number", False), ("ttl_secs", "parameter", False), (".entries", "property", False), ("self", "variable_builtin", False),
    ("@decorator", "attribute", False), ("\\n", "escape", False), ("std::io", "module", False), ("print()", "func_builtin", False),
    ("=> += ==", "operator", False), ("/^\\d+$/", "regex", False), ("<div>", "tag", False), ("-- note", "comment", True),
]


def palette_cards(data, font, out):
    """One card per style, in the spirit of a design-system palette sheet."""
    sw, sh, gx, pad = 112, 56, 16, 40
    card_w = pad * 2 + 7 * sw + 6 * gx
    title_f, sub_f, head_f = font("Bold", 30), font("Regular", 15), font("Bold", 15)
    name_f, hex_f, badge_f = font("Regular", 14), font("Regular", 13), font("Regular", 10)
    # code samples use the no-ligatures cut so `=>` and `==` show literally
    code_f, code_i, role_f = font("Regular", 19, nl=True), font("Italic", 19, nl=True), font("Regular", 12)

    def card(style):
        d_ = data[style]
        pal, light = d_["palette"], d_["background"] == "light"
        get = lambda acc: d_[acc[0]][acc[1]]
        sec_h = 30 + sh + 70
        tile_w = (card_w - pad * 2 - 3 * gx) // 4
        tile_h = 70
        H = pad + 80 + len(SECTIONS) * sec_h + 30 + 4 * tile_h + 3 * 12 + pad
        img = Image.new("RGBA", (card_w, H), (0, 0, 0, 0))
        d = ImageDraw.Draw(img)
        d.rounded_rectangle([0, 0, card_w - 1, H - 1], radius=18, fill=rgb(pal["bg"]), outline=rgb(pal["surface1"]))
        d.text((pad, pad - 4), "kissaten-" + style, font=title_f, fill=rgb(pal["fg"]))
        d.text((pad, pad + 38), STYLE_NOTES[style], font=sub_f, fill=rgb(pal["comment"]))
        y = pad + 80
        for title, items in SECTIONS:
            d.text((pad, y), title, font=head_f, fill=rgb(pal["subtext"]))
            y += 30
            x = pad
            for label, acc, derived in items:
                col = get(acc)
                d.rounded_rectangle([x, y, x + sw, y + sh], radius=9, fill=rgb(col), outline=rgb(pal["surface2"]))
                d.text((x, y + sh + 8), label, font=name_f, fill=rgb(pal["fg"]))
                d.text((x, y + sh + 27), col.upper()[1:], font=hex_f, fill=rgb(pal["comment"]))
                if derived:  # badge beside the hex, which always leaves room
                    bx = x + d.textlength(col[1:], font=hex_f) + 7
                    d.rounded_rectangle([bx, y + sh + 28, bx + 47, y + sh + 43], radius=7, fill=rgb(pal["surface1"]))
                    d.text((bx + 5, y + sh + 29), "derived", font=badge_f, fill=rgb(pal["subtext"]))
                x += sw + gx
            y += sh + 70
        d.text((pad, y), "SYNTAX ROLES", font=head_f, fill=rgb(pal["subtext"]))
        y += 30
        for i, (sample, role, italic) in enumerate(SYNTAX):
            tx = pad + (i % 4) * (tile_w + gx)
            ty = y + (i // 4) * (tile_h + 12)
            d.rounded_rectangle([tx, ty, tx + tile_w, ty + tile_h], radius=9, fill=rgb(pal["surface0"]))
            d.text((tx + 14, ty + 10), sample, font=code_i if italic else code_f, fill=rgb(d_["syn"][role]))
            d.text((tx + 14, ty + 44), role, font=role_f, fill=rgb(pal["comment"]))
        return img

    cards = [card(s) for s in STYLES]
    gap = 28
    rows = rows_layout(len(cards), 2)
    cw = cards[0].width
    W = cw * 2 + gap
    heights = [max(cards[i].height for i in row) for row in rows]
    H = sum(heights) + gap * (len(rows) - 1)
    sheet = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    y = 0
    for row, rh in zip(rows, heights):
        x0 = (W - (len(row) * cw + (len(row) - 1) * gap)) // 2
        for ci, i in enumerate(row):
            sheet.paste(cards[i], (x0 + ci * (cw + gap), y), cards[i])
        y += rh + gap
    sheet.save(out, optimize=True)
    return sheet.size


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--shots", required=True)
    ap.add_argument("--out", default=os.path.join(ROOT, "assets"))
    ap.add_argument("--font-dir", default=os.environ.get("KISSATEN_FONT_DIR"),
                    help="folder with JetBrainsMonoNerdFontMono-*.ttf (or set KISSATEN_FONT_DIR)")
    a = ap.parse_args()
    font = fonts(a.font_dir)
    os.makedirs(os.path.join(a.out, "screenshots"), exist_ok=True)
    for name in os.listdir(a.shots):
        if name.endswith(".png") and not name.startswith(("zoom", "error", "test", "subtle-")):
            target = name.replace("style-", "")
            shutil.copy(os.path.join(a.shots, name), os.path.join(a.out, "screenshots", target))
    styles_grid(a.shots, os.path.join(a.out, "styles.png"))
    palette_sheet(font, os.path.join(a.out, "palette.png"))
    size = palette_cards(export_colors(), font, os.path.join(a.out, "palette-cards.png"))
    print(f"palette cards: {size[0]}x{size[1]}")
    social_preview(a.shots, font, os.path.join(a.out, "social-preview.png"))
    if subtle_grid(a.shots, font, os.path.join(a.out, "subtle-comments.png")):
        print("subtle comments comparison written")
    for f in sorted(os.listdir(os.path.join(a.out, "screenshots"))):
        print("screenshot:", f)


if __name__ == "__main__":
    main()
