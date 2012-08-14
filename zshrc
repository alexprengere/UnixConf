# /etc/zsh/zshrc ou ~/.zshrc
# Fichier de configuration principal de zsh

################
# 1. Les alias #
################

# Gestion du 'ls' : couleur & ne touche pas aux accents
alias ls='ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable'

# Gestion du 'grep' : couleur
alias grep='grep --color=auto'

# Raccourcis pour 'ls'
alias sl='ls'
alias ll='ls -lhX'
alias la='ls -AhX'
alias lla='ls -lAhX'
alias l='ll -S'

# Quelques alias pratiques
alias c='clear'
alias less='less --quiet'
alias s='cd ..'
alias df='df --human-readable'
alias du='du --human-readable'
#alias md='mkdir'
#alias rd='rmdir'

# Alias pour des couleurs dans le man
#alias manc='man -P most '

# Alias de programmes
alias nh='nautilus .'

alias python='/usr/bin/python'
alias vi='vim '

## Alias basés sur les suffixes des fichiers
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

## Alias globaux
alias -g L="| less"
alias -g M="| more"
alias -g H="| head"
alias -g T="| tail"
alias -g G="| grep"
alias -g W="| wc -l"



#######################################
# 2. Prompt et définition des touches #
#######################################

# Exemple : ma touche HOME, cf  man termcap, est codifiee K1 (upper left
# key  on keyboard)  dans le  /etc/termcap.  En me  referant a  l'entree
# correspondant a mon terminal (par exemple 'linux') dans ce fichier, je
# lis :  K1=\E[1~, c'est la sequence  de caracteres qui sera  envoyee au
# shell. La commande bindkey dit simplement au shell : a chaque fois que
# tu rencontres telle sequence de caractere, tu dois faire telle action.
# La liste des actions est disponible dans "man zshzle".

# Correspondance touches-fonction
bindkey '^A'    beginning-of-line       # Home
bindkey '^E'    end-of-line             # End
bindkey '^D'    delete-char             # Del
bindkey '[3~' delete-char             # Del
bindkey '[2~' overwrite-mode          # Insert
bindkey '[5~' history-search-backward # PgUp
bindkey '[6~' history-search-forward  # PgDn

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

# Prompt couleur gauche (la couleur n'est pas la même pour le root et
# pour les simples utilisateurs)
if [ "`id -u`" -eq 0 ]; then
    PS1="%{[31m%}%n%{[37m%}@%{[34m%}%m %{[37;1m%}%1~ %{[30;1m%}%# %{[0m%}"
else
    PS1="%{[33m%}%n%{[37m%}@%{[34m%}%m %{[37;1m%}%1~ %{[30;1m%}%# %{[0m%}"
fi

PS2="%{[0;30m%}%n%{[0;35m%}@%{[0;30m%}%m %{[0;30m%}%1~ %{[1;31m%}> %{[0m%}"
PS3="%{[1;36m%}?# %{[0m%}"
PS4="%{[0;36m%}(+) %{[0;32m%}%N%{[1;30m%}:%{[0;31m%}%i %{[1;33m%}$ %{[0m%}"

# Prompt couleur droit
RPS1='%{[30;1m%}%~ $COLOR_CONNECTIONS %{[0;36m%}%*%{[0m%}'
RPS2='%{[0;33m%}[%_] %{[1;30m%}%T%{[0m%}'

# Console linux, dans un screen ou un rxvt
if [ "$TERM" = "linux" -o "$TERM" = "screen" -o "$TERM" = "rxvt" ]
then
        # Correspondance touches-fonction spécifique
        bindkey '[1~' beginning-of-line       # Home
        bindkey '[4~' end-of-line             # End
fi

# xterm
if [ "$TERM" = "xterm" ]
then
        # Correspondance touches-fonction spécifique
        bindkey '[H'  beginning-of-line       # Home
        bindkey '[F'  end-of-line             # End
