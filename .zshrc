# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Case-sensitive completion (note: HYPHEN_INSENSITIVE requires this OFF)
CASE_SENSITIVE="true"

# Auto-update behavior
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13

# Show dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Don't mark untracked files as dirty (faster for large repos)
DISABLE_UNTRACKED_FILES_DIRTY="true"

# History timestamp format
HIST_STAMPS="mm/dd/yyyy"

# Plugins (keep lean for fast startup)
plugins=(git history)

source $ZSH/oh-my-zsh.sh

# ---------- Environment detection ----------
# Set your environment in ~/.dotfiles_env (contains "work" or "personal")
# If unset, defaults to "personal"
export DOTFILES_ENV="${DOTFILES_ENV:-personal}"
[[ -f ~/.dotfiles_env ]] && export DOTFILES_ENV="$(< ~/.dotfiles_env)"

# Resolve dotfiles location
DOTFILES_DIR="${0:A:h}"
# Fallback if sourced in a way that $0 doesn't resolve
[[ -d "$DOTFILES_DIR/shell" ]] || DOTFILES_DIR="$HOME/dotfiles"

# ---------- Load shared config ----------
source "$DOTFILES_DIR/shell/common.zsh"

# ---------- Load environment-specific config ----------
if [[ -f "$DOTFILES_DIR/shell/env_${DOTFILES_ENV}.zsh" ]]; then
  source "$DOTFILES_DIR/shell/env_${DOTFILES_ENV}.zsh"
fi

# ---------- Completion colors ----------
zstyle ':completion:*' list-colors ${(s.:.)LSCOLORS}
