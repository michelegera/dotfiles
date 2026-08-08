# Moonlight theme for Fish shell
# Based on: https://github.com/atomiks/moonlight-vscode-theme
# Place in: ~/.config/fish/conf.d/moonlight.fish

# Syntax Highlighting Colors
set -g fish_color_normal c8d3f5
set -g fish_color_command 82aaff
set -g fish_color_keyword c099ff
set -g fish_color_quote c3e88d
set -g fish_color_redirection 86e1fc
set -g fish_color_end fca7ea
set -g fish_color_error ff757f
set -g fish_color_param ffc777
set -g fish_color_comment 7a88cf --italics
set -g fish_color_operator c099ff
set -g fish_color_escape fca7ea
set -g fish_color_autosuggestion 7a88cf
set -g fish_color_option 86e1fc

# Completion Pager Colors  
set -g fish_pager_color_progress 82aaff
set -g fish_pager_color_prefix 65bcff --bold
set -g fish_pager_color_completion c8d3f5
set -g fish_pager_color_description 7a88cf
set -g fish_pager_color_selected_background --background=444a73

# Git prompt colors
set -g __fish_git_prompt_color_branch fca7ea
set -g __fish_git_prompt_color_branch_detached ff757f
set -g __fish_git_prompt_color_upstream 86e1fc
set -g __fish_git_prompt_color_dirtystate ffc777
set -g __fish_git_prompt_color_stagedstate c3e88d
set -g __fish_git_prompt_color_invalidstate ff757f
set -g __fish_git_prompt_color_untrackedfiles ff995e
set -g __fish_git_prompt_color_cleanstate c3e88d

# Search match highlighting
set -g fish_color_search_match --background=444a73
set -g fish_color_selection --background=444a73

# User and host colors
set -g fish_color_user 86e1fc
set -g fish_color_host 82aaff
set -g fish_color_host_remote fca7ea

# Valid/invalid path colors
set -g fish_color_valid_path --underline
set -g fish_color_cancel ff757f
