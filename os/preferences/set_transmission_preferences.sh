#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_transmission_preferences() {

  execute 'defaults write org.m0k.transmission DeleteOriginalTorrent -bool true' \
    'Delete the original torrent files'

  execute 'defaults write org.m0k.transmission DownloadAsk -bool false' \
    'Don’t prompt for confirmation before downloading'

  execute 'defaults write org.m0k.transmission WarningDonate -bool false' \
    'Hide the donate message'

  execute 'defaults write org.m0k.transmission WarningLegal -bool false' \
    'Hide the legal disclaimer'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  print_in_purple '\n  Transmission\n\n'
  set_transmission_preferences

  killall 'Transmission' &> /dev/null

}

main
