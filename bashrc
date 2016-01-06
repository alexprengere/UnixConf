# ~/.bashrc ou /etc/bash.bashrc : executed by bash(1) for non-login shells.
# Révision -- 4 septembre 2009

# Pour avoir des jolies couleurs
color_prompt=yes

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="\[\e[0;33m\]\u\[\e[m\]@\[\e[0;34m\]\h\[\e[m\] \[\e[1;37m\]\W\[\e[m\] \[\e[0;30m\]\$\[\e[m\] "
    PS2="\[\e[0;30m\]\u\[\e[m\]\[\e[0;35m\]@\[\e[m\]\[\e[0;30m\]\h\[\e[m\] \[\e[0;30m\]\W\[\e[m\] \[\e[0;31m\]>\[\e[m\] "
    PS3="#? "
    PS4="+ % "
else
    PS1='${debian_chroot:+($debian_chroot)}$\u@\h \W \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    :xterm*|rxvt*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@{HOSTNAME}: ${PWD/$HOME/~}\007"'
        ;;

    *)
        ;;
esac

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lhX'
alias la='ls -lAhX'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'        # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'   # begin bold
export LESS_TERMCAP_me=$'\E[0m'            # end mode
export LESS_TERMCAP_se=$'\E[0m'            # end standout-mode
export LESS_TERMCAP_so=$'\E[1;31;5;246m'   # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'            # end underline
export LESS_TERMCAP_us=$'\E[04;33;5;146m'  # begin underline


# PATH ENHANCEMENT
#
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cabal/bin
export PATH=$PATH:/opt/vagrant/bin
export PATH=$PATH:/usr/local/heroku/bin

export GOROOT=/opt/go
export PATH=$PATH:$GOROOT/bin

# Correction automatique des fautes de frappe sur la commande cd
shopt -s cdspell

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Aliases and liquid prompt
[[ $- = *i* ]] && source "$HOME/.liquidprompt"

