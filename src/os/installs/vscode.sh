#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_plugin() {
    execute "code --install-extension $1" "$2 (plugin)"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Visual Studio Code\n\n"                                :

# Install VSCode
brew_install "Visual Studio Code" "visual-studio-code" "homebrew/cask" "cask"

printf "\n"

# Symlink settings
symlink "${HOME}/.vscode/settings.json" \
    "${HOME}/Library/Application\ Support/Code/User/settings.json"

printf "\n"

# Install the VSCode plugins
install_plugin "bradlc.vscode-tailwindcss" "Tailwind CSS IntelliSense"
install_plugin "bungcip.better-toml" "Better TOML"
install_plugin "christian-kohler.npm-intellisense" "npm IntelliSense"
install_plugin "christian-kohler.path-intellisense" "Path IntelliSense"
install_plugin "coenraads.bracket-pair-colorizer" "Bracket Pair Colorizer"
install_plugin "dakara.transformer" "Transformer"
install_plugin "dbaeumer.vscode-eslint" "ESLint"
install_plugin "editorconfig.editorconfig" "EditorConfig"
install_plugin "esbenp.prettier-vscode" "Prettier"
install_plugin "jpoissonnier.vscode-styled-components" "styled-components"
install_plugin "kumar-harsh.graphql-for-vscode" "GraphQL"
install_plugin "mgmcdermott.vscode-language-babel" "Babel JavaScript"
install_plugin "mikestead.dotenv" "DotENV"
install_plugin "sleistner.vscode-fileutils" "File Utils"
install_plugin "syler.sass-indented" "Sass"
install_plugin "teabyii.ayu" "Ayu"
install_plugin "tombonnike.vscode-status-bar-format-toggle" "Formatting Toggle"
install_plugin "xabikos.javascriptsnippets" "JavaScript (ES6) Code Snippets"

# Close VSCode
osascript -e 'quit app "Visual Studio Code"'
