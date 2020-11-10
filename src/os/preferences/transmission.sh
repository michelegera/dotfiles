#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Transmission\n\n"

execute "defaults write org.m0k.transmission DeleteOriginalTorrent -bool true" \
    "Delete the original torrent files"

execute "defaults write org.m0k.transmission DownloadAsk -bool false && \
         defaults write org.m0k.transmission MagnetOpenAsk -bool false" \
    "Don’t prompt for confirmation before downloading"

execute "defaults write org.m0k.transmission CheckRemoveDownloading -bool true" \
    "Don’t prompt for confirmation before removing non-downloading active transfers"

execute "defaults write org.m0k.transmission DownloadChoice -string 'Constant' && \
         defaults write org.m0k.transmission DownloadFolder -string '$HOME/Torrents'" \
    "Use '~/Torrents' to store complete downloads"

execute "defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true && \
         defaults write org.m0k.transmission IncompleteDownloadFolder -string '$HOME/Torrents/Incomplete'" \
    "Use '~/Torrents/Incomplete' to store incomplete downloads"

# Source: https://github.com/Naunter/BT_BlockLists
execute "defaults write org.m0k.transmission BlocklistNew -bool true && \
         defaults write org.m0k.transmission BlocklistURL -string 'https://github.com/Naunter/BT_BlockLists/raw/master/bt_blocklists.gz' && \
         defaults write org.m0k.transmission BlocklistAutoUpdate -bool true" \
    "Use a blocklist"

execute "defaults write org.m0k.transmission WarningDonate -bool false" \
    "Hide the donate message"

execute "defaults write org.m0k.transmission WarningLegal -bool false" \
    "Hide the legal disclaimer"

execute "defaults write org.m0k.transmission AutoSize -bool true" \
    "Automatically size window to fit all transfers"

execute "defaults write org.m0k.transmission RandomPort -bool true" \
    "Randomize port on launch"

killall "Transmission" &> /dev/null
