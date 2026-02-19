# shell/common.zsh — Shared configuration loaded in all environments

# Language
export LANG=en_US.UTF-8

# Editor — use vim everywhere; mvim only if available and not over SSH
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export VISUAL='vim'
elif command -v mvim &>/dev/null; then
  export EDITOR='mvim'
  export VISUAL='mvim'
else
  export EDITOR='vim'
  export VISUAL='vim'
fi

# Architecture flags — detect actual architecture
if [[ "$(uname -m)" == "arm64" ]]; then
  export ARCHFLAGS="-arch arm64"
else
  export ARCHFLAGS="-arch x86_64"
fi

# History
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

# Word characters (for ctrl+w, option+backspace, etc.)
WORDCHARS="a-zA-Z0-9_"

# Pyenv — lazy-load to avoid ~190ms startup penalty
if command -v pyenv &>/dev/null; then
  pyenv() {
    unfunction pyenv
    eval "$(command pyenv init - --no-rehash zsh)"
    eval "$(command pyenv virtualenv-init - zsh)" 2>/dev/null
    pyenv "$@"
  }
fi

export PYTHON_VERSION='3.8.18'

new_venv() {
  pyenv virtualenv ${1:-$PYTHON_VERSION} $(basename "$PWD") \
    && pyenv local $(basename "$PWD") ${1:-$PYTHON_VERSION}
}

myenv() { source .venv/bin/activate; }

# Google Cloud SDK (use $HOME instead of hardcoded path)
if [ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ]; then
  source "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc" ]; then
  source "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"
fi

# pipx / local bins
export PATH="$HOME/.local/bin:$PATH"

# SDKMan
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Java
if [ -d "/usr/local/opt/openjdk@17/bin" ]; then
  export PATH="/usr/local/opt/openjdk@17/bin:$PATH"
fi

# Google Cloud SDK system-wide location
if [ -d "/usr/local/share/google-cloud-sdk/bin" ]; then
  export PATH="$PATH:/usr/local/share/google-cloud-sdk/bin"
fi

# Claude CLI (use $HOME, not hardcoded user)
if [ -x "$HOME/.claude/local/claude" ]; then
  alias claude="$HOME/.claude/local/claude"
fi

# Load machine-local overrides if they exist (not tracked in git)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
