# Contributing

## Scope

This repository ships Agent Skills only (`skills/*/SKILL.md` and `references/`). It does not contain application code.

## Editing skills

1. Change files under `skills/<name>/`.
2. Keep YAML frontmatter `name` and `description` accurate for auto-triggering.
3. Avoid project-specific names (use `apps/<app-name>/`, placeholders in examples).
4. Test install with `npx skills add . --agent claude-code --yes` from a temp directory.

## Pull requests

- One logical change per PR when possible.
- Update README if install paths or skill list changes.

## Related repos

- [flutter_suite](https://github.com/shigindo-inc/flutter_suite) — dogfoods these skills; monorepo-only skills stay there.
- [aikata](https://github.com/shigindo-inc/aikata) — documentation scaffold CLI (optional companion, no hard dependency).
