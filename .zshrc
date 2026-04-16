# ---------- Completion ----------
autoload -Uz compinit
compinit -C  # skip compaudit; regenerate dump manually if completions break

# ---------- Colors ----------
autoload -Uz colors && colors

# ---------- Prompt (robbyrussell-style) ----------
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats "%{$fg_bold[blue]%}git:(%{$fg[red]%}%b%{$fg[blue]%})%{$reset_color%}"
zstyle ':vcs_info:git:*' actionformats "%{$fg_bold[blue]%}git:(%{$fg[red]%}%b%{$fg[blue]%}) %{$fg[yellow]%}%a%{$reset_color%}"
precmd() { vcs_info }
setopt PROMPT_SUBST
PROMPT='%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$fg[cyan]%}%c%{$reset_color%} ${vcs_info_msg_0_} '

# ---------- History ----------
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS SHARE_HISTORY INC_APPEND_HISTORY

# ---------- Options ----------
setopt AUTO_CD
setopt CORRECT
CASE_SENSITIVE="true"

# ---------- Keybindings ----------
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---------- Completion style ----------
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LSCOLORS}
COMPLETION_WAITING_DOTS="true"

# ---------- History aliases ----------
alias h='history'
alias hl='history | less'
alias hs='history | grep'
alias hsi='history | grep -i'

# ---------- Environment detection ----------
export DOTFILES_ENV="${DOTFILES_ENV:-personal}"
[[ -f ~/.dotfiles_env ]] && export DOTFILES_ENV="$(< ~/.dotfiles_env)"

DOTFILES_DIR="${0:A:h}"
[[ -d "$DOTFILES_DIR/shell" ]] || DOTFILES_DIR="$HOME/dotfiles"

# ---------- Load shared config ----------
source "$DOTFILES_DIR/shell/common.zsh"

# ---------- Load environment-specific config ----------
if [[ -f "$DOTFILES_DIR/shell/env_${DOTFILES_ENV}.zsh" ]]; then
  source "$DOTFILES_DIR/shell/env_${DOTFILES_ENV}.zsh"
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH=/opt/spotify-devex/bin:$PATH
