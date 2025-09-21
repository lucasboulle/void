# Safe auto-attach/create tmux for interactive Fish shells (portable redirs)

status is-interactive; or return

# Opt-outs / environments where tmux is annoying
if set -q NO_TMUX_START \
    or test "$TERM_PROGRAM" = "vscode" \
    or set -q VSCODE_PID \
    or set -q VSCODE_CWD \
    or test "$TERM" = "dumb" \
    or set -q VSCODE_INJECTION
    return
end

# Skip on SSH unless explicitly allowed
if set -q SSH_TTY; and not set -q TMUX_START_ON_SSH
    return
end

# Don't nest
set -q TMUX; and return

# Require tmux
type -q tmux; or return

# Portable short hostname (avoid hostname -s and avoid ^ redirection)
set -l __host (command hostname 2>/dev/null)
if test -z "$__host"
    set -l __host (uname -n 2>/dev/null)
end
set -l __host_short (string split -m1 -f1 '.' -- "$__host")

# Helper: does any tmux server exist?
function __tmux_server_running --description 'Return 0 if tmux server exists'
    tmux ls >/dev/null 2>/dev/null
end

# 1) Attach to most recently used session if any exists
if __tmux_server_running
    set -l last (
        tmux ls -F '#{session_last_attached} #{session_name}' 2>/dev/null |
        sort -nr |
        head -n1 |
        awk '{print $2}'
    )
    if test -n "$last"
        tmux attach -t "$last" >/dev/null 2>/dev/null; and return
    end
end

# 2) No sessions exist? Create new session called "delta"
tmux new -s "delta" >/dev/null 2>/dev/null; and return

# If we get here, tmux failed — keep normal shell.
