### ---- XBPS (Void Linux) Aliases ----

# Search packages
function xps --wraps 'xbps-query -Rs' --description 'Search package in repos'
    xbps-query -Rs $argv
end

# Install package
function xi --wraps 'sudo xbps-install -S' --description 'Install package'
    sudo xbps-install -S $argv
end

# Remove package
function xr --wraps 'sudo xbps-remove -R' --description 'Remove package with deps'
    sudo xbps-remove -R $argv
end

# Remove package (keep dependencies)
function xrn --wraps 'sudo xbps-remove' --description 'Remove package (no deps)'
    sudo xbps-remove $argv
end

# Upgrade system
function xu --wraps 'sudo xbps-install -Suv' --description 'Update and upgrade system'
    sudo xbps-install -Suv
end

# List installed packages
function xl --wraps 'xbps-query -l' --description 'List installed packages'
    xbps-query -l
end

# Show package info
function xp --wraps 'xbps-query -R' --description 'Show package info'
    xbps-query -R $argv
end

# Show reverse dependencies
function xrev --wraps 'xbps-query -RX' --description 'Show reverse deps'
    xbps-query -RX $argv
end

# Show package info
function xp --wraps 'xbps-query -Qs' --description 'Show package info'
    xbps-query -R $argv
end
