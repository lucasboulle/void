set -gx JAVA_HOME /opt/homebrew/opt/openjdk@11
set -gx PATH /opt/homebrew/opt/openjdk@11/bin $PATH

# OpenClaw Completion
source "/Users/boulle/.openclaw/completions/openclaw.fish"

# Added by git-ai installer on Wed Jul 22 16:36:27 -03 2026
fish_add_path -g "/Users/boulle/.git-ai/bin"

# Hermes Agent — ensure ~/.local/bin is on PATH
fish_add_path "$HOME/.local/bin"

# cubic
fish_add_path "/Users/boulle/.cubic/bin"
