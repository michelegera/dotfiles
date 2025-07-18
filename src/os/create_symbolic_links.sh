#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_symlinks() {

    declare -a FILES_TO_SYMLINK=(

        "git/gitaliases"
        "git/gitattributes"
        "git/gitconfig"
        "git/gitignore"

        "prefs/duti"
        "prefs/gnupg"
        "prefs/vscode"

        "shell/bundle"
        "shell/config"
        "shell/curlrc"
        "shell/dircolors"
        "shell/fdignore"
        "shell/gemrc"
        "shell/hushlogin"
        "shell/inputrc"
        "shell/irbrc"
        "shell/rgignore"
        "shell/screenrc"
        "shell/scripts"
        "shell/ssh"
        "shell/tmux.conf"

    )

    local i=""
    local sourceFile=""
    local targetFile=""
    local skipQuestions=false

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    skip_questions "$@" \
        && skipQuestions=true

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for i in "${FILES_TO_SYMLINK[@]}"; do

        sourceFile="$(cd .. && pwd)/$i"
        targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

        symlink "$sourceFile" "$targetFile" $skipQuestions

    done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n • Create symbolic links\n\n"

    create_symlinks "$@"

}

main "$@"
