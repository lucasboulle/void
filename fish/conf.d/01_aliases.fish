
# ----- General Utilities -----
alias l='ls -la'
alias c='clear'

# ----- Neovim -----
alias v='nvim'
alias vi='nvim'
alias vim='nvim'   # force old vim habits into nvim
alias vf='nvim ~/.config/fish'

# Quick open configs
alias vimrc='nvim ~/.config/nvim/init.lua'
alias fishrc='nvim ~/.config/fish/config.fish'
alias alrc='nvim ~/.config/fish/conf.d/aliases.fish'

# Open current folder in Neovim tree
alias v.='nvim .'

# Neovim + specific file types
alias vn='nvim -c ":enew"'         # open new empty buffer
alias vq='nvim -q'                 # open quickfix file
alias vdiff='nvim -d'              # diff mode

# ----- Git -----
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'