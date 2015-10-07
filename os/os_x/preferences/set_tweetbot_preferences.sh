#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_tweetbot_preferences() {

  execute 'defaults write com.tapbots.TweetbotMac openURLInBackground -int 1' \
    'Open URLs in background'

  execute 'defaults write com.tapbots.TweetbotMac showStatusItem -int 0' \
    'Hide menu bar icon'

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  print_in_purple '\n  Tweetbot\n\n'
  set_tweetbot_preferences

  killall 'Tweetbot' &> /dev/null

}

main
