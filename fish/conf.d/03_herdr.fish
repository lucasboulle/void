# Auto-launch/attach herdr in Ghostty and Alacritty.
# Other terminals keep their existing behavior (see 03_tmux.fish).

status is-interactive; or return

# Only take over Ghostty and Alacritty.
set -q GHOSTTY_RESOURCES_DIR; or test "$TERM_PROGRAM" = "ghostty"; or set -q ALACRITTY_WINDOW_ID; or return

# Opt-outs
if set -q NO_HERDR_START; or test "$TERM" = "dumb"
    return
end

# Skip on SSH unless explicitly allowed
if set -q SSH_TTY; and not set -q HERDR_START_ON_SSH
    return
end

# Don't nest: bail if already inside a herdr pane
test "$HERDR_ENV" = "1"; and return
set -q TMUX; and return

# Require herdr
type -q herdr; or return

# Launch or attach to the persistent herdr session.
# herdr handles server spawn + attach-or-create by itself.
# When you detach it exits 0 and we drop to a normal shell.
herdr; and return

# herdr failed to start — keep a normal shell (no tmux fallback).
