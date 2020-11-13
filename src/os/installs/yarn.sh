#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_yarn() {

    if ! cmd_exists "yarn"; then
        curl -o- -sL https://yarnpkg.com/install.sh | bash&> /dev/null
    fi

    print_result $? "Yarn"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Yarn\n\n"

    install_yarn

}

main