fi

# gnome-terminal
if [ "$COLORTERM" = "gnome-terminal" ]
then
        # Correspondance touches-fonction spécifique
        bindkey '^[OH'  beginning-of-line       # Home
        bindkey '^[OF'  end-of-line             # End
fi

# Titre de la fenêtre d'un xterm
case $TERM in
        xterm*)
        precmd () {print -Pn "\e]0;%n@%m: %~\a"}
        ;;
esac

# Gestion de la couleur pour 'ls' (exportation de LS_COLORS)
if [ -x /usr/bin/dircolors ]
then
        if [ -r ~/.dir_colors ]
        then
                eval "`dircolors ~/.dir_colors`"
        elif [ -r /etc/dir_colors ]
        then
                eval "`dircolors /etc/dir_colors`"
        else
                eval "`dircolors`"
        fi
fi



###########################################
# 3. Options de zsh (cf 'man zshoptions') #
###########################################

# Je ne veux JAMAIS de beeps
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
#setopt correctall
#setopt correct

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
setopt auto_cd

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


###############################################
# 4. Paramètres de l'historique des commandes #
###############################################

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


########################################################
# 5. Définitions persos pour variables d'environnement #
########################################################

# Modification du PATH pour scripts
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.local/bin

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'        # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'    # begin bold
export LESS_TERMCAP_me=$'\E[0m'            # end mode
export LESS_TERMCAP_se=$'\E[0m'            # end standout-mode
export LESS_TERMCAP_so=$'\E[1;31;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'            # end underline
export LESS_TERMCAP_us=$'\E[04;33;5;146m'    # begin underline

# visudo :)
#export EDITOR=`which vi`
#export VISUAL=`which vi`

# Just in case
#setxkbmap fr
#loadkeys fr


###########################################
# 6. Complétion des options des commandes #
###########################################

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' use-compctl false

# Active la complétion
autoload -U compinit
compinit

# Ameliore l'affichage
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:warnings' format '%BNothing in %d%b'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# Crée un cache des complétion possibles
# très utile pour les complétion qui demandent beaucoup de temps
# comme la recherche d'un paquet aptitude install moz<tab>
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache

# Completion pour kill avec couleurs
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# Completion pour killall
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'
zstyle ':completion:*:killall:*' list-colors "=(#b) #([0-9]#)*=36=31"

# Completion sudo -- rajout $PATH pour bien prendre les modifs internes du PATH
PATH_ESPACE=`echo $PATH |tr : " "`
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin \
`echo $PATH_ESPACE`


#############
# 7. Divers #
#############

# Load les prompts par défauts {prompt -l,p}
autoload -U promptinit
promptinit

# Suggestion de commandes dans le cas de programmes non trouvés
# cat /etc/zsh_command_not_found
function preexec() {
    command="${1%% *}"
}

# my_precmd will be overriden by liquidprompt
function my_precmd() {

    # Update this variables, which are displayed in the prompt
    CONNECTIONS=`who |grep -v $USER |wc -l`

    if [ "$CONNECTIONS" -eq 0 ]; then
        COLOR_CONNECTIONS="%{[0;37m%}$CONNECTIONS"
    else
        COLOR_CONNECTIONS="%{[0;31m%}$CONNECTIONS"
    fi

    (($?)) && [ -n "$command" ] && [ -x /usr/lib/command-not-found ] && {
        whence -- "$command" >& /dev/null ||
        /usr/bin/python /usr/lib/command-not-found -- "$command"
        unset command
    }
}

# Aliases and liquid prompt
_one_source() 
{
    if [ -f "$1" ]; then
        source $1
    else
        echo "File $1 not found"
    fi
}

_all_source()
{
    _one_source ~/.liquidprompt
    _one_source ~/.shell.aliases
}

_all_source

if [ ! -f ~/.liquidprompt ]; then
    function precmd () {
        my_precmd
    }
fi
