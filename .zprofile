# Homebrew (inlined output of `brew shellenv` to avoid ~25ms fork)
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
fpath[1,0]="/opt/homebrew/share/zsh/site-functions"
path=("/opt/homebrew/bin" "/opt/homebrew/sbin" $path)
[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

# Pyenv PATH setup (inlined `pyenv init --path` to avoid ~143ms bash fork)
export PYENV_ROOT="$HOME/.pyenv"
path=("$PYENV_ROOT/bin" "$PYENV_ROOT/shims" ${path:#$PYENV_ROOT/shims})
