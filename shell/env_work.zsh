# shell/env_work.zsh — Work-specific configuration (Spotify)
# Loaded when DOTFILES_ENV=work

# Claude Code / Vertex AI
export CLAUDE_CODE_USE_VERTEX=1
export ANTHROPIC_SMALL_FAST_MODEL='claude-3-5-haiku@20241022'
export CLOUD_ML_REGION='europe-west1'
export VERTEX_REGION_CLAUDE_4_1_OPUS='europe-west4'
export ANTHROPIC_VERTEX_PROJECT_ID=spotify-claude-code-trial

# Work tooling
export PATH="/opt/spotify-devex/bin:$PATH"

# Work aliases
alias hcn="hendrix compute -n content-safety-analysis"
