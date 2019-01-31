override_git_prompt_colors() {
  GIT_PROMPT_THEME_NAME="Spaceship"

  if [ -e ~/.rvm/bin/rvm-prompt ]; then
    RubyPrompt='⬥ v$(~/.rvm/bin/rvm-prompt v g)'
  else
    RubyPrompt='⬥ v$(ruby -v | sed -E "s/ruby ([0-9]+\.[0-9]+\.[0-9]+).*/\1/")'
  fi

  NodePrompt='⬢ $(node -v)'

  GIT_PROMPT_START_USER="\n${Blue}${PathShort}"
  GIT_PROMPT_PREFIX="${ResetColor}on ${Magenta} "
  GIT_PROMPT_BRANCH="${Magenta}"
  GIT_PROMPT_SEPARATOR="${ResetColor} ${BrightBlack}["
  GIT_PROMPT_SUFFIX="${BrightBlack}]"
  GIT_PROMPT_END_USER=" ${ResetColor}via ${Green}${NodePrompt} ${Red}${RubyPrompt}${ResetColor}\n_LAST_COMMAND_INDICATOR_${ResetColor} "

  GIT_PROMPT_CLEAN="${Green}✔"
  GIT_PROMPT_STAGED="${Green}+"
  GIT_PROMPT_CHANGED="${Yellow}!"
  GIT_PROMPT_STASHED="${Cyan}$"
  GIT_PROMPT_CONFLICTS="${Red}="
  GIT_PROMPT_UNTRACKED="${Blue}?"

  GIT_PROMPT_SYMBOLS_AHEAD="${Yellow}⇡"
  GIT_PROMPT_SYMBOLS_BEHIND="${Yellow}⇣"

  GIT_PROMPT_COMMAND_OK="${Green}❯"
  GIT_PROMPT_COMMAND_FAIL="${Red}❯"
}

reload_git_prompt_colors "Custom"
