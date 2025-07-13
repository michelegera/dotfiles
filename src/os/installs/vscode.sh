#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_plugin() {
    execute "code --install-extension $2" "$1 (plugin)"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Visual Studio Code\n\n"                                :

# Install VSCode
brew_install "Visual Studio Code" "visual-studio-code"

printf "\n"

# Symlink settings
mkdir -p "${HOME}/Library/Application Support/Code/User/"
symlink "$(realpath ~/.vscode)/settings.json" \
    "${HOME}/Library/Application Support/Code/User"

printf "\n"

# Install the VSCode plugins
install_plugin "Babel JavaScript" "mgmcdermott.vscode-language-babel"
install_plugin "Better Comments" "aaron-bond.better-comments"
install_plugin "Catppuccin Icons for VSCode" "catppuccin.catppuccin-vsc-icons"
install_plugin "DotENV" "mikestead.dotenv"
install_plugin "EditorConfig" "EditorConfig.EditorConfig"
install_plugin "ESLint" "dbaeumer.vscode-eslint"
install_plugin "Even Better TOML" "tamasfe.even-better-toml"
install_plugin "File Utils" "sleistner.vscode-fileutils"
install_plugin "Fish" "bmalehorn.vscode-fish"
install_plugin "Formatting Toggle" "tombonnike.vscode-status-bar-format-toggle"
install_plugin "GitHub Copilot Chat" "github.copilot-chat"
install_plugin "GitHub Copilot" "GitHub.copilot"
install_plugin "GitLens" "eamodio.gitlens"
install_plugin "GraphQL" "GraphQL.vscode-graphql"
install_plugin "GraphQL: Syntax Highlight" "GraphQL.vscode-graphql-syntax"
install_plugin "npm IntelliSense" "christian-kohler.npm-intellisense"
install_plugin "Path IntelliSense" "christian-kohler.path-intellisense"
install_plugin "Prettier" "esbenp.prettier-vscode"
install_plugin "Tailwind CSS IntelliSense" "bradlc.vscode-tailwindcss"
install_plugin "Tokyo Night" "enkia.tokyo-night"

# Close VSCode
osascript -e 'quit app "Visual Studio Code"'
