#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_plugin() {

    declare -r GITHUB_SOURCE="$2"
    declare -r NAME="$1"

    # Check if `asdf` is installed.

    if ! cmd_exists "asdf"; then
        print_error "$NAME ('asdf' is not installed)"
        return 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Install the specified plugin.

    execute \
        "asdf plugin add $NAME https://github.com/$GITHUB_SOURCE" "$1 plugin"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   asdf\n\n"

    brew_install "asdf" "asdf"

    install_plugin "elixir" "asdf-vm/asdf-elixir"
    install_plugin "erlang" "asdf-vm/asdf-erlang"
    install_plugin "java" "halcyon/asdf-java"
    install_plugin "nodejs" "asdf-vm/asdf-nodejs"
    install_plugin "ruby" "asdf-vm/asdf-ruby"
    install_plugin "scala" "mtatheonly/asdf-scala"

}

main
