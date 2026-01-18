#~/.config/fish/config.fish

set fish_greeting

# Startup starship prompt
starship init fish | source

# Detect OS
set -l OS (uname)

# --- macOS: ensure uv' (pip --user) in PATH ---
if test "$OS" = "Darwin"
    set -l PY_USER_BIN (python3 -c 'import site; print(site.getuserbase()+"/bin")')
    test -d $PY_USER_BIN; and fish_add_path $PY_USER_BIN

    test -d $HOME/.local/bin; and fish_add_path $HOME/.local/bin
end

if test "$OS" != "Darwin"
    # Linux-only configuration

    # Android SDK setup
    set -x ANDROID_HOME $HOME/Android/Sdk
    set -x ANDROID_SDK_ROOT $HOME/Android/Sdk

    # Add tools to PATH
    set -x PATH $ANDROID_HOME/emulator $PATH
    set -x PATH $ANDROID_HOME/tools $PATH
    set -x PATH $ANDROID_HOME/tools/bin $PATH
    set -x PATH $ANDROID_HOME/platform-tools $PATH

    # Only run keychain in interactive Linux shells
    status --is-interactive; and begin
        set -l keys github-void-avell id_rsa
        eval (keychain --eval --quiet --agents ssh $keys)
    end
end
