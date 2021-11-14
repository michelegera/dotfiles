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
brew_install "Visual Studio Code" "visual-studio-code" "--cask"

printf "\n"

# Symlink settings
symlink "${HOME}/.vscode/settings.json" \
    "${HOME}/Library/Application\ Support/Code/User/settings.json"

printf "\n"

# Install the VSCode plugins
install_plugin "Babel JavaScript" "mgmcdermott.vscode-language-babel"
install_plugin "Better TOML" "bungcip.better-toml"
install_plugin "change-case" "wmaurer.change-case"
install_plugin "Color Info" "bierner.color-info"
install_plugin "DotENV" "mikestead.dotenv"
install_plugin "EditorConfig" "EditorConfig.EditorConfig"
install_plugin "es6-string-html" "Tobermory.es6-string-html"
install_plugin "ESLint" "dbaeumer.vscode-eslint"
install_plugin "File Utils" "sleistner.vscode-fileutils"
install_plugin "fish-vscode" "skyapps.fish-vscode"
install_plugin "Formatting Toggle" "tombonnike.vscode-status-bar-format-toggle"
install_plugin "GitLens" "eamodio.gitlens"
install_plugin "GraphQL" "GraphQL.vscode-graphql"
install_plugin "i18n Ally" "lokalise.i18n-ally"
install_plugin "JavaScript (ES6) Code Snippets" "xabikos.JavaScriptSnippets"
install_plugin "npm IntelliSense" "christian-kohler.npm-intellisense"
install_plugin "Palenight Theme" "whizkydee.material-palenight-theme"
install_plugin "Path IntelliSense" "christian-kohler.path-intellisense"
install_plugin "Prettier" "esbenp.prettier-vscode"
install_plugin "Rainbow CSV" "mechatroner.rainbow-csv"
install_plugin "React PropType Intellisense" "OfHumanBondage.react-proptypes-intellisense"
install_plugin "Sass" "syler.sass-indented"
install_plugin "Scala (Metals)" "scalameta.metals"
install_plugin "Scala Syntax (official)" "scala-lang.scala"
install_plugin "styled-components" "jpoissonnier.vscode-styled-components"
install_plugin "Subtle Match Brackets" "rafamel.subtle-brackets"
install_plugin "Tailwind CSS IntelliSense" "bradlc.vscode-tailwindcss"
install_plugin "Tailwind Twin IntelliSense" "lightyen.tailwindcss-intellisense-twin"
install_plugin "Todo Tree" "Gruntfuggly.todo-tree"
install_plugin "Transformer" "dakara.transformer"
install_plugin "VSCode Ruby" "wingrunr21.vscode-ruby"
install_plugin "vscode-viml-syntax" "dunstontc.viml"
install_plugin "XML Tools" "DotJoshJohnson.xml"

# Close VSCode
osascript -e 'quit app "Visual Studio Code"'
