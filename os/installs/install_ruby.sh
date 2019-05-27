#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -r -a RUBY_GEMS=(
  'colorls'
  'tmuxinator'
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Install the authors’ public keys, used to verify the installation package
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB &> /dev/null

  # Install `RVM` and latest Ruby
  curl -sSL https://get.rvm.io | bash -s head --ruby &> /dev/null

  # Load RVM
  source ${HOME}/.rvm/scripts/rvm

  # Install gems
  for i in ${RUBY_GEMS[@]}; do
    execute "gem install $i" "$i"
  done

  print_result $? 'Install Ruby version manager, latest Ruby and gems'

}

main
