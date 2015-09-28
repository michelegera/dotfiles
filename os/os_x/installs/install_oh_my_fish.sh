#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  if ! cmd_exists 'omf'; then

    curl -LsS github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | \
      CI=true sh &> /dev/null
    #   └─ simulate a CI environment, see http://git.io/vnu8b

    fish -c "omf install" &> /dev/null

  fi

  print_result $? 'Install Oh My Fish'

}

main


