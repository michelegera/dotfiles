#!/bin/bash

# Check the syntax of every shell script tracked in the repository.
#
# `git ls-files` is used on purpose, so that untracked scratch files are not
# picked up. It also covers the extensionless bash scripts under
# `src/shell/scripts/`.
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

    while IFS= read -r file; do
        filesToCheck+=("$file")
    done < <(
        git -C .. ls-files \
            '*.sh' \
            'src/shell/scripts/ai-commit-msg' \
            'src/shell/scripts/no_automount'
    )

    for file in "${filesToCheck[@]}"; do
        if ! bash -n "../$file"; then
            print_error "$file"
            exitCode=1
        fi
    done

    print_result "$exitCode" "Check Bash syntax"

    return "$exitCode"

}

main
