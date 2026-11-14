#!/bin/bash

# TextEdit is sandboxed, so these preferences live in its container and cannot
# be set from here: `defaults write com.apple.TextEdit ...` is silently ignored.

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"
