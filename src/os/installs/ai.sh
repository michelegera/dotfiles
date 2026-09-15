#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# Each entry below is independent and reports its own result, so a single
# failure must not abort the rest of the list.

set +e

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   AI\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

printf "\n"

brew_install "Claude" "claude" "--cask"
brew_install "Claude Code" "claude-code"
brew_install "OpenCode" "opencode" "" "anomalyco/tap"
