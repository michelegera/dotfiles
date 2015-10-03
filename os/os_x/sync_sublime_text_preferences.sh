#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  # Check if Sublime Text is installed

  if ! brew cask list sublime-text3 &> /dev/null; then
    print_error 'Sublime Text 3 is required, please install it!\n'
    exit 1
  fi

  local PACKAGE_CONTROL_FILE=Package%20Control.sublime-package
  local PACKAGES=$HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages
  local INSTALLED_PACKAGES=$HOME/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages

  mkdir -p "$PACKAGES"
  mkdir -p "$INSTALLED_PACKAGES"

  curl -LsS "https://packagecontrol.io/$PACKAGE_CONTROL_FILE" > "$INSTALLED_PACKAGES/$(echo $PACKAGE_CONTROL_FILE | sed 's/%20/\ /g')"
  ln -s $HOME/.sublime-text3 "$PACKAGES/User"

  print_result $? 'Sync Sublime Text 3 preferences'

}

main
