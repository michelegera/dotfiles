#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n • Set default applications\n\n"

    # Check if `duti` is installed

    if ! cmd_exists "duti"; then
        print_error "duti is required, please install it!"
        exit 1
    fi

    execute "duti ${HOME}/.duti" "duti"

}

main
