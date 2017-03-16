#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_transmission_preferences() {

  execute 'defaults write org.m0k.transmission DeleteOriginalTorrent -bool true' \
    'Delete the original torrent files'

  execute 'defaults write org.m0k.transmission DownloadAsk -bool false &&
           defaults write org.m0k.transmission MagnetOpenAsk -bool false' \
    'Don’t prompt for confirmation before downloading'

  # Source: https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/
  execute 'defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"' \
    'Use a blocklist'

  execute 'defaults write org.m0k.transmission BlocklistAutoUpdate -bool true' \
    'Auto-update blocklist'

  execute 'defaults write org.m0k.transmission RandomPort -bool true' \
    'Randomize port on launch'

  execute 'defaults write org.m0k.transmission CheckRemoveDownloading -bool true' \
    'Don’t prompt for confirmation before removing non-downloading active transfers'

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
