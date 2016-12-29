#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_maps_preferences() {

execute 'defaults write com.apple.Maps LastClosedWindowViewOptions "{
           localizeLabels = 1;   // show labels in English
           trafficEnabled = 1;   // show traffic
         }"' \
  'Set view options'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  print_in_purple '\n  Maps\n\n'
  set_maps_preferences

  killall 'Maps' &> /dev/null

}

main
