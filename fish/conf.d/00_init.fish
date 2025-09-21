set fish_greeting

# starttup starship prompt
starship init fish | source

# Android SDK setup
set -x ANDROID_HOME $HOME/Android/Sdk
set -x ANDROID_SDK_ROOT $HOME/Android/Sdk

# Add tools to PATH
set -x PATH $ANDROID_HOME/emulator $PATH
set -x PATH $ANDROID_HOME/tools $PATH
set -x PATH $ANDROID_HOME/tools/bin $PATH
set -x PATH $ANDROID_HOME/platform-tools $PATH

status --is-interactive; and begin
    set -l keys github-void-avell id_rsa  # list your key filenames in ~/.ssh
    eval (keychain --eval --quiet --agents ssh $keys)
end



