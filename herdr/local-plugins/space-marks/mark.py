"""Prefixa com um símbolo aleatório todo space que ainda não tem um.

A cor de cada símbolo está nas regras `starts_with` do config.toml do herdr;
este script só escolhe o símbolo, preferindo os que nenhum space usa ainda.
Idempotente: spaces já marcados ficam como estão.
"""
import json, os, random, subprocess

# Mesma ordem e símbolos das regras em ~/.config/herdr/config.toml
GLYPHS = "◆■▲★♠✶✦◢▼✚◈♣◩✿❖✧"  # máx. 16: limite de regras por token do herdr

herdr = os.environ.get("HERDR_BIN_PATH", "herdr")
out = subprocess.run([herdr, "workspace", "list"], capture_output=True, text=True, check=True)
spaces = json.loads(out.stdout)["result"]["workspaces"]

def mark(label):
    return label[0] if len(label) > 1 and label[0] in GLYPHS and label[1] == " " else None

used = {mark(w["label"]) for w in spaces} - {None}
for w in spaces:
    if mark(w["label"]):
        continue
    free = [g for g in GLYPHS if g not in used] or list(GLYPHS)
    glyph = random.choice(free)
    used.add(glyph)
    subprocess.run([herdr, "workspace", "rename", w["workspace_id"], f"{glyph} {w['label']}"],
                   capture_output=True, check=False)
