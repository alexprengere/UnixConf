# /etc/zsh/zshrc or ~/.zshrc

# ALIASES
#
# Examples
# alias somealias='ssh user@host'
# alias somealias='smbclient //host/dir -U user'
# alias somealias='sudo mount -t smbfs -o user=USER //host/dir /mount/point'
# alias somealias='VBoxManage startvm a_vm &'

alias ls='ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable'
alias sl='ls'
alias ll='ls -lhX'
alias la='ls -AhX'
alias lla='ls -lAhX'
alias l='ll -S'

alias grep='grep --color=auto'
alias c='clear'
alias tree='tree -hC'
alias less='less --quiet'
alias vi='vim '
alias notebook='ipython notebook --ip 0.0.0.0 --pylab=inline'

# Suffix based
alias -s png=eog
alias -s jpeg=eog
alias -s jpg=eog
alias -s svg=gimp
alias -s doc=oowriter
alias -s xls=oocalc
alias -s ppt=ooimpress
alias -s odt=oowriter
alias -s pdf=evince
alias -s avi=vlc
alias -s mpg=vlc
alias -s wmv=vlc
alias -s mpeg=vlc


# ZSH OPTIONS
#
# Never beeps
unsetopt beep
unsetopt hist_beep
unsetopt list_beep

# >| doit être utilisés pour pouvoir écraser un fichier déjà existant ;
# le fichier ne sera pas écrasé avec '>'
#unsetopt clobber

# Ctrl+D est équivalent à 'logout'
unsetopt ignore_eof

# Affiche le code de sortie si différent de '0'
#setopt print_exit_value

# Demande confirmation pour 'rm *'
unsetopt rm_star_silent

# Correction orthographique des commandes
# Désactivé car, contrairement à ce que dit le "man", il essaye de
# corriger les commandes avant de les hasher
unsetopt correctall
unsetopt correct

# Si on utilise des jokers dans une liste d'arguments, retire les jokers
# qui ne correspondent à rien au lieu de donner une erreur
setopt nullglob

# Schémas de complétion

# - Schéma A :
# 1ère tabulation : complète jusqu'au bout de la partie commune
# 2ème tabulation : propose une liste de choix
# 3ème tabulation : complète avec le 1er item de la liste
# 4ème tabulation : complète avec le 2ème item de la liste, etc...
# -> c'est le schéma de complétion par défaut de zsh.

# Schéma B :
# 1ère tabulation : propose une liste de choix et complète avec le 1er item
#                   de la liste
# 2ème tabulation : complète avec le 2ème item de la liste, etc...
# Si vous voulez ce schéma, décommentez la ligne suivante :
#setopt menu_complete

# Schéma C :
# 1ère tabulation : complète jusqu'au bout de la partie commune et
#                   propose une liste de choix
# 2ème tabulation : complète avec le 1er item de la liste
# 3ème tabulation : complète avec le 2ème item de la liste, etc...
# Ce schéma est le meilleur à mon goût !
# Si vous voulez ce schéma, décommentez la ligne suivante :
unsetopt list_ambiguous

# Options de complétion
# Quand le dernier caractère d'une complétion est '/' et que l'on
# tape 'espace' après, le '/' est effaçé
setopt auto_remove_slash

# Ne fait pas de complétion sur les fichiers et répertoires cachés
unsetopt glob_dots

# Traite les liens symboliques comme il faut
setopt chase_links

# Quand l'utilisateur commence sa commande par '!' pour faire de la
# complétion historique, il n'exécute pas la commande immédiatement
# mais il écrit la commande dans le prompt
setopt hist_verify

# Si la commande est invalide mais correspond au nom d'un sous-répertoire
# exécuter 'cd sous-répertoire'
#setopt auto_cd

# L'exécution de "cd" met le répertoire d'où l'on vient sur la pile
setopt auto_pushd

# Ignore les doublons dans la pile
setopt pushd_ignore_dups

# N'affiche pas la pile après un "pushd" ou "popd"
setopt pushd_silent

