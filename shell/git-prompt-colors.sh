__ruby_version () {
  printf `rbenv version | awk '{print $1}'`
}

__node_version () {
  printf `nvm version | cut -c2-`
}

override_git_prompt_colors() {
  GIT_PROMPT_THEME_NAME="Custom"

  # Patched nerd font required - https://nerdfonts.com
  IconFolder=$'\uf115'
  IconGit=$'\uf418'
  IconNode=$'\uf898'
  IconRuby=$'\ue21e'
  IconArrowUp=$'\uf55f'
  IconArrowDown=$'\uf547'
  IconAngleRight=$'\uf105'
  IconExclamation=$'\uf06a'
  IconQuestion=$'\uf059'
  IconPlus=$'\uf055'
  IconCheck=$'\uf058'
  IconDots=$'\ufcc1'

  RubyPrompt=' ${IconRuby} $(__ruby_version)'
  NodePrompt=' ${IconNode} $(__node_version)'

  GIT_PROMPT_START_USER="\n${Blue}${IconFolder}  ${PathShort}"
  GIT_PROMPT_PREFIX="${ResetColor}on ${Magenta}${IconGit} "
  GIT_PROMPT_BRANCH="${Magenta}"
  GIT_PROMPT_SEPARATOR="${ResetColor} "
  GIT_PROMPT_SUFFIX=""
  GIT_PROMPT_END_USER=" ${ResetColor}with${Green}${NodePrompt}${Red}${RubyPrompt}${ResetColor}\n_LAST_COMMAND_INDICATOR_${ResetColor} "

  GIT_PROMPT_CLEAN="${Green}${IconCheck} "
  GIT_PROMPT_STAGED="${Green}${IconPlus} "
  GIT_PROMPT_CHANGED="${Yellow}${IconExclamation} "
  GIT_PROMPT_STASHED="${Blue}${IconDots} "
  GIT_PROMPT_CONFLICTS="${Red}${IconExc} "
  GIT_PROMPT_UNTRACKED="${BrightBlack}${IconQuestion} "

  GIT_PROMPT_SYMBOLS_AHEAD=" ${Yellow}${IconArrowUp} "
  GIT_PROMPT_SYMBOLS_BEHIND=" ${Yellow}${IconArrowDown} "

  GIT_PROMPT_COMMAND_OK="${Green}${IconAngleRight}"
  GIT_PROMPT_COMMAND_FAIL="${Red}${IconAngleRight}"
}

reload_git_prompt_colors "Custom"
