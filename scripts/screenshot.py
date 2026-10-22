#!/usr/bin/env python3
"""Render real Neovim UI frames to PNG.

Attaches to `nvim --embed` as a UI (ext_linegrid), replays a Lua scenario
that calls `vim.rpcnotify(0, "kissaten_snap", "<name>")` whenever a frame
should be captured, and draws the grid with a Nerd Font. No terminal
emulator or display server needed, so it runs in CI.

usage: screenshot.py --scenario scenario.lua --out DIR [--cols 160 --rows 44]
       [--font-dir DIR] [--size 15] [--frame] -- <extra nvim args>
"""
import argparse
import os
import sys

import pynvim
from PIL import Image, ImageDraw, ImageFont


class Grid:
    def __init__(self):
        self.w = self.h = 0
        self.cells = []
        self.attrs = {0: {}}
        self.fg, self.bg, self.sp = 0xC0CAF5, 0x1A1B26, 0xFF0000
        self.cursor = (0, 0)

    def resize(self, w, h):
        self.w, self.h = w, h
        self.cells = [[[" ", 0] for _ in range(w)] for _ in range(h)]

    def clear(self):
        self.resize(self.w, self.h)

    def line(self, row, col, cells):
        hl = 0
        for cell in cells:
            text = cell[0]
            if len(cell) > 1:
                hl = cell[1]
            rep = cell[2] if len(cell) > 2 else 1
            for _ in range(rep):
                if 0 <= row < self.h and 0 <= col < self.w:
                    self.cells[row][col] = [text, hl]
                col += 1

    def scroll(self, top, bot, left, right, rows):
        if rows > 0:
            for r in range(top, bot - rows):
                self.cells[r][left:right] = [c[:] for c in self.cells[r + rows][left:right]]
        else:
            for r in range(bot - 1, top - rows - 1, -1):
                self.cells[r][left:right] = [c[:] for c in self.cells[r + rows][left:right]]

    def handle(self, name, args):
        if name == "grid_resize":
            self.resize(args[1], args[2])
        elif name == "default_colors_set":
            fg, bg, sp = args[0], args[1], args[2]
            self.fg = fg if fg >= 0 else self.fg
            self.bg = bg if bg >= 0 else self.bg
            self.sp = sp if sp >= 0 else self.sp
        elif name == "hl_attr_define":
            self.attrs[args[0]] = args[1]
        elif name == "grid_line":
            self.line(args[1], args[2], args[3])
        elif name == "grid_clear":
            self.clear()
        elif name == "grid_scroll":
            self.scroll(*args[1:5], args[5])
        elif name == "grid_cursor_goto":
            self.cursor = (args[1], args[2])


# Box-drawing / block glyphs are drawn as geometry so they connect across
# cells regardless of line spacing (as real terminals do).
# segments: (up, down, left, right) with 0 = none, 1 = light, 2 = heavy, 3 = double
BOX = {
    "─": (0, 0, 1, 1), "━": (0, 0, 2, 2), "│": (1, 1, 0, 0), "┃": (2, 2, 0, 0),
    "┌": (0, 1, 0, 1), "┐": (0, 1, 1, 0), "└": (1, 0, 0, 1), "┘": (1, 0, 1, 0),
    "├": (1, 1, 0, 1), "┤": (1, 1, 1, 0), "┬": (0, 1, 1, 1), "┴": (1, 0, 1, 1), "┼": (1, 1, 1, 1),
    "═": (0, 0, 3, 3), "║": (3, 3, 0, 0), "╔": (0, 3, 0, 3), "╗": (0, 3, 3, 0),
    "╚": (3, 0, 0, 3), "╝": (3, 0, 3, 0), "╠": (3, 3, 0, 3), "╣": (3, 3, 3, 0),
    "╭": (0, 1, 0, 1), "╮": (0, 1, 1, 0), "╰": (1, 0, 0, 1), "╯": (1, 0, 1, 0),
    "╴": (0, 0, 1, 0), "╶": (0, 0, 0, 1), "╵": (1, 0, 0, 0), "╷": (0, 1, 0, 0),
}
BLOCKS = {"█": (0, 0, 1, 1), "▀": (0, 0, 1, 0.5), "▄": (0, 0.5, 1, 1), "▌": (0, 0, 0.5, 1), "▐": (0.5, 0, 1, 1)}