# "pushd" sans argument = "pushd $HOME"
setopt pushd_to_home

# Les jobs qui tournent en tâche de fond sont nicé à '0'
unsetopt bg_nice

# N'envoie pas de "HUP" aux jobs qui tournent quand le shell se ferme
unsetopt hup

# Active le globbing étendu
setopt extendedglob

# Substitution of variables at each prompt display
setopt prompt_subst


# ZSH HISTORY
#
# Nombre d'entrées dans l'historique
export HISTORY=1000
export SAVEHIST=1000

# Fichier où est stocké l'historique
export HISTFILE=$HOME/.history

# Ajoute l'historique à la fin de l'ancien fichier
#setopt append_history

# Chaque ligne est ajoutée dans l'historique à mesure qu'elle est tapée
setopt inc_append_history

# Ne stocke pas  une ligne dans l'historique si elle  est identique à la
# précédente
setopt hist_ignore_dups

# Supprime les  répétitions dans le fichier  d'historique, ne conservant
# que la dernière occurrence ajoutée
#setopt hist_ignore_all_dups

# Supprime les  répétitions dans l'historique lorsqu'il  est plein, mais
# pas avant
setopt hist_expire_dups_first

# N'enregistre  pas plus d'une fois  une même ligne, quelles  que soient
# les options fixées pour la session courante
#setopt hist_save_no_dups

# La recherche dans  l'historique avec l'éditeur de commandes  de zsh ne
# montre  pas  une même  ligne  plus  d'une fois,  même  si  elle a  été
# enregistrée
setopt hist_find_no_dups


# ZSH AUTOCOMPLETE
#
# Add custom completion scripts
fpath=(~/.zsh/completion $fpath)

# Active la complétion
autoload -U compinit
compinit

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' use-compctl false

# Crée un cache des complétion possibles
# très utile pour les complétion qui demandent beaucoup de temps
# comme la recherche d'un paquet aptitude install moz<tab>
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache

# Ameliore l'affichage
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:warnings' format '%BNothing in %d%b'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# Completion pour kill avec couleurs
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# Completion pour killall
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'
zstyle ':completion:*:killall:*' list-colors "=(#b) #([0-9]#)*=36=31"

# Completion sudo -- rajout $PATH pour bien prendre les modifs internes du PATH
zstyle ':completion:*:sudo:*' command-path \
    /usr/local/sbin /usr/local/bin \
    /usr/sbin /usr/bin /usr/X11R6/bin \
    /sbin /bin \
    `echo $PATH |tr : " "`


# KEY BINDINGS, COLORS
#
# Vim-zsh binding
bindkey -v
export KEYTIMEOUT=1

bindkey '^A'    beginning-of-line       # Home
bindkey '^E'    end-of-line             # End
bindkey '^D'    delete-char             # Del
bindkey '[3~' delete-char             # Del
bindkey '[2~' overwrite-mode          # Insert
bindkey '[5~' history-search-backward # PgUp
bindkey '[6~' history-search-forward  # PgDn

# Use vim cli mode
bindkey '^P' up-history
bindkey '^N' down-history

# backspace and ^h working even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# ctrl-w removed word backwards
bindkey '^w' backward-kill-word

# ctrl-r starts searching history backward
bindkey '^r' history-incremental-search-backward

# Console linux, dans un screen ou un rxvt
if [ "$TERM" = "linux" -o "$TERM" = "screen" -o "$TERM" = "rxvt" ]; then
    bindkey '[1~' beginning-of-line       # Home
    bindkey '[4~' end-of-line             # End
fi

# xterm
if [ "$TERM" = "xterm" ]; then
    bindkey '[H'  beginning-of-line       # Home
    bindkey '[F'  end-of-line             # End
fi

# gnome-terminal
if [ "$COLORTERM" = "gnome-terminal" ]; then
    bindkey '^[OH'  beginning-of-line       # Home
    bindkey '^[OF'  end-of-line             # End
fi

