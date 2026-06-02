# dist/

Shippable plugin artifacts built from `skills/` SSOT. **Do not hand-edit** —
run `./scripts/build-dist.sh` after changing skills.

## Layout

```
dist/
├── claude-code/plugin/     # Claude Code plugin (skills + plugin.json)
└── codex/plugin/           # Codex plugin (.codex-plugin + skills/)
```

Repository root also has:

- `.claude-plugin/marketplace.json` — self-hosted Claude Code marketplace
- `.agents/plugins/marketplace.json` — self-hosted Codex marketplace

## Install (channel A — project or user via skills CLI)

```bash
npx skills add shigindo-inc/shigindo-flutter-skills --skill '*' --agent claude-code --yes
npx skills add shigindo-inc/shigindo-flutter-skills --skill '*' --agent universal --yes
npx skills update
```

Claude Code reads `.claude/skills/` only; Codex/Cursor use `.agents/skills/` from `--agent universal`.

## Install (channel B — Claude Code plugin, optional)

Inside Claude Code:

```text
/plugin marketplace add shigindo-inc/shigindo-flutter-skills
/plugin install shigindo-flutter-skills@shigindo-flutter-skills
```

## Install (channel C — Codex plugin, optional, CLI 0.135.0+)

```bash
codex plugin marketplace add shigindo-inc/shigindo-flutter-skills --ref v0.1.0
codex plugin add shigindo-flutter-skills@shigindo-flutter-skills
```

Older Codex: use channel A (`npx skills add` with `--agent universal`).

## Rebuild

```bash
./scripts/build-dist.sh
# SKILLS_DIST_VERSION=0.2.0 ./scripts/build-dist.sh
```

`dist/` is committed to git (same policy as [aikata](https://github.com/shigindo-inc/aikata)).
