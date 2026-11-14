#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n • Update content\n\n"

    ask_for_confirmation "Do you want to update the content from the 'dotfiles' directory?"

    if answer_is_yes; then

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Show a preview of local changes that would be overwritten.

        local localChanges=""
        localChanges="$(git status --short)"

        if [ -n "$localChanges" ]; then
            printf "\n"
            print_warning "The following local changes (including untracked files) will be stashed:"
            printf "%s\n" "$localChanges"
            printf "\n"

            ask_for_confirmation "Continue and stash these changes?"

            if ! answer_is_yes; then
                print_info "Update cancelled — local changes preserved."
                return 0
            fi
        fi

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        # Stash local changes (untracked files included) before resetting, so
        # they can be restored later. Without `-u`, `git clean` would delete
        # the untracked files instead of preserving them.

        if [ -n "$localChanges" ]; then
            git stash push -u -m "dotfiles-update-$(date +%s)" 1> /dev/null \
                || print_warning "Failed to stash local changes — they may be lost"
        fi

        # A failure in any of these must be reported instead of aborting the
        # script through `set -e`.
        #
        # `checkout` comes first because `reset --hard origin/main` would
        # otherwise move the pointer of whatever branch is currently checked
        # out instead of `main`.

        local updateExitCode=0

        { git checkout main &> /dev/null \
            && git fetch --all 1> /dev/null \
            && git reset --hard origin/main 1> /dev/null \
            && git clean -fd 1> /dev/null ; } \
            || updateExitCode=$?

        print_result "$updateExitCode" "Update content"

        if [ -n "$localChanges" ]; then
            print_info "Run 'git stash pop' in the dotfiles directory to restore stashed changes."
        fi

    fi

}

main
