# ~/.bashrc ou /etc/bash.bashrc : executed by bash(1) for non-login shells.
# Révision -- 4 septembre 2009

# Pour avoir des jolies couleurs
color_prompt=yes

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export HISTSIZE=1000000
export HISTFILESIZE=1000000

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

export COLORTERM=truecolor

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
man() {
    LESS_TERMCAP_mb=$'\e'"[1;31m" \
    LESS_TERMCAP_md=$'\e'"[1;31m" \
    LESS_TERMCAP_me=$'\e'"[0m" \
    LESS_TERMCAP_se=$'\e'"[0m" \
    LESS_TERMCAP_so=$'\e'"[1;44;33m" \
    LESS_TERMCAP_ue=$'\e'"[0m" \
    LESS_TERMCAP_us=$'\e'"[1;32m" \
    command man "$@"
}

# PATH ENHANCEMENT
#
export GOROOT=/opt/go
export PATH=$GOROOT/bin:$PATH

export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=/opt/vagrant/bin:$PATH
export PATH=/usr/local/heroku/bin:$PATH


# MISC
#
# SSH Agent
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"

# GPG signing
export GPG_TTY=$(tty)

# Git pushes
unset SSH_ASKPASS

# Correction automatique des fautes de frappe sur la commande cd
shopt -s cdspell

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# WSL startingDirectory not really working so far, so we force it
if [[ $(uname -r) =~ WSL && $(pwd) =~ /mnt/ ]]; then
    cd ~
fi

# Aliases and liquid prompt
[[ $- = *i* ]] && source "$HOME/.liquidprompt"
