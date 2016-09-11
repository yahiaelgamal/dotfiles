homebrew=/usr/local/bin:/usr/local/sbin
export PATH=$homebrew:$PATH

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export GREP_OPTIONS='--color=auto'

#export PS1="\h:\W \u\$"
export PS1="\W\$"
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
alias vim="/usr/local/bin/vim"

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

# takes first argument the password
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
