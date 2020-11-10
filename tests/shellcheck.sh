#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../src/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    find \
        ../src/os \
        ../tests \
        -type f \
        ! -path '../src/os/preferences/*.applescript' \
        -exec shellcheck \
                -e SC1090 \
                -e SC1091 \
                -e SC2155 \
                -e SC2164 \
        {} +

    print_result $? "Run code through ShellCheck"

}

main
