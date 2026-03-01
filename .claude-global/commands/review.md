Review the current uncommitted changes:
1. Show `git diff` for all modified files
2. Check for: breaking API changes, missing test updates, CLAUDE.md staleness
3. Run `uv run pytest tests/ -v -m "not slow"` to verify tests pass
4. Report findings and suggest improvements
