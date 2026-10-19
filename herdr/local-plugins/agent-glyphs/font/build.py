"""Gera AntigravityGlyph.ttf: uma fonte com só o logo do Antigravity em U+E400.

Uso: python build.py agy.svg AntigravityGlyph.ttf   (precisa de fonttools)
agy.svg vem do potrace sobre o PNG do logo. O Ghostty usa a fonte via
`font-codepoint-map = U+E400=Antigravity Glyph`.
"""
import re, sys
from fontTools.ttLib import TTFont
from fontTools.fontBuilder import FontBuilder
from fontTools.pens.ttGlyphPen import TTGlyphPen
from fontTools.pens.cu2quPen import Cu2QuPen
from fontTools.pens.transformPen import TransformPen
from fontTools.pens.boundsPen import BoundsPen
from fontTools.svgLib.path import parse_path

CP = 0xE400  # PUA livre na Nerd Font 3.5.1 e em todas as fontes do sistema (U+E1A0 cai num lambda da STIX)
svg, out = sys.argv[1], sys.argv[2]
d = re.search(r'<path d="([^"]+)"', open(svg).read()).group(1)

nf = TTFont("/Users/boulle/Library/Fonts/FiraCodeNerdFontMono-Regular.ttf").getBestCmap()
assert CP not in nf, "codepoint já usado pela Nerd Font"

bp = BoundsPen(None); parse_path(d, bp)
x0, y0, x1, y1 = bp.bounds
ADV, W = 600, 540          # célula monoespaçada (UPM 1000, como JetBrains Mono)
s = W / (x1 - x0)
dx = (ADV - W) / 2 - x0 * s
dy = 290 - (y0 + y1) / 2 * s   # centraliza perto da linha média do texto

pen = TTGlyphPen(None)
parse_path(d, TransformPen(Cu2QuPen(pen, 1.0, reverse_direction=True), (s, 0, 0, s, dx, dy)))
glyph = pen.glyph()

fb = FontBuilder(1000, isTTF=True)
fb.setupGlyphOrder([".notdef", "space", "antigravity"])
fb.setupCharacterMap({0x20: "space", CP: "antigravity"})
fb.setupGlyf({".notdef": TTGlyphPen(None).glyph(), "space": TTGlyphPen(None).glyph(), "antigravity": glyph})
fb.setupHorizontalMetrics({n: (ADV, fb.font["glyf"][n].xMin if n == "antigravity" else 0)
                           for n in (".notdef", "space", "antigravity")})
fb.setupHorizontalHeader(ascent=800, descent=-200)
fb.setupNameTable({"familyName": "Antigravity Glyph", "styleName": "Regular",
                   "psName": "AntigravityGlyph-Regular", "fullName": "Antigravity Glyph Regular"})
fb.setupOS2(sTypoAscender=800, sTypoDescender=-200, usWinAscent=800, usWinDescent=200,
            xAvgCharWidth=ADV, fsSelection=0x40, usWeightClass=400)
fb.font["OS/2"].panose.bFamilyType = 2
fb.font["OS/2"].panose.bProportion = 9  # monospaced
fb.setupPost(isFixedPitch=1)
fb.save(out)
print("ok", out)
