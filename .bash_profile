# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export GREP_OPTIONS='--color=auto'

#export PS1="\h:\W \u\$"
export PS1="\W\$ "
export SVN_EDITOR=vim
alias ll='ls -alF'
alias la='ls -AF'
alias l='ls -CF'
alias cls='clear;ls -CF'
alias cdd='cd ~/Desktop/'
alias rmr='rm -r'
alias rmrf='rm -rf'
alias g='grep'
export HISTSIZE=1000000

alias tmux="TERM=screen-256color-bce tmux"
#alias vim="/usr/local/bin/vim"

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

export LC_ALL="en_US.UTF-8"

export IGNOREEOF=-1

function renametab () {
  echo -ne "\033]0;"$@"\007"
}

function show_hfiles() {
  defaults write com.apple.Finder AppleShowAllFiles YES &&
  kill `ps aux | g [F]inder | awk '{ print $2 }'`;
}

function hide_hfiles() {
  defaults write com.apple.Finder AppleShowAllFiles NO &&
  kill `ps aux | g [F]inder | awk '{ print $2 }'`;
}

function set_proxy() {
  read -s -p "Enter Username: " username
  read -s -p "Enter Password: " password
  echo ''
  export https_proxy=$username:$password@50.0.0.5:8080
  export http_proxy=$username:$password@50.0.0.5:8080
  export ftp_proxy=$username:$password@50.0.0.5:8080
  export socks_proxy=$username:$password@50.0.0.5:8080
}


# To disable switching spaces when cmd+Tab
# Deprecated, use mission control settings
# defaults write com.apple.Dock workspaces-auto-swoosh -bool NO

# human readable files sorted by size
alias duh='du -h $(du * | sort -nr | awk "{print \$2}")'

#export  JAVA_HOME=`/usr/libexec/java_home -v 1.7`

export PYTHONSTARTUP="$HOME/.pythonrc"

#export RSTUDIO_WHICH_R=/usr/local/bin/R

function remove_all_except(){
  ls | grep -v "^$1$" | xargs rm
}

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/share/npm/bin:${PATH}"

# dyn.load(/Library/Java/JavaVirtualMachines/jdk1.7.0_67.jdk/Contents/Home/jre/lib/server/libjvm.dylib)

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"


# /etc/profile.d/complete-hosts.sh
# Autocomplete Hostnames for SSH etc.
# by Jean-Sebastien Morisset (http://surniaulula.com/)
_complete_hosts () {
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    host_list=`{ 
        for c in /etc/ssh_config /etc/ssh/ssh_config ~/.ssh/config
        do [ -r $c ] && sed -n -e 's/^Host[[:space:]]//p' -e 's/^[[:space:]]*HostName[[:space:]]//p' $c
        done
        for k in /etc/ssh_known_hosts /etc/ssh/ssh_known_hosts ~/.ssh/known_hosts
        do [ -r $k ] && egrep -v '^[#\[]' $k|cut -f 1 -d ' '|sed -e 's/[,:].*//g'
        done
        sed -n -e 's/^[0-9][0-9\.]*//p' /etc/hosts; }|tr ' ' '\n'|grep -v '*'`
    COMPREPLY=( $(compgen -W "${host_list}" -- $cur))
    return 0
}
complete -F _complete_hosts ssh
complete -F _complete_hosts host


# first argument is machine
copy_vim(){
  if (( "$#" != 1 )) 
  then
    echo "Specify a host!"
  else
    if [ -f /tmp/vimfiles.tar ]; then
      rm /tmp/vimfiles.tar
    fi

    pushd ~/
    tar -czvf /tmp/vimfiles.tar .vim &&
      scp /tmp/vimfiles.tar $1:~/ &&
      scp ~/.vimrc $1:~/ &&
      ssh $1 "tar -xzvf ~/vimfiles.tar" 
      rm /tmp/vimfiles.tar
    popd
  fi
}


#-------------------
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function color_my_prompt {
    local __user_and_host="\[\033[01;35m\]\u@\h"
    local __cur_location="\w"
    local __git_branch_color="\[\033[01;31m\]"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/[\\\\\1]\ /`'
    local __prompt_tail="\[\033[35m\]\$"
    local __last_color="\[\033[00m\]"
    export PS1="$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}
color_my_prompt

complete -W "$(echo $(grep '^ssh ' ~/.bash_history | sort -u | sed 's/^ssh //'))" ssh

#Custom Vars
export EDITOR=vim

# rbenv Installation
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/usr/bin

# Go Installation
export GOPATH=~/repos/go
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$GOPATH/bin"

export TERM=screen-256color

alias resetaudio='sudo killall coreaudiod'

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export PATH="$HOME/.cargo/bin:$PATH"

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
