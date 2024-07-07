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
    "${HOME}/Library/Application Support/Code/User/"

printf "\n"

# Install the VSCode plugins
install_plugin "Babel JavaScript" "mgmcdermott.vscode-language-babel"
install_plugin "Better Comments" "aaron-bond.better-comments"
install_plugin "change-case" "wmaurer.change-case"
install_plugin "Color Highlight" "naumovs.color-highlight"
install_plugin "DotENV" "mikestead.dotenv"
install_plugin "EditorConfig" "EditorConfig.EditorConfig"
install_plugin "Ember.js Extension Pack" "EmberTooling.emberjs"
install_plugin "es6-string-html" "Tobermory.es6-string-html"
install_plugin "ESLint" "dbaeumer.vscode-eslint"
install_plugin "Even Better TOML" "tamasfe.even-better-toml"
install_plugin "File Utils" "sleistner.vscode-fileutils"
install_plugin "fish-vscode" "skyapps.fish-vscode"
install_plugin "Formatting Toggle" "tombonnike.vscode-status-bar-format-toggle"
install_plugin "GitHub Copilot" "GitHub.copilot"
install_plugin "GitLens" "eamodio.gitlens"
install_plugin "Glimmer Templates Syntax for VS Code" "lifeart.vscode-glimmer-syntax"
install_plugin "GraphQL" "GraphQL.vscode-graphql"
install_plugin "GraphQL: Syntax Highlight" "GraphQL.vscode-graphql-syntax"
install_plugin "Halcyon" "brittanychiang.halcyon-vscode"
install_plugin "Indented Block Highlighting" "byi8220.indented-block-highlighting"
install_plugin "JavaScript (ES6) Code Snippets" "xabikos.JavaScriptSnippets"
install_plugin "JavaScript Booster" "sburg.vscode-javascript-booster"
install_plugin "Lua" "keyring.Lua"
install_plugin "npm IntelliSense" "christian-kohler.npm-intellisense"
install_plugin "Path IntelliSense" "christian-kohler.path-intellisense"
install_plugin "Material Icon Theme" "PKief.material-icon-theme"
install_plugin "Prettier" "esbenp.prettier-vscode"
install_plugin "Prisma" "Prisma.prisma"
install_plugin "Rainbow CSV" "mechatroner.rainbow-csv"
install_plugin "React PropType Intellisense" "OfHumanBondage.react-proptypes-intellisense"
install_plugin "Sass" "syler.sass-indented"
install_plugin "Stable Ember Language Server" "lifeart.vscode-ember-unstable"
install_plugin "Subtle Match Brackets" "rafamel.subtle-brackets"
install_plugin "Svg Preview" "SimonSiefke.svg-preview"
install_plugin "Tailwind CSS IntelliSense" "bradlc.vscode-tailwindcss"
install_plugin "Todo Tree" "Gruntfuggly.todo-tree"
install_plugin "Transformer" "dakara.transformer"
install_plugin "vscode-viml-syntax" "dunstontc.viml"


# Close VSCode
osascript -e 'quit app "Visual Studio Code"'
