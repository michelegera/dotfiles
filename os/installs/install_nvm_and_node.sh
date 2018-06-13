#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Install nvm
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash &> /dev/null

  # Source zsh configuration to load nvm
  source ~/.zshrc

  # Install latest Node.js (required by heroku, yarn)
  nvm install node &> /dev/null

  # Always default to the latest available Node.js version
  nvm alias default node &> /dev/null

  print_result $? 'Install nvm and latest Node.js'

}

main