# Titre de la fenêtre d'un xterm
case $TERM in
    xterm*)
        precmd () {
            print -Pn "\e]0;%n@%m: %~\a"
        }
        ;;
esac

# Enable 256 colors
if [ -e /usr/share/terminfo/x/xterm*256color* ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

# Gestion de la couleur pour 'ls' (exportation de LS_COLORS)
if [ -x /usr/bin/dircolors ]; then
    if [ -r ~/.dir_colors ]; then
        eval "`dircolors ~/.dir_colors`"
    elif [ -r /etc/dir_colors ]; then
        eval "`dircolors /etc/dir_colors`"
    else
        eval "`dircolors`"
    fi
fi

## Memo couleur
# 0/1 -- clair/foncé
# Balise ouvrante %{[0;35m%}
# Balise fermante %{[0m%}
# 30 noir
# 31 rouge
# 32 vert
# 33 jaune
# 34 bleu
# 35 violet
# 36 cyan
# 37 blanc

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'        # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'   # begin bold
export LESS_TERMCAP_me=$'\E[0m'            # end mode
export LESS_TERMCAP_se=$'\E[0m'            # end standout-mode
export LESS_TERMCAP_so=$'\E[1;31;5;246m'   # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'            # end underline
export LESS_TERMCAP_us=$'\E[04;33;5;146m'  # begin underline


# PROMPTS
#
# Suggestion de commandes dans le cas de programmes non trouvés
# cat /etc/zsh_command_not_found
function preexec() {
    command="${1%% *}"
}

function precmd() {
    (($?)) && [ -n "$command" ] && [ -x /usr/lib/command-not-found ] && {
        whence -- "$command" >& /dev/null ||
        /usr/bin/python /usr/lib/command-not-found -- "$command"
        unset command
    }
    # Update this variable, displayed in the right prompt
    local nc=$(who |grep -v $USER |cut -d ' ' -f1 |sort |uniq |wc -l)
    [[ "$nc" -ne 0 ]] && RPS1_CONNECTIONS="%{[0;31m%}($nc)%{[0m%}"
}

if [ "`id -u`" -eq 0 ]; then
    COL="%{[31m%}"
else
    COL="%{[33m%}"
fi
PS1="$COL%n%{[37m%}@%{[34m%}%m %{[37;1m%}%1~ %{[30;1m%}%# %{[0m%}"
PS2="%{[0;30m%}%n%{[0;35m%}@%{[0;30m%}%m %{[0;30m%}%1~ %{[1;31m%}> %{[0m%}"
PS3="%{[1;36m%}?# %{[0m%}"
PS4="%{[0;36m%}(+) %{[0;32m%}%N%{[1;30m%}:%{[0;31m%}%i %{[1;33m%}$ %{[0m%}"

RPS1='$RPS1_CONNECTIONS %{[30;1m%}%~ %{[0;36m%}%*%{[0m%}'
RPS2='%{[0;33m%}[%_] %{[1;30m%}%T%{[0m%}'

function zle-line-init zle-keymap-select {
    local vimode="%{[1;32m%}% [% NORMAL]% %{[0m%}"
    RPS1='${${KEYMAP/vicmd/$vimode}/(main|viins)/}$EPS1 $RPS1_CONNECTIONS %{[30;1m%}%~ %{[0;36m%}%*%{[0m%}'
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Load les prompts par défauts {prompt -l,p}
autoload -U promptinit
promptinit


# PATH ENHANCEMENT
#
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cabal/bin
export PATH=$PATH:/opt/vagrant/bin
export PATH=$PATH:/usr/local/heroku/bin

export GOROOT=/opt/go
export PATH=$PATH:$GOROOT/bin


# MISC
#
# Git pushes
unset SSH_ASKPASS

# For GeoBase CLI
export BACKGROUND_COLOR=black

# Fish like syntax highlighting
source "$HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# LiquidPrompt
[[ $- = *i* ]] && source "$HOME/.liquidprompt"

set -o promptsubst
