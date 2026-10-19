# Auto-launch/attach herdr — ghostty ONLY.
# Every other terminal (alacritty, etc.) keeps using tmux (see 03_tmux.fish).

status is-interactive; or return

# Only take over ghostty; anywhere else fall through so tmux can run.
set -q GHOSTTY_RESOURCES_DIR; or test "$TERM_PROGRAM" = "ghostty"; or return

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

# Require herdr
type -q herdr; or return

# Launch or attach to the persistent herdr session.
# herdr handles server spawn + attach-or-create by itself.
# When you detach it exits 0 and we drop to a normal shell.
herdr; and return

# herdr failed to start — keep a normal shell (no tmux fallback in ghostty).
