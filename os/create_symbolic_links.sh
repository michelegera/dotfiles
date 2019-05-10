#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" \
  && source 'utils.sh'

declare -a FILES_TO_SYMLINK=(

  'shell/bash_profile'
  'shell/bundle'
  'shell/config'
  'shell/curlrc'
  'shell/dircolors'
  'shell/gemrc'
  'shell/git-completion.bash'
  'shell/git-prompt-colors.bash'
  'shell/hushlogin'
  'shell/inputrc'
  'shell/irbrc'
  'shell/rgignore'
  'shell/rvmrc'
  'shell/screenrc'
  'shell/sensible.bash'
  'shell/ssh'
  'shell/tigrc'
  'shell/tmux.conf'
  'shell/vimrc'

  'git/gitattributes'
  'git/gitconfig'
  'git/gitignore'

  'prefs/alfred'
  'prefs/duti'
  'prefs/gnupg'
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

        rm -rf "$targetFile"
        execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"

      else
        print_success "$targetFile → $sourceFile"
      fi
    else
      execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
    fi

  done

}

main
