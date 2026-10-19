"""Reporta o token `$cli` (glifo do CLI de agente) em cada pane com agente.

O herdr não tem token de texto literal, então o glifo chega ao sidebar como
metadata de pane. A cor de cada glifo está nas regras `equals` do token `$cli`
no config.toml do herdr. Idempotente: reaplica em todos os agentes a cada run.
"""
import json, os, subprocess

# id canônico do agente no herdr -> glifo (mesmos glifos das regras do config.toml)
# Logos de marca da Nerd Font (PUA, por isso em escape); precisa de fonte Nerd Font >= 3.4
GLYPHS = {
    "claude": "",       # cod-claude
    "codex": "",        # cod-openai
    "agy": "",         # logo do Antigravity, fonte própria em font/ (Ghostty font-codepoint-map)
    "openclaw": "\U0001f99e", # 🦞 mascote/logo do OpenClaw; só aparece se algo reportar o agente como "openclaw"
}

herdr = os.environ.get("HERDR_BIN_PATH", "herdr")
out = subprocess.run([herdr, "agent", "list"], capture_output=True, text=True, check=True)
agents = json.loads(out.stdout)["result"]["agents"]

for a in agents:
    glyph = GLYPHS.get(a.get("agent", ""))
    patch = ["--token", f"cli={glyph}"] if glyph else ["--clear-token", "cli"]
    subprocess.run([herdr, "pane", "report-metadata", a["pane_id"],
                    "--source", "boulle.agent-glyphs", *patch],
                   capture_output=True, check=False)
