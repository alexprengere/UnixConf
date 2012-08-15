# Use with oh-my-zsh
# wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
# 
# Then put custom stuff in ~/.oh-my-zsh/custom/example.zsh
# And this file in ~/.oh-my-zsh/themes
# Finally, update zshrc to use this theme and activate plugin git

if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then

    # display exitcode on the right when >0
    return_code="%(?..%{$fg[red]%} %?↵%{$reset_color%})"

    PROMPT='%{$fg[yellow]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%} %{$fg_bold[white]%}%1~%{$reset_color%}$(git_prompt_info)$(git_prompt_status)${return_code} %{$fg_bold[grey]%}%#%{$reset_color%} '

    ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[green]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_CLEAN=""
    ZSH_THEME_GIT_PROMPT_DIRTY=""

    RPROMPT='%{$fg_bold[grey]%}%~%{$reset_color%} %{$fg[cyan]%}%*%{$reset_color%}'

    ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚"
    ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%}✹"
    ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖"
    ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%}➜"
    ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%}═"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}✭"
else
    PROMPT='[%n@%m:%~$(git_prompt_info)] %# '

    ZSH_THEME_GIT_PROMPT_PREFIX=" on "
    ZSH_THEME_GIT_PROMPT_SUFFIX=""
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    # display exitcode on the right when >0
    return_code="%(?..%? ↵)"

    RPROMPT='${return_code}$(git_prompt_status)'

    ZSH_THEME_GIT_PROMPT_ADDED="✚"
    ZSH_THEME_GIT_PROMPT_MODIFIED="✹"
    ZSH_THEME_GIT_PROMPT_DELETED="✖"
    ZSH_THEME_GIT_PROMPT_RENAMED="➜"
    ZSH_THEME_GIT_PROMPT_UNMERGED="═"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="✭"
fi
