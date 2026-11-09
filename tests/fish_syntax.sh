#!/bin/bash

# Check the syntax of every Fish file tracked in the repository.
#
# `fish --no-execute` parses the file without running it (it requires
# fish >= 3.x). `git ls-files` is used on purpose, so that untracked scratch
# files and vendored, git-ignored plugins are not picked up.
#
# Note: This is run both locally and in CI.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && source "../src/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    local -a filesToCheck=()
    local exitCode=0
    local file=""

    if ! cmd_exists "fish"; then
        print_error "Fish is not installed"
        return 1
    fi

    while IFS= read -r file; do
        filesToCheck+=("$file")
    done < <(git -C .. ls-files '*.fish')

    for file in "${filesToCheck[@]}"; do
        if ! fish --no-execute "../$file"; then
            print_error "$file"
            exitCode=1
        fi
    done

    print_result "$exitCode" "Check Fish syntax"

    return "$exitCode"

}

main
