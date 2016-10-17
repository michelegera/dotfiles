#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  ./install_xcode.sh
  print_in_green '\n  ---\n\n'

  ./install_homebrew.sh
  print_in_green '\n  ---\n\n'

  ./install_homebrew_formulae.sh
  print_in_green '\n  ---\n\n'

  ./start_homebrew_services.sh
  print_in_green '\n  ---\n\n'

  ./install_homebrew_casks.sh
  print_in_green '\n  ---\n\n'

  ./install_homebrew_alternate_casks.sh
  print_in_green '\n  ---\n\n'

  ./install_homebrew_custom_casks.sh
  print_in_green '\n  ---\n\n'

  ./install_mas_apps.sh
  print_in_green '\n  ---\n\n'

  ask_for_confirmation 'Do you want to install system duplicate formulae?'
  printf '\n'

  if answer_is_yes; then
    ./install_homebrew_dupes.sh
    print_in_green '\n  ---\n\n'
  fi

  ./install_homebrew_fonts.sh
  print_in_green '\n  ---\n\n'

  ./install_apm_packages.sh
  print_in_green '\n  ---\n\n'

  ./install_fisherman.sh
  print_in_green '\n  ---\n\n'

  ./install_ruby.sh
  print_in_green '\n  ---\n\n'

  ./update_and_upgrade.sh
  print_in_green '\n  ---\n\n'

  ./cleanup.sh

}

main
