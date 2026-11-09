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

declare -a FAILED_SCRIPTS=()

run_install_script() {

    local script="$1"

    if ! "./$script"; then
        FAILED_SCRIPTS+=("$script")
    fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# The remaining scripts install independent things and report their own
# results, so one of them failing must not skip all the others.

set +e

run_install_script "fish.sh"

run_install_script "ai.sh"
run_install_script "applications.sh"
run_install_script "browsers.sh"
run_install_script "communications.sh"
run_install_script "creative_tools.sh"
run_install_script "development.sh"
run_install_script "fonts.sh"
run_install_script "gpg.sh"
run_install_script "system.sh"
run_install_script "tools.sh"
run_install_script "neovim.sh"
run_install_script "mas.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_summary() {

    local failedCount="${#FAILED_SCRIPTS[@]}"
    local failedLabel="install scripts"
    local script=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ "$failedCount" -eq 0 ]; then
        print_success "All install scripts completed"
        return 0
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if [ "$failedCount" -eq 1 ]; then
        failedLabel="install script"
    fi

    print_warning "$failedCount $failedLabel failed:"

    for script in "${FAILED_SCRIPTS[@]}"; do
        print_error "$script"
    done

}

print_summary

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Always exit 0, even when some install scripts failed.
#
# `setup.sh` runs this script under `set -euo pipefail`, so a non-zero exit
# would abort the whole bootstrap and skip the preference, default-apps, git
# and update steps. Continuing is the lesser evil: the summary above is how
# failures are reported, not the exit code. Do not "fix" this into a non-zero
# exit.

exit 0
