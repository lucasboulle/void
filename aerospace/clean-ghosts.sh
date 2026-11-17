#!/bin/bash
# Automatic window manager sanitizer for AeroSpace:
# 1. Cleans up ghost windows left behind by terminated processes.
# 2. Ensures any titleless helper/background window (Mail, Chrome Meet, Activity Monitor, Notes, etc.)
#    is never trapped in a tiling container splitting the user's screen.

/usr/bin/python3 - <<'EOF'
import subprocess, json, os

try:
    out = subprocess.check_output(
        ['aerospace', 'list-windows', '--all', '--json', '--format', '%{window-id} %{app-pid} %{window-layout} %{window-title}'],
        text=True,
        timeout=1.5
    )
    windows = json.loads(out)
    for w in windows:
        wid = w.get('window-id')
        pid = w.get('app-pid')
        title = (w.get('window-title') or '').strip()
        layout = w.get('window-layout', '')

        # Close dead PID windows
        if pid:
            try:
                os.kill(pid, 0)
            except OSError:
                subprocess.run(['aerospace', 'close', '--window-id', str(wid)], check=False, timeout=0.5)
                continue

        # Float any ghost / empty-title window that got stuck in a tiling tree
        if title == '' and layout in ('h_tiles', 'v_tiles', 'tiles'):
            subprocess.run(['aerospace', 'layout', '--window-id', str(wid), 'floating'], check=False, timeout=0.5)
except Exception:
    pass
EOF