def draw_box(d, ch, x, y, w, h, color):
    if ch in BLOCKS:
        x0, y0, x1, y1 = BLOCKS[ch]
        d.rectangle([x + x0 * w, y + y0 * h, x + x1 * w - 1, y + y1 * h - 1], fill=color)
        return True
    seg = BOX.get(ch)
    if not seg:
        return False
    up, down, left, right = seg
    cx, cy = x + w // 2, y + h // 2
    t = max(1, w // 9)

    def vline(kind, y0, y1):
        if kind == 3:
            for off in (-t - 1, t + 1):
                d.rectangle([cx + off - t // 2, y0, cx + off + (t - 1) // 2, y1], fill=color)
        elif kind:
            k = t * (2 if kind == 2 else 1)
            d.rectangle([cx - k // 2, y0, cx + (k - 1) // 2, y1], fill=color)

    def hline(kind, x0, x1):
        if kind == 3:
            for off in (-t - 1, t + 1):
                d.rectangle([x0, cy + off - t // 2, x1, cy + off + (t - 1) // 2], fill=color)
        elif kind:
            k = t * (2 if kind == 2 else 1)
            d.rectangle([x0, cy - k // 2, x1, cy + (k - 1) // 2], fill=color)

    dbl = 3 in seg
    reach = t + 1 if dbl else 0
    vline(up, y, cy + (reach if (left or right) else 0))
    vline(down, cy - (reach if (left or right) else 0), y + h - 1)
    hline(left, x, cx + (reach if (up or down) else 0))
    hline(right, cx - (reach if (up or down) else 0), x + w - 1)
    return True


def hexrgb(n):
    return ((n >> 16) & 255, (n >> 8) & 255, n & 255)


class Renderer:
    def __init__(self, font_dir, size):
        f = lambda name: ImageFont.truetype(os.path.join(font_dir, f"JetBrainsMonoNerdFontMono-{name}.ttf"), size)
        self.fonts = {(False, False): f("Regular"), (True, False): f("Bold"), (False, True): f("Italic"), (True, True): f("BoldItalic")}
        reg = self.fonts[(False, False)]
        self.cw = round(reg.getlength("M"))
        asc, desc = reg.getmetrics()
        self.ch = round((asc + desc) * 1.18)
        self.base = round((self.ch - (asc + desc)) / 2)

    def render(self, grid, path, frame=False, title="", cursor=True):
        W, H = grid.w * self.cw, grid.h * self.ch
        img = Image.new("RGB", (W, H), hexrgb(grid.bg))
        d = ImageDraw.Draw(img)
        for r, row in enumerate(grid.cells):
            y = r * self.ch
            for c, (text, hl) in enumerate(row):
                a = grid.attrs.get(hl, {})
                fg = a.get("foreground", grid.fg)
                bg = a.get("background", grid.bg)
                if a.get("reverse"):
                    fg, bg = bg, fg
                x = c * self.cw
                if bg != grid.bg:
                    d.rectangle([x, y, x + self.cw - 1, y + self.ch - 1], fill=hexrgb(bg))
                if (r, c) == grid.cursor and cursor:
                    d.rectangle([x, y, x + self.cw - 1, y + self.ch - 1], fill=hexrgb(grid.fg))
                    fg = bg
                if text and text != " " and draw_box(d, text, x, y, self.cw, self.ch, hexrgb(fg)):
                    pass
                elif text and text != " ":
                    font = self.fonts[(bool(a.get("bold")), bool(a.get("italic")))]
                    d.text((x, y + self.base), text, font=font, fill=hexrgb(fg))
                sp = a.get("special", fg)
                if a.get("undercurl"):
                    uy = y + self.ch - 3
                    pts = [(x + i, uy + (1 if (i // 2) % 2 else -1)) for i in range(0, self.cw + 1, 1)]
                    d.line(pts, fill=hexrgb(sp), width=1)
                elif a.get("underline"):
                    d.line([(x, y + self.ch - 2), (x + self.cw, y + self.ch - 2)], fill=hexrgb(sp), width=1)
                if a.get("strikethrough"):
                    d.line([(x, y + self.ch // 2), (x + self.cw, y + self.ch // 2)], fill=hexrgb(fg), width=1)
        if frame:
            img = self.framed(img, grid.bg, title)
        img.save(path, optimize=True)
        print("wrote", path)

    def framed(self, inner, bg, title):
        """macOS-style window with a title bar, rounded corners and padding."""
        pad, bar, radius = 40, 34, 12
        W, H = inner.width, inner.height + bar
        outer_bg = (14, 14, 20) if sum(hexrgb(bg)) < 380 else (205, 210, 224)
        out = Image.new("RGB", (W + pad * 2, H + pad * 2), outer_bg)
        win = Image.new("RGB", (W, H), hexrgb(bg))
        r, g, b = hexrgb(bg)
        shade = (max(r - 8, 0), max(g - 8, 0), max(b - 8, 0)) if sum(hexrgb(bg)) < 380 else (max(r - 14, 0), max(g - 14, 0), max(b - 12, 0))
        wd = ImageDraw.Draw(win)
        wd.rectangle([0, 0, W, bar], fill=shade)
        for i, col in enumerate([(255, 95, 87), (254, 188, 46), (40, 200, 64)]):
            cx = 20 + i * 22
            wd.ellipse([cx - 6, bar // 2 - 6, cx + 6, bar // 2 + 6], fill=col)
        if title:
            f = self.fonts[(False, False)]
            tw = f.getlength(title)
            fg = (150, 156, 190) if sum(hexrgb(bg)) < 380 else (90, 96, 130)
            wd.text(((W - tw) / 2, (bar - self.ch) / 2 + self.base), title, font=f, fill=fg)
        win.paste(inner, (0, bar))
        mask = Image.new("L", (W, H), 0)
        ImageDraw.Draw(mask).rounded_rectangle([0, 0, W - 1, H - 1], radius=radius, fill=255)
        out.paste(win, (pad, pad), mask)
        # hairline outline so very dark windows stay distinct from the backdrop
        dark = sum(hexrgb(bg)) < 380
        edge = tuple(min(255, v + 28) for v in hexrgb(bg)) if dark else tuple(max(0, v - 40) for v in hexrgb(bg))
        ImageDraw.Draw(out).rounded_rectangle([pad - 1, pad - 1, pad + W, pad + H], radius=radius + 1, outline=edge, width=1)
        return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--scenario", required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--cols", type=int, default=160)
    ap.add_argument("--rows", type=int, default=44)
    ap.add_argument("--size", type=int, default=15)
    ap.add_argument("--font-dir", default=os.environ.get("KISSATEN_FONT_DIR"),
                    help="folder with JetBrainsMonoNerdFontMono-*.ttf (or set KISSATEN_FONT_DIR)")
    ap.add_argument("--frame", action="store_true")
    ap.add_argument("nvim_args", nargs="*")
    a = ap.parse_args()

    os.makedirs(a.out, exist_ok=True)
    nvim = pynvim.attach("child", argv=["nvim", "--embed", *a.nvim_args])
    grid, renderer = Grid(), Renderer(a.font_dir, a.size)

    def on_notification(name, args):
        if name == "redraw":
            for batch in args:
                ev = batch[0]
                for params in batch[1:]:
                    grid.handle(ev, params)
        elif name == "kissaten_snap":
            snap = args[0]
            opts = args[1] if len(args) > 1 else {}
            renderer.render(grid, os.path.join(a.out, snap + ".png"), frame=opts.get("frame", a.frame),
                            title=opts.get("title", ""), cursor=opts.get("cursor", True))
        elif name == "kissaten_done":
            nvim.stop_loop()

    def setup():
        nvim.ui_attach(a.cols, a.rows, rgb=True, ext_linegrid=True)
        nvim.command("luafile " + os.path.abspath(a.scenario), async_=True)

    nvim.run_loop(None, on_notification, setup)
    try:
        nvim.command("qa!", async_=True)
    except Exception:
        pass


if __name__ == "__main__":
    main()
