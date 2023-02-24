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

# Use LunarVim as the preferred editor

set -x EDITOR lvim
set -x VISUAL lvim

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Configure gpg-agent

gpgconf --launch gpg-agent
set -x SSH_AUTH_SOCKET $HOME/.gnupg/S.gpg-agent.ssh
set -x GPG_TTY (tty)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Homebrew’s executables path

set -x PATH /usr/local/sbin $PATH

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Link Rubies to Homebrew’s OpenSSL, since ruby-build installs a non-Homebrew
# OpenSSL for each Ruby version installed and these are never upgraded.

set -x RUBY_CONFIGURE_OPTS --with-openssl-dir=/usr/local/opt/openssl@1.1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set up dircolors

eval (gdircolors -c $HOME/.dircolors)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Load fzf auto-completion (with fd as suggested by its author) and key bindings

set -x FZF_DEFAULT_COMMAND fd --type f --hidden --follow
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

# Set Catppuccin theme for fzf

set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source aliases

source $HOME/.config/fish/aliases.fish

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source zoxide

zoxide init fish | source

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source prompt

starship init fish | source

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source direnv (should come before rtx)

direnv hook fish | source

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source rtx

/usr/local/bin/rtx activate fish | source

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set path for binstubs (https://wolfgangrittner.dev/bundle-exec-be-gone/)

set -x PATH ./bin $PATH

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Add LunarVim to path
set -x PATH $HOME/.local/bin $PATH

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set Java options

set -x JAVA_OPTS "-XX:+UseG1GC -Xms1024m  -Xmx1024m"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set Java options for Elasticsearch

set -x ES_JAVA_HOME $JAVA_HOME
set -x ES_JAVA_OPTS $JAVA_OPTS

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source local config

source $HOME/.fishconfig.local
