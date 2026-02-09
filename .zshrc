# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
 ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
 CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
 HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git  history history)

source $ZSH/oh-my-zsh.sh

## User configuration

# export MANPATH="/usr/local/man:$MANPATH"

## You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

## Compilation flags
export ARCHFLAGS="-arch x86_64"

## Set personal aliases, overriding those provided by oh-my-zsh libs,
## plugins, and themes. Aliases can be placed here, though oh-my-zsh
## users are encouraged to define aliases within the ZSH_CUSTOM folder.
## For a full list of active aliases, run `alias`.
##
## Example aliases
 alias zshconfig="mate ~/.zshrc"
 alias ohmyzsh="mate ~/.oh-my-zsh"

## The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yahiae/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yahiae/Downloads/google-cloud-sdk/path.zsh.inc'; fi

## The next line enables shell command completion for gcloud.
if [ -f '/Users/yahiae/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yahiae/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

## --------

#eval "$(/opt/homebrew/bin/brew shellenv)" # takes a bit of time

# #History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

# Pyenv PATH setup is in .zprofile (inlined for speed).
# Lazy-load pyenv shell integration (defers ~190ms until first `pyenv` use)
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init - --no-rehash zsh)"
  eval "$(command pyenv virtualenv-init - zsh)" 2>/dev/null
  pyenv "$@"
}

## Default Python version. Change this is if you want another default
export PYTHON_VERSION='3.8.18'
# Bash function that takes one or zero arguments.
new_venv() { pyenv virtualenv ${1:-$PYTHON_VERSION} $(basename "$PWD") && pyenv local $(basename "$PWD") ${1:-$PYTHON_VERSION}; }

myenv(){ pyenv activate $(basename $(pwd)) }



export VISUAL='/usr/bin/vim'
export EDITOR="$VISUAL"

# Autoload colors
# https://stackoverflow.com/questions/689765/how-can-i-change-the-color-of-my-prompt-in-zsh-different-from-normal-text
#autoload -U colors && colors
#PS1="%F{214}%m%F{015}:%F{039}%~%F{015}\$ "
#PS1="%F{214}%K{000}%m%F{015}%K{000}:%F{039}%K{000}%~%F{015}%K{000}\$ "
#PS1="%{%F{red}%}%n%{%f%}%m %{%F{yellow}%}%~ %{$%f%}%% "


## colors for ls
#export CLICOLOR=1
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx


zstyle ':completion:*' list-colors ${(s.:.)LSCOLORS}

# Prompt information on the right-hand side
#RPROMPT="%F{111}%K{000}[%D{%f/%m/%y}|%@]"

#alias la="ls -a"

## Add forward slash to wordchars
WORDCHARS="a-zA-Z0-9_"
#WORDCHARS="${WORDCHARS/\//}"
alias hcn="hendrix compute -n content-safety-analysis"

# ----------------------- pyenv ------------------------------

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yahiae/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yahiae/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yahiae/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yahiae/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Created by `pipx` on 2023-09-08 09:34:08
export PATH="$PATH:/Users/yahiae/.local/bin"
export PATH="$PATH:/usr/local/share/google-cloud-sdk/bin"
#command -v pipx > /dev/null && eval "$(register-python-argcomplete pipx)"
#eval "$(register-python-argcomplete pipx)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"

# -----
# claude code access
export CLAUDE_CODE_USE_VERTEX=1
export ANTHROPIC_SMALL_FAST_MODEL='claude-3-5-haiku@20241022'
export CLOUD_ML_REGION='europe-west1'
export VERTEX_REGION_CLAUDE_4_1_OPUS='europe-west4'
export ANTHROPIC_VERTEX_PROJECT_ID=spotify-claude-code-trial
export PATH=/opt/spotify-devex/bin:$PATH

alias claude="/Users/yahiae/.claude/local/claude"
