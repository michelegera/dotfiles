# General

alias cat="bat"
alias ll="ls -lAh"
alias ls="gls --color"
alias ping="prettyping --nolegend"
alias top="htop"
alias v="nvim"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Brew

alias brcl="brew cleanup"
alias brd="brew doctor"
alias brin="brew install"
alias brinf="brew info"
alias brls="brew list"
alias brout="brew outdated"
alias brs="brew search"
alias brun="brew uninstall"
alias brup="brew upgrade"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Bundler

alias be="bundle exec"
alias bi="bundle install"
alias bl="bundle list"
alias bp="bundle package"
alias bu="bundle update"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# macOS

alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Python
# Alias `python` to Homebrew’s Python, `python2` to macOS’s

alias pip="/usr/local/bin/pip3"
alias python="/usr/local/bin/python3"
alias python2="/usr/bin/python"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Rails

alias r="rails"
alias rc="rails c"
alias rdbm="rails db:migrate"
alias rs="rails s"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Tmux

alias txa="tmux a -t"
alias txl="tmux ls"
alias txn="tmux new -s"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Yarn

alias ya="yarn"
alias yaa="yarn add"
alias yaad="yarn add --dev"
alias yaga="yarn global add"
alias yagrm="yarn global remove"
alias yai="yarn init"
alias yarm="yarn remove"
alias yaru="yarn run"
alias yat="yarn test"
