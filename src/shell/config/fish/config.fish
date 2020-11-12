# Aliases

# General

alias cat="bat"
alias ll="ls -lAh"
alias ls="gls --color"
alias ping="prettyping --nolegend"
alias top="htop"
alias v="nvim"

# Brew

alias brcl="brew cleanup"
alias brd="brew doctor"
alias brin="brew install"
alias brinf="brew info"
alias brls="brew list"
alias brout="brew outdated"
alias brs="brew search"
alias brun="brew uninstall"
alias brup="brew upgrade"

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

# Tmux

alias txa="tmux a -t"
alias txl="tmux ls"
alias txn="tmux new -s"

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

# Configure gpg-agent

gpgconf --launch gpg-agent
set -x SSH_AUTH_SOCKET $HOME/.gnupg/S.gpg-agent.ssh
set -x GPG_TTY (tty)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Include Homebrew’s executables path

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Link Rubies to Homebrew’s OpenSSL, since ruby-build installs a non-Homebrew
# OpenSSL for each Ruby version installed and these are never upgraded.

set -x RUBY_CONFIGURE_OPTS --with-openssl-dir=(brew --prefix openssl)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set up dircolors

eval (gdircolors -c $HOME/.dircolors)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Load fzf auto-completion (using fd, as suggested by its author) and key
# bindings, set Ayu Mirage colors

set -x FZF_DEFAULT_COMMAND fd --type f --hidden --follow
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -xa FZF_DEFAULT_OPTS "
--color=fg:#707a8c,bg:#1f2430,hl:#cbccc6
--color=fg+:#cbccc6,bg+:#191e2a,hl+:#ffcc66
--color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6
--color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Alias `python` to Homebrew’s Python, `python2` to macOS’s

alias pip="/usr/local/bin/pip3"
alias python="/usr/local/bin/python3"
alias python2="/usr/bin/python"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source prompt

starship init fish | source

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source local config

source $HOME/.fishconfig.local
