# Homebrew — detect location (Apple Silicon vs Intel vs Linux)
if [ -d "/opt/homebrew" ]; then
  # Apple Silicon Mac
  export HOMEBREW_PREFIX="/opt/homebrew"
elif [ -d "/usr/local/Homebrew" ]; then
  # Intel Mac
  export HOMEBREW_PREFIX="/usr/local"
elif [ -d "/home/linuxbrew/.linuxbrew" ]; then
  # Linux
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi

if [ -n "${HOMEBREW_PREFIX:-}" ]; then
  export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
  export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
  fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
  path=("$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $path)
  [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"
  export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}"
fi

# Pyenv PATH setup (inlined `pyenv init --path` to avoid ~143ms bash fork)
export PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
  path=("$PYENV_ROOT/bin" "$PYENV_ROOT/shims" ${path:#$PYENV_ROOT/shims})
fi
