#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source '../utils.sh'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -a APPS=(
  'Airmail'
  'AppSana'
  'Byword'
  'Characters'
  'Deliveries'
  'Keynote'
  'Reeder'
  'Sip'
  'Tweetbot'
  'VidConvert'
  'Wallcat'
  'XCode'
)

main() {

  local MAS_APPLICATION=/Applications/App\ Store.app

  open "$MAS_APPLICATION" --background &> /dev/null

  print_in_purple 'Please install the following apps:\n'
  for app in ${APPS[@]}; do
    print_in_purple "  * $app\n"
  done
  printf '\n'

  print_result $? 'Install Mac App Store applications'

}

main
