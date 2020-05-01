#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  ./install_xcode_command_line_tools.sh
  print_in_green '\n  ---\n\n'

  ./install_homebrew.sh
  print_in_green '\n  ---\n\n'

  # Install Java before formulae as it is an elasticsearch requirement
  ./install_homebrew_alternate_casks.sh
  print_in_green '\n  ---\n\n'

  ./install_homebrew_formulae.sh
  print_in_green '\n  ---\n\n'

  ./start_homebrew_services.sh
  print_in_green '\n  ---\n\n'

  ./install_homebrew_casks.sh
  print_in_green '\n  ---\n\n'

  ./install_homebrew_drivers.sh
  print_in_green '\n  ---\n\n'

  ./install_homebrew_fonts.sh
  print_in_green '\n  ---\n\n'

  ./install_packages.sh
  print_in_green '\n  ---\n\n'

  # Temporary commented out, see https://github.com/mas-cli/mas/issues/164
  # ./install_mas_apps.sh
  # print_in_green '\n  ---\n\n'

  ./update_and_upgrade.sh
  print_in_green '\n  ---\n\n'

}

main
