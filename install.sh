#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

info()  { echo -e "${GREEN}[ok]${NC} $1"; }
warn()  { echo -e "${YELLOW}[skip]${NC} $1"; }
err()   { echo -e "${RED}[error]${NC} $1"; }

link_file() {
  local src="$1"
  local dst="$2"

  if [ -L "$dst" ]; then
    local current_target
    current_target="$(readlink "$dst")"
    if [ "$current_target" = "$src" ]; then
      info "$dst -> already linked"
      return
    fi
    warn "$dst -> symlink exists (points to $current_target), replacing"
    rm "$dst"
  elif [ -e "$dst" ]; then
    warn "$dst -> file exists, backing up to ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi

  ln -s "$src" "$dst"
  info "$dst -> $src"
}

echo "=== Dotfiles installer ==="
echo "Dotfiles directory: $DOTFILES_DIR"
echo ""

# ---------- Set environment ----------
if [ ! -f "$HOME/.dotfiles_env" ]; then
  echo "No ~/.dotfiles_env found. Which environment is this?"
  echo "  1) personal"
  echo "  2) work"
  read -rp "Choice [1]: " env_choice
  case "$env_choice" in
    2|work) echo "work" > "$HOME/.dotfiles_env" ;;
    *)      echo "personal" > "$HOME/.dotfiles_env" ;;
  esac
  info "Environment set to: $(cat "$HOME/.dotfiles_env")"
else
  info "Environment already set to: $(cat "$HOME/.dotfiles_env")"
fi

echo ""
echo "--- Linking dotfiles ---"

# Shell
link_file "$DOTFILES_DIR/.zshrc"     "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.zprofile"  "$HOME/.zprofile"
link_file "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"

# Git
link_file "$DOTFILES_DIR/.gitconfig"        "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"

# Set up git local config from example if it doesn't exist
ENV_NAME="$(cat "$HOME/.dotfiles_env")"
if [ ! -f "$HOME/.gitconfig.local" ] && [ -f "$DOTFILES_DIR/git/gitconfig.local.${ENV_NAME}.example" ]; then
  cp "$DOTFILES_DIR/git/gitconfig.local.${ENV_NAME}.example" "$HOME/.gitconfig.local"
  info "Created ~/.gitconfig.local from ${ENV_NAME} example (edit to customize)"
fi

# Editors
link_file "$DOTFILES_DIR/.vimrc"  "$HOME/.vimrc"
link_file "$DOTFILES_DIR/.gvimrc" "$HOME/.gvimrc"

# Neovim
mkdir -p "$HOME/.config/nvim"
if [ -f "$DOTFILES_DIR/config_dir/nvim/init.vim" ]; then
  link_file "$DOTFILES_DIR/config_dir/nvim/init.vim" "$HOME/.config/nvim/init.vim"
fi

# Tmux
link_file "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# Python
link_file "$DOTFILES_DIR/.pythonrc" "$HOME/.pythonrc"

# CTags
link_file "$DOTFILES_DIR/.ctags" "$HOME/.ctags"

# R
if [ -f "$DOTFILES_DIR/.Rprofile" ]; then
  link_file "$DOTFILES_DIR/.Rprofile" "$HOME/.Rprofile"
fi

# Matplotlib
if [ -f "$DOTFILES_DIR/matplotlibrc" ]; then
  mkdir -p "$HOME/.matplotlib"
  link_file "$DOTFILES_DIR/matplotlibrc" "$HOME/.matplotlib/matplotlibrc"
fi

# Karabiner (macOS only)
if [[ "$(uname)" == "Darwin" ]] && [ -d "$DOTFILES_DIR/.config/karabiner" ]; then
  mkdir -p "$HOME/.config"
  link_file "$DOTFILES_DIR/.config/karabiner" "$HOME/.config/karabiner"
fi

# Amethyst (macOS only)
if [[ "$(uname)" == "Darwin" ]] && [ -f "$DOTFILES_DIR/.amethyst" ]; then
  link_file "$DOTFILES_DIR/.amethyst" "$HOME/.amethyst"
fi

echo ""
echo "--- Done! ---"
echo "Environment: $(cat "$HOME/.dotfiles_env")"
echo ""
echo "To switch environments later:"
echo "  echo 'work' > ~/.dotfiles_env     # switch to work"
echo "  echo 'personal' > ~/.dotfiles_env  # switch to personal"
echo "  Then open a new shell."
