# Aliases

alias cat="bat"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias ll="ls -lAh"
alias ls="gls --color"
alias v="nvim"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Configure MariaDB

set PATH /usr/local/opt/mariadb/bin $PATH

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set up dircolors

eval (gdircolors -c $HOME/.dircolors)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source prompt

starship init fish | source

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source local config

source $HOME/.fishconfig.local
