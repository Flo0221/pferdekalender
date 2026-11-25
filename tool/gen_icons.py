#!/usr/bin/env python3
"""Erzeugt die App-Icons (Hufeisen auf Leder-Braun) für Web/PWA.

Ausgabe: web/icons/*.png, web/favicon.png, web/icons/apple-touch-icon.png.
"""
import pathlib
from PIL import Image, ImageDraw

ROOT = pathlib.Path(__file__).resolve().parent.parent
BROWN = (122, 82, 48, 255)   # Seed-Farbe des App-Themes (#7A5230)
CREAM = (250, 243, 232, 255)


def icon(size: int, maskable: bool) -> Image.Image:
    s = size * 4  # supersampling für glatte Kanten
    img = Image.new("RGBA", (s, s), BROWN if maskable else (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    if not maskable:
        r = s * 0.22
        d.rounded_rectangle([0, 0, s - 1, s - 1], radius=r, fill=BROWN)
    # Sicherer Bereich: maskable 80 %, sonst 90 %.
    scale = 0.58 if maskable else 0.68
    w = s * scale
    cx, cy = s / 2, s * 0.52
    thick = w * 0.20
    box = [cx - w / 2, cy - w / 2, cx + w / 2, cy + w / 2]
    # Hufeisen = dicker Bogen (offen nach unten) + zwei gerade Schenkel.
    d.arc(box, start=180, end=360, fill=CREAM, width=int(thick))
    leg_top = cy
    leg_bottom = cy + w * 0.42
    for x0 in (box[0], box[2] - thick):
        d.rectangle([x0, leg_top, x0 + thick, leg_bottom], fill=CREAM)
    # Nagellöcher.
    hole = thick * 0.28
    for ang in (205, 240, 300, 335):
        import math
        rr = w / 2 - thick / 2
        x = cx + rr * math.cos(math.radians(ang))
        y = cy + rr * math.sin(math.radians(ang))
        d.ellipse([x - hole, y - hole, x + hole, y + hole], fill=BROWN)
    return img.resize((size, size), Image.LANCZOS)


out = ROOT / "web" / "icons"
out.mkdir(parents=True, exist_ok=True)
for size in (192, 512):
    icon(size, False).save(out / f"Icon-{size}.png")
    icon(size, True).save(out / f"Icon-maskable-{size}.png")
# iOS: ohne Transparenz, iOS rundet selbst ab.
icon(180, True).convert("RGB").save(out / "apple-touch-icon.png")
icon(32, False).save(ROOT / "web" / "favicon.png")
print("Icons erzeugt in", out)
