# Suppress greeting

set -g fish_greeting ''

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Use English for command line tools

set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x LANGUAGE en_US.UTF-8

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set XDG base directory

set -x XDG_CONFIG_HOME $HOME/.config

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Don't check mail when opening terminal

set -e MAILCHECK

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Use Neovim as the preferred editor

set -x EDITOR nvim
set -x VISUAL nvim

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Configure gpg-agent for commit signing.

# SSH authentication is handled entirely by the 1Password agent
# (see ~/.ssh/config), so gpg-agent's SSH support is intentionally unused.

# Only launch the agent if its socket isn't already present — avoids spawning
# a process on every new shell.
if not test -S $HOME/.gnupg/S.gpg-agent
    gpgconf --launch gpg-agent
end

set -gx GPG_TTY (tty)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Resolve the Homebrew prefix portably: `brew` may already be on the path,
# otherwise fall back to the Apple Silicon or Intel default location.

set -l brew_prefix

if command -q brew
    set brew_prefix (brew --prefix)
else if test -d /opt/homebrew/bin
    set brew_prefix /opt/homebrew
else if test -d /usr/local/bin
    set brew_prefix /usr/local
end

# Set executables paths, in order

if set -q brew_prefix
    fish_add_path -Pm $brew_prefix/bin
    fish_add_path -Pm $brew_prefix/sbin
end
fish_add_path -Pm /usr/local/sbin
fish_add_path -Pm $HOME/.local/bin
fish_add_path -Pm $HOME/.docker/bin

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Link Rubies to Homebrew’s OpenSSL, since ruby-build installs a non-Homebrew
# OpenSSL for each Ruby version installed and these are never upgraded.
#
# `brew --prefix openssl` follows Homebrew’s current formula alias (e.g.
# `openssl@4` today), so this keeps working when the versioned formula changes.

if command -q brew
    set -l openssl_prefix (brew --prefix openssl 2>/dev/null)

    if test -d $openssl_prefix
        set -x RUBY_CONFIGURE_OPTS --with-openssl-dir=$openssl_prefix
    end
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Load fzf auto-completion (with fd as suggested by its author) and key bindings

set -x FZF_DEFAULT_COMMAND fd --type f --hidden --follow
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

# Ink Meridian theme
set -gx FZF_DEFAULT_OPTS "\
--color=fg:#CCD6EA,list-fg:#CCD6EA,selected-fg:#E6ECF7,preview-fg:#CCD6EA \
--color=bg:#101623,list-bg:#101623,selected-bg:#26365A,preview-bg:#1A2233 \
--color=input-bg:#101623,header-bg:#101623,footer-bg:#101623 \
--color=hl:#83A8F2,selected-hl:#8DB0F2,current-fg:#E6ECF7,current-bg:#26365A \
--color=current-hl:#83A8F2,border:#26365A,list-border:#26365A,preview-border:#26365A \
--color=input-border:#26365A,header-border:#26365A,footer-border:#26365A \
--color=label:#AAB8D0,list-label:#AAB8D0,preview-label:#AAB8D0,input-label:#AAB8D0 \
--color=header-label:#8DB0F2,footer-label:#AAB8D0,prompt:#83A8F2,pointer:#8DB0F2 \
--color=marker:#A687E0,spinner:#67B7CF,info:#58657F,header:#8DB0F2,query:#E6ECF7 \
--color=disabled:#58657F,separator:#26365A,scrollbar:#26365A,gutter:#101623"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set eza theme directory

set -x EZA_CONFIG_DIR $HOME/.config/eza

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set lazygit configuration file

set -x LG_CONFIG_FILE $HOME/.config/lazygit/config.yml

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Disable Homebrew hints

set -x HOMEBREW_NO_ENV_HINTS 1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Enable Oh My Opencode Slim background subagents

set -gx OPENCODE_EXPERIMENTAL_BACKGROUND_SUBAGENTS true
set -gx OPENCODE_ENABLE_EXA 1

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

# Source local config

source $HOME/.fishconfig.local
