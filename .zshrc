export VISUAL='/usr/bin/vim'
export EDITOR="$VISUAL"

# Autoload colors 
# https://stackoverflow.com/questions/689765/how-can-i-change-the-color-of-my-prompt-in-zsh-different-from-normal-text
autoload -U colors && colors
export PS1="%F{214}%K{000}%m%F{015}%K{000}:%F{039}%K{000}%~%F{015}%K{000}\$ "


# colors for ls
export CLICOLOR=1
export LSCOLORS=gafacadabaegedabagacad

# Prompt information on the right-hand side
RPROMPT="%F{111}%K{000}[%D{%f/%m/%y}|%@]"

alias la="ls -a"

# Add forward slash to wordchars
WORDCHARS="${WORDCHARS/\//}"
