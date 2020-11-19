# Suppress greeting

set -U fish_greeting ''

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

# Homebrew’s executables path

set -ua fish_user_paths /usr/local/sbin

# sbt executables path

set -ua fish_user_paths /usr/local/opt/sbt@0.13/bin

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

# Source prompt

starship init fish | source

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source local config

source $HOME/.fishconfig.local
