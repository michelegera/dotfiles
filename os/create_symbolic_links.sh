#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source 'utils.sh'

declare -a FILES_TO_SYMLINK=(

  'shell/curlrc'
  'shell/inputrc'
  'shell/screenrc'
  'shell/config'
  'shell/ssh'

  'git/gitattributes'
  'git/gitconfig'
  'git/gitignore'

)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

  local i=''
  local sourceFile=''
  local targetFile=''

  for i in ${FILES_TO_SYMLINK[@]}; do

    sourceFile="$(cd .. && pwd)/$i"
    targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

    if [ -e "$targetFile" ]; then
      if [ "$(readlink "$targetFile")" != "$sourceFile" ]; then

        ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
        if answer_is_yes; then
          rm -rf "$targetFile"
          execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
        else
          print_error "$targetFile → $sourceFile"
        fi

      else
        print_success "$targetFile → $sourceFile"
      fi
    else
      execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
    fi

  done

}

main
