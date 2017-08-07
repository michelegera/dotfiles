#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh' \
  && source './utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  if cmd_exists 'rbenv'; then

    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl)"

    # Find the most recent stable MRI version number, see http://stackoverflow.com/a/30183040/246054
    local RUBY_VERSION="$(rbenv install -l | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')"

    rbenv install $RUBY_VERSION &> /dev/null
    rbenv global $RUBY_VERSION &> /dev/null

  fi

  print_result $? "Install Ruby $RUBY_VERSION"

}

main
