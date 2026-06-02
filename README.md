---
project: shigindo-flutter-skills
status: active
version: 0.1.0
updated: 2026-06-02
audience: [human, agent]
---

# shigindo-flutter-skills

Opinionated [Agent Skills](https://docs.flutter.dev/ai/agent-skills) for solo and small-team Flutter development: monorepo config harmonization, DevOps commands, and store release workflows.

Maintained by [shigindo-inc](https://github.com/shigindo-inc). Complements the official Dart/Flutter skill sets; does not replace them.

## What is included

| Skill | Purpose |
| --- | --- |
| `flutter-devops` | Build, run, clean, version bump, format, analyze, test (FVM-aware) |
| `config-sync` | Sync shared config from monorepo root to `apps/<name>/` |
| `config-promote` | Promote app-level config improvements to the root (SSOT) |
| `store-release` | App Store / Play Store release pipeline and checklists |
| `widgetbook-catalog` | Component catalog with Widgetbook (manual, no codegen); reuse real theme, extract inline widgets, build web to share |

## Prerequisites

- [Node.js](https://nodejs.org/) (for `npx skills`)
- [skills CLI](https://github.com/vercel-labs/skills) via `npx skills`
- Flutter project; monorepo layout `apps/<app-name>/` is assumed for config skills

## Install these skills

### Channel A — user-global (`npx skills --global`, recommended)

Once per machine (any directory):

```bash
./scripts/install-global-skills.sh
```

This installs shigindo published skills and official flutter/dart skills into `~/.claude/skills/` and universal global paths. Claude Code does **not** read `.agents/skills/` — the script runs both `claude-code` and `universal` targets.

Per-project install (optional):

```bash
npx skills add shigindo-inc/shigindo-flutter-skills --skill '*' --agent claude-code --yes
npx skills add shigindo-inc/shigindo-flutter-skills --skill '*' --agent universal --yes
```

Install a single skill globally:

```bash
npx skills add shigindo-inc/shigindo-flutter-skills --skill flutter-devops --agent claude-code --global --yes
```

### Channel B — Claude Code plugin (optional, user-global)

Inside Claude Code:

```text
/plugin marketplace add shigindo-inc/shigindo-flutter-skills
/plugin install shigindo-flutter-skills@shigindo-flutter-skills
```

### Channel C — Codex plugin (optional, CLI 0.135.0+)

```bash
codex plugin marketplace add shigindo-inc/shigindo-flutter-skills --ref v0.1.0
codex plugin add shigindo-flutter-skills@shigindo-flutter-skills
```

See [dist/README.md](dist/README.md) for distribution layout and rebuild steps.

## Official Dart/Flutter skills (install separately)

Source of truth is GitHub, not npm packages:

- [flutter/skills](https://github.com/flutter/skills)
- [dart-lang/skills](https://github.com/dart-lang/skills)

```bash
npx skills add flutter/skills --skill '*' --agent claude-code --yes
npx skills add dart-lang/skills --skill '*' --agent claude-code --yes

# When you also use Codex / Cursor with .agents/skills/
npx skills add flutter/skills --skill '*' --agent universal --yes
npx skills add dart-lang/skills --skill '*' --agent universal --yes
```

Or run the bundled helper (from this repo or after clone):

```bash
./scripts/install-official.sh
```

Skill names use `flutter-*` and `dart-*` prefixes; this repo uses `config-*`, `flutter-devops`, and `store-release` — no name collisions.

## Claude Code vs `.agents/skills`

Claude Code discovers skills under `.claude/skills/` and `~/.claude/skills/` only. It does **not** read `.agents/skills/` today. Use `--agent claude-code` for Claude, and `--agent universal` when you share the same repo with Codex or Cursor.

To mirror both layouts after a local checkout:

```bash
./scripts/sync-dual-layout.sh /path/to/your/project
```

## Config manifest

Config sync/promote skills expect a root manifest at `.claude/config-manifest.json` (convention). See [references/config-manifest.example.json](references/config-manifest.example.json).

## Update

```bash
npx skills update
```

## Development (dogfooding)

This repo is the SSOT for published skills (`skills/`). After editing skills, run `./scripts/build-dist.sh` before committing plugin artifacts under `dist/`.

[flutter_suite](https://github.com/shigindo-inc/flutter_suite) uses user-global published/official skills and keeps monorepo-only skills (`ui-kit`, `app-foundation`) under its own `skills/` directory (`sync-local-skills.sh` only).

## Documentation (aikata)

This repository is managed with [aikata](https://github.com/shigindo-inc/aikata). Canonical docs for agents and maintainers:

| Purpose | Document |
|---|---|
| What / why | [SPEC.md](./SPEC.md) |
| How (structure) | [ARCHITECTURE.md](./ARCHITECTURE.md) |
| Glossary | [GLOSSARY.md](./GLOSSARY.md) |
| Agent rules | [AGENTS.md](./AGENTS.md) |
| Stack conventions | [docs/stacks/flutter.md](./docs/stacks/flutter.md) |
| Current work | [docs/tasks/current.md](./docs/tasks/current.md) |
| Decisions | [docs/adr/](./docs/adr/) |

After editing canonical docs, run `aikata generate` to refresh tool-specific files.

## License

MIT — see [LICENSE](LICENSE).
