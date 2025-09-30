set fish_greeting

# Startup starship prompt
starship init fish | source

# Detect OS
set -l OS (uname)

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

