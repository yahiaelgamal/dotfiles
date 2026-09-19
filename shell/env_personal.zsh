# shell/env_personal.zsh — Personal environment configuration
# Loaded when DOTFILES_ENV=personal

# Add personal-specific environment variables, aliases, and PATH entries here.
# Examples:
#   export ANTHROPIC_API_KEY='...'  # (keep secrets in ~/.secrets instead)
#   alias projects="cd ~/projects"

# Override corporate PyPI index (injected by /etc/zshenv) so personal projects use public PyPI
unset PIP_INDEX_URL
unset PIP_EXTRA_INDEX_URL
unset PIPENV_PYPI_MIRROR
unset UV_DEFAULT_INDEX
unset YARN_NPM_REGISTRY_SERVER
unset YARN_REGISTRY
unset NPM_CONFIG_REGISTRY
