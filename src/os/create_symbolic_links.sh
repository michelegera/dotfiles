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

        "shell/alacritty.yml"
        "shell/config"
        "shell/curlrc"
        "shell/dircolors"
        "shell/fdignore"
        "shell/gemrc"
        "shell/hushlogin"
        "shell/inputrc"
        "shell/rgignore"
        "shell/screenrc"
        "shell/ssh"
        "shell/tmux.conf"
        "shell/vimrc"

    )

    local i=""
    local sourceFile=""
    local targetFile=""
    local skipQuestions=false

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    skip_questions "$@" \
        && skipQuestions=true

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for i in "${FILES_TO_SYMLINK[@]}"; do

        sourceFile="$(cd .. && pwd)/$i"
        targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

        symlink $sourceFile $targetFile $skip_questions

    done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n • Create symbolic links\n\n"

    create_symlinks "$@"

}

main "$@"
