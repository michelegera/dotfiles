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
install_plugin "bierner.color-info" "Color Info"
install_plugin "bradlc.vscode-tailwindcss" "Tailwind CSS IntelliSense"
install_plugin "bungcip.better-toml" "Better TOML"
install_plugin "christian-kohler.npm-intellisense" "npm IntelliSense"
install_plugin "christian-kohler.path-intellisense" "Path IntelliSense"
install_plugin "dakara.transformer" "Transformer"
install_plugin "dbaeumer.vscode-eslint" "ESLint"
install_plugin "DotJoshJohnson.xml" "XML Tools"
install_plugin "dunstontc.viml" "vscode-viml-syntax"
install_plugin "eamodio.gitlens" "GitLens"
install_plugin "EditorConfig.EditorConfig" "EditorConfig"
install_plugin "esbenp.prettier-vscode" "Prettier"
install_plugin "GraphQL.vscode-graphql" "GraphQL"
install_plugin "Gruntfuggly.todo-tree" "Todo Tree"
install_plugin "jpoissonnier.vscode-styled-components" "styled-components"
install_plugin "lightyen.tailwindcss-intellisense-twin" "Tailwind Twin IntelliSense"
install_plugin "lokalise.i18n-ally" "i18n Ally"
install_plugin "mechatroner.rainbow-csv" "Rainbow CSV"
install_plugin "mgmcdermott.vscode-language-babel" "Babel JavaScript"
install_plugin "mikestead.dotenv" "DotENV"
install_plugin "OfHumanBondage.react-proptypes-intellisense" "React PropType Intellisense"
install_plugin "rafamel.subtle-brackets" "Subtle Match Brackets"
install_plugin "scala-lang.scala" "Scala Syntax (official)"
install_plugin "scalameta.metals" "Scala (Metals)"
install_plugin "skyapps.fish-vscode" "fish-vscode"
install_plugin "sleistner.vscode-fileutils" "File Utils"
install_plugin "syler.sass-indented" "Sass"
install_plugin "Tobermory.es6-string-html" "es6-string-html"
install_plugin "tombonnike.vscode-status-bar-format-toggle" "Formatting Toggle"
install_plugin "whizkydee.material-palenight-theme" "Palenight Theme"
install_plugin "wingrunr21.vscode-ruby" "VSCode Ruby"
install_plugin "wmaurer.change-case" "change-case"
install_plugin "xabikos.JavaScriptSnippets" "JavaScript (ES6) Code Snippets"

# Close VSCode
osascript -e 'quit app "Visual Studio Code"'
