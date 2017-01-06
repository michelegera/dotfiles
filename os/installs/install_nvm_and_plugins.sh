#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # nvm
  bash -c "$(curl -LsS https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh)"

  # Plugins
  if [ -d '~/.oh-my-zsh/' ]; then
    execute 'git clone https://github.com/lukechilds/zsh-nvm \
      ~/.oh-my-zsh/custom/plugins/zsh-nvm'
    execute 'git clone https://github.com/lukechilds/zsh-better-npm-completion \
      ~/.oh-my-zsh/custom/plugins/zsh-better-npm-completion'
  fi

  print_result $? 'Install nvm and plugins'

}

main
