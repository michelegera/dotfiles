# Aliases

# General

alias cat="bat"
alias ll="ls -lAh"
alias ls="gls --color"
alias ping="prettyping --nolegend"
alias top="htop"
alias v="nvim"

# Brew

alias bcin="brew cask install"
alias bcl="brew cleanup"
alias bcls="brew list --cask"
alias bcrm="brew cask uninstall"
alias bcup="brew upgrade --cask"
alias bdr="brew doctor"
alias bin="brew install"
alias binf="brew info"
alias bls="brew list --formula"
alias bout="brew outdated"
alias brm="brew uninstall"
alias bsr="brew search"
alias bup="brew upgrade"

# Bundler

alias be="bundle exec"
alias bi="bundle install"
alias bl="bundle list"
alias bp="bundle package"
alias bu="bundle update"

# macOS

alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Rails

alias r="rails"
alias rc="rails c"
alias rdbm="rails db:migrate"
alias rs="rails s"

# Yarn

alias ya="yarn"
alias yaa="yarn add"
alias yaad="yarn add --dev"
alias yaga="yarn global add"
alias yagrm="yarn global remove"
alias yai="yarn init"
alias yarm="yarn remove"
alias yaru="yarn run"
alias yat="yarn test"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Use English for command line tools

set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x LANGUAGE en_US.UTF-8

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Don’t check mail when opening terminal

set -e MAILCHECK

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Use Neovim as the preferred editor

set -x EDITOR nvim
set -x VISUAL nvim
set -x VIMCONFIG ~/.config/nvim
set -x VIMDATA ~/.local/share/nvim

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Include Homebrew’s executables path

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set up dircolors

eval (gdircolors -c $HOME/.dircolors)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source prompt

starship init fish | source

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source local config

source $HOME/.fishconfig.local
