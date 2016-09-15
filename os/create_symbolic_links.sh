#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source 'utils.sh'

declare -a FILES_TO_SYMLINK=(

  'shell/config'
  'shell/curlrc'
  'shell/gemrc'
  'shell/hushlogin'
  'shell/inputrc'
  'shell/profile'
  'shell/screenrc'
  'shell/ssh'
  'shell/stylelintrc'
  'shell/tigrc'
  'shell/vimrc'

  'git/gitattributes'
  'git/gitconfig'
  'git/gitignore'

  'prefs/atom'
  'prefs/duti'
  'prefs/iterm2'

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
