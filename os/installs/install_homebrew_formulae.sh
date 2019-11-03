#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Homebrew Formulae
  # https://github.com/Homebrew/homebrew

  if cmd_exists 'brew' \
    && brew_tap 'heroku/brew'; then

    brew_install 'bash-completion' 'bash-completion'
    brew_install 'bash' 'bash'
    brew_install 'bat' 'bat'
    brew_install 'cmake' 'cmake'
    brew_install 'coreutils' 'coreutils'
    brew_install 'diff-so-fancy' 'diff-so-fancy'
    brew_install 'duti' 'duti'
    brew_install 'elasticsearch' 'elasticsearch'
    brew_install 'fd' 'fd'
    brew_install 'git' 'git'
    brew_install 'gnupg' 'gnupg'
    brew_install 'go' 'go'
    brew_install 'heroku' 'heroku/brew/heroku'
    brew_install 'htop' 'htop'
    brew_install 'httpie' 'httpie'
    brew_install 'jq' 'jq'
    brew_install 'jump' 'jump'
    brew_install 'mariadb' 'mariadb@10.1'
    brew_install 'mas' 'mas'
    brew_install 'mkcert' 'mkcert'
    brew_install 'ncdu' 'ncdu'
    brew_install 'neofetch' 'neofetch'
    brew_install 'neovim' 'neovim'
    brew_install 'nss' 'nss'
    brew_install 'pinentry-mac' 'pinentry-mac'
    brew_install 'postgres' 'postgres'
    brew_install 'prettyping' 'prettyping'
    brew_install 'pv' 'pv'
    brew_install 'python' 'python'
    brew_install 'rbenv-gemset' 'rbenv-gemset'
    brew_install 'rbenv' 'rbenv'
    brew_install 'ripgrep' 'ripgrep'
    brew_install 'starship' 'starship'
    brew_install 'tig' 'tig'
    brew_install 'tldr' 'tldr'
    brew_install 'tmux' 'tmux'
    brew_install 'watchman' 'watchman'
    brew_install 'yarn' 'yarn --ignore-dependencies'
    printf '\n'

  fi

}

main
