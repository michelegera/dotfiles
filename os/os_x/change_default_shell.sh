#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  local HOMEBREW_PREFIX=''

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Check if `Homebrew` is installed

  if ! cmd_exists 'brew'; then
    print_error 'Homebrew is required, please install it!\n'
    exit 1
  fi

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Check if `Fish` is installed

  if ! brew list fish &> /dev/null; then
    print_error 'Fish is required, please install it!\n'
    exit 1
  fi

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Add the path of Fish shell installed through Homebrew
  # to the list of login shells from the `/etc/shells` file.
  #
  # This needs to be done because applications use this file to
  # determine whether a shell is valid (e.g.: `chsh` consults the
  # `/etc/shells` to determine whether an unprivileged user may
  # change the login shell for her own account).
  #
  # http://www.linuxfromscratch.org/blfs/view/7.4/postlfs/etcshells.html

  HOMEBREW_PREFIX="$(brew --prefix)"

  if [ -z "$(cat /etc/shells | grep "$HOMEBREW_PREFIX")" ]; then
      sudo sh -c "printf \"$HOMEBREW_PREFIX/bin/fish\n\" >> /etc/shells"
      print_result $? "Add \`$HOMEBREW_PREFIX/bin/fish\` in \`/etc/shells\`"
  fi

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Make OS X use the Fish version installed through Homebrew
  # https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/chsh.1.html

  chsh -s "$HOMEBREW_PREFIX/bin/fish" &> /dev/null
  print_result $? 'Use Fish shell'

}

main
