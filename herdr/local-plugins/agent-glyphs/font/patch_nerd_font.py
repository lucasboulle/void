"""Injeta o glifo do Antigravity (U+E400) diretamente nas fontes Nerd Font instaladas.

Alacritty no macOS não suporta font-codepoint-map nem listas de fontes de fallback
manuais no alacritty.toml. Como U+E400 está no Private Use Area (PUA), o CoreText
do macOS recusa fallback automático para fontes externas.
A solução definitiva é embutir o glifo diretamente na fonte configurada.
"""
import glob
import os
import re
import sys
import tempfile
from fontTools.ttLib import TTFont
from fontTools.pens.ttGlyphPen import TTGlyphPen
from fontTools.pens.cu2quPen import Cu2QuPen
from fontTools.pens.transformPen import TransformPen
from fontTools.pens.boundsPen import BoundsPen
from fontTools.svgLib.path import parse_path

CP = 0xE400
GLYPH_NAME = "antigravity"

def patch_font(font_path: str, svg_path: str):
    font = TTFont(font_path)
    
    # Parse SVG path
    d = re.search(r'<path d="([^"]+)"', open(svg_path).read()).group(1)
    bp = BoundsPen(None)
    parse_path(d, bp)
    x0, y0, x1, y1 = bp.bounds

    upm = font["head"].unitsPerEm
    adv = font["hmtx"]["space"][0]
    w = int(adv * 0.9)
    s = w / (x1 - x0)
    dx = (adv - w) / 2 - x0 * s

    # Centro vertical proporcional à UPM (ex: 290 em UPM 1000, 600 em UPM 1950)
    midline = upm * 0.3
    dy = midline - (y0 + y1) / 2 * s

    pen = TTGlyphPen(None)
    parse_path(d, TransformPen(Cu2QuPen(pen, 1.0, reverse_direction=True), (s, 0, 0, s, dx, dy)))
    glyph = pen.glyph()

    font["glyf"][GLYPH_NAME] = glyph
    glyph.recalcBounds(font["glyf"])

    order = font.getGlyphOrder()
    if GLYPH_NAME not in order:
        order.append(GLYPH_NAME)
        font.setGlyphOrder(order)

    font["hmtx"][GLYPH_NAME] = (adv, int(glyph.xMin))

    for table in font["cmap"].tables:
        if table.isUnicode():
            table.cmap[CP] = GLYPH_NAME

    font["maxp"].numGlyphs = len(order)

    fd, tmp_path = tempfile.mkstemp(suffix=".ttf")
    os.close(fd)
    font.save(tmp_path)
    os.replace(tmp_path, font_path)
    print(f"Patched: {os.path.basename(font_path)} (bounds: {glyph.xMin}, {glyph.yMin}, {glyph.xMax}, {glyph.yMax})")

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    svg_path = os.path.join(script_dir, "agy.svg")
    
    patterns = [
        "~/Library/Fonts/FiraCodeNerdFont*.ttf",
        "~/Library/Fonts/JetBrainsMonoNerdFont*.ttf",
        "~/Library/Fonts/JetBrainsMonoNLNerdFont*.ttf",
    ]
    fonts = []
    for p in patterns:
        fonts.extend(glob.glob(os.path.expanduser(p)))
    fonts = sorted(set(fonts))

    if not fonts:
        print("Nenhuma fonte encontrada.")
        sys.exit(1)

    print(f"Patching {len(fonts)} fontes...")
    for f in fonts:
        patch_font(f, svg_path)
    print("Concluído com sucesso!")

if __name__ == "__main__":
    main()

