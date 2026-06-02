---
name: config-sync
description: >
  Sync shared configurations from the monorepo root (SSOT hub) to individual apps under apps/.
  Use when applying root configs to an app, bootstrapping a new app, or pulling latest shared settings.
  Triggers on: "sync", "pull configs", "bootstrap", "setup new app", "apply root config",
  "standardize", "initialize app tooling".
---

# Config Sync (Root -> App)

## Overview

Syncs shared configuration from the monorepo root to `apps/<app-name>/` (top-down flow). Pair with `config-promote` for bottom-up improvements.

## Sync flow

### Step 1: Identify target

- User specifies explicitly (e.g. "sync configs to my-app"), or
- Detect from cwd under `apps/<app-name>/`

### Step 2: Read manifest

Read `.claude/config-manifest.json` at the repo root for:

- `harmonizable_files` (path, category, merge_strategy)
- `intentional_overrides` per app

See [references/config-manifest.example.json](../../references/config-manifest.example.json) in this skill repo for a starter schema.

### Step 3: Check overrides

Preserve aspects registered under `intentional_overrides.<app-name>`.

### Step 4: Generate diffs

For each harmonizable file: compare root vs app, skip if identical.

### Step 5: Apply with confirmation

Show diff, wait for user approval, apply per merge strategy.

### Step 6: Validate

```bash
cd apps/<app-name> && fvm flutter analyze
# or: flutter analyze
```

## Override preservation (example)

```json
{
  "intentional_overrides": {
    "my-app": {
      "analysis_options.yaml": ["added lib/l10n/** exclude"]
    }
  }
}
```

## Merge strategies

| Strategy | Behavior |
| --- | --- |
| `copy` | Replace app file with root (respect overrides) |
| `union` | Combine rules / excludes |
| `template` | Apply root template with app-specific substitution |

Template placeholders: app directory name, `env/*.json` paths, bundle IDs from native config.

## Bootstrap mode (new app)

1. `.fvmrc` — copy from root
2. `scripts/` — copy `_common.sh`, `flutter_run_with_env.sh`, `flutter_build_with_env.sh`; generalize app name
3. `env/` — at least `dev.json` and `prod.json` (e.g. `{"BUILD_FLAVOR": "dev"}`)
4. `analysis_options.yaml` — sync from root; add generated-code excludes if needed
5. `Makefile` — from root template; substitute app name and env paths
6. `AGENTS.md` — from root template; fill app-specific wiring
7. Validate: `make check` or `flutter analyze` + `flutter test`

## References

- `references/sync-procedures.md`
- `references/bootstrap-checklist.md`
