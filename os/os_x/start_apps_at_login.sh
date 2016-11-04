#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh'

declare -a APPS_TO_START=(

  /Applications/Alfred\ 3.app
  /Applications/Dropbox.app
  /Applications/Google\ Drive.app
  /Applications/Spectacle.app

)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  for appPath in "${APPS_TO_START[@]}"; do
    appName="$(printf "%s" "$appPath" | sed "s/.*\/\(.*\)\.app/\1/" | sed "s/\\\//")"
    #                                    │                             └─ removes backslashes
    #                                    └─ grabs the name of the app
    osascript -e "tell application \"System Events\" to make login item at end with properties \
     {name: \"$appName\", path: \"$appPath\", hidden: false}" &> /dev/null

  done

  print_result $? 'Start applications at login'

}

main