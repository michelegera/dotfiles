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
set -x VIMCONFIG $HOME/.config/nvim
set -x VIMDATA $HOME/.local/share/nvim

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

# Source fzf color scheme
source $HOME/.config/fish/fzf/base16-material-palenight.fish

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source zoxide

zoxide init fish | source

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source prompt

starship init fish | source

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source direnv

direnv hook fish | source

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source asdf version manager

source /usr/local/opt/asdf/asdf.fish

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set path for binstubs (https://wolfgangrittner.dev/bundle-exec-be-gone/)
set PATH ./bin $PATH

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set JAVA_HOME
source $HOME/.asdf/plugins/java/set-java-home.fish

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set Java options
set -x JAVA_OPTS "-XX:+UseG1GC -Xms1024m  -Xmx1024m"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Source local config

source $HOME/.fishconfig.local
