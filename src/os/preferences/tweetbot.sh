#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Tweetbot\n\n"

execute "defaults write com.tapbots.TweetbotMac OpenURLsDirectly -bool true" \
    "Skip t.co links"

execute "defaults write com.tapbots.TweetbotMac openURLInBackground -bool true" \
    "Open URLs in background"

execute "defaults write com.tapbots.TweetbotMac showStatusItem -bool false" \
    "Hide menu bar icon"

killall "Tweetbot" &> /dev/null
