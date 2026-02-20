# Bash profile — minimal, since zsh is the primary shell.
# This sources common config for the rare case bash is used.

# Homebrew
if [ -d "/opt/homebrew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -d "/usr/local/Homebrew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# If interactive bash, load basics
if [ -n "$PS1" ]; then
  export EDITOR=vim
  export LANG=en_US.UTF-8
  export HISTSIZE=100000
  export HISTCONTROL=ignoreboth

  # Git completion
  [ -f ~/.git-completion.bash ] && source ~/.git-completion.bash
fi
