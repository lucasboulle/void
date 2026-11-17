#!/bin/bash
# Called from on-window-detected via exec-and-forget.
# Moves ONLY the detected window ($AEROSPACE_WINDOW_ID) to a workspace and floats it.
# If that window is already gone (short-lived launcher/splash windows), it does nothing,
# instead of letting a plain `move-node-to-workspace` fall back to the focused window.
# Usage: move-detected.sh <workspace> <app-name-regex>
ws="$1"; re="${2#\(?i\)}"; id="$AEROSPACE_WINDOW_ID"
AS=/opt/homebrew/bin/aerospace
log="$HOME/.config/aerospace/move-detected.log"
[ -z "$id" ] && { echo "$(date '+%F %T') no AEROSPACE_WINDOW_ID ($re)" >>"$log"; exit 0; }
app=$("$AS" list-windows --all --format '%{window-id}|%{app-name}' | awk -F'|' -v id="$id" '$1==id {print $2}')
if [ -z "$app" ] || ! printf '%s' "$app" | grep -qiE "$re"; then
  echo "$(date '+%F %T') skip id=$id app='$app' (wanted $re)" >>"$log"; exit 0
fi
"$AS" layout --window-id "$id" floating
"$AS" move-node-to-workspace --window-id "$id" "$ws"
echo "$(date '+%F %T') moved id=$id app='$app' -> $ws" >>"$log"
