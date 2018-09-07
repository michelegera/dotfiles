#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -a BASH_IT_ALIASES=(

  'git'
  'rails'

)

declare -a BASH_IT_PLUGINS=(

  'alias-completion'
  'fasd'
  'rvm'

)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Clone the Bash-it repo...
  execute 'git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it &> /dev/null' \
    'Clone latest Bash-it'

  # ...and install it
  execute 'bash ~/.bash_it/install.sh --no-modify-config --silent' 'Install Bash-it'

  # Source Bash configuration
  source ~/.bash_profile

  # Enable aliases
  for i in ${BASH_IT_ALIASES[@]}; do

    execute "bash-it enable alias $i" "Enable $i aliases"

  done

  # Enable plugins
  for i in ${BASH_IT_PLUGINS[@]}; do

    execute "bash-it enable plugin $i" "Enable $i plugin"

  done

  print_result $? 'Install Bash-it and plugins'

}

main
