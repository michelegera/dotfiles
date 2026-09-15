#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

initialize_git_repository() {

    declare -r GIT_ORIGIN="${1:-}"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ -z "$GIT_ORIGIN" ]; then
        print_error "Please provide a URL for the Git origin"
        exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! is_git_repository; then

        # Run the following Git commands in the root of the dotfiles directory,
        # not in the `os` directory.
        #
        # Bailing out here is important, as continuing would initialize the
        # repository in the wrong directory.

        cd ../../ \
            || { print_error "Failed to 'cd ../../'"; return 1; }

        execute \
            "git init && git remote add origin $GIT_ORIGIN" \
            "Initialize the Git repository"

    fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n • Initialize Git repository\n\n"

    initialize_git_repository "${1:-}"
}

main "${1:-}"
