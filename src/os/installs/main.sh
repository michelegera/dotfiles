#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Installs\n\n"

# `Xcode` and `Homebrew` are prerequisites for everything that follows, so a
# failure there must still stop the run.

./xcode.sh \
    || exit 1

./homebrew.sh \
    || exit 1

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# The remaining scripts install independent things and report their own
# results, so one of them failing must not skip all the others.

set +e

./fish.sh

./ai.sh
./applications.sh
./browsers.sh
./communications.sh
./creative_tools.sh
./development.sh
./fonts.sh
./gpg.sh
./system.sh
./tools.sh
./neovim.sh
./mas.sh

exit 0
