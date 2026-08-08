#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    ssh -T git@github.com &> /dev/null

    if [ $? -ne 1 ]; then
        ./set_github_ssh_key.sh \
            || return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_purple "\n • Update content\n\n"

    ask_for_confirmation "Do you want to update the content from the 'dotfiles' directory?"

    if answer_is_yes; then

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Show a preview of local changes that would be overwritten.

        local localChanges=""
        localChanges="$(git status --short)"

        if [ -n "$localChanges" ]; then
            printf "\n"
            print_warning "The following local changes will be stashed:"
            printf "%s\n" "$localChanges"
            printf "\n"

            ask_for_confirmation "Continue and stash these changes?"

            if ! answer_is_yes; then
                print_info "Update cancelled — local changes preserved."
                return 0
            fi
        fi

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Stash local changes before resetting, so they can be restored later.

        if [ -n "$localChanges" ]; then
            git stash push -m "dotfiles-update-$(date +%s)" 1> /dev/null \
                || print_warning "Failed to stash local changes — they may be lost"
        fi

        git fetch --all 1> /dev/null \
            && git reset --hard origin/main 1> /dev/null \
            && git checkout main &> /dev/null \
            && git clean -fd 1> /dev/null

        print_result $? "Update content"

        if [ -n "$localChanges" ]; then
            print_info "Run 'git stash pop' in the dotfiles directory to restore stashed changes."
        fi

    fi

}

main
