---
name: config-promote
description: >
  Promote app-level configuration improvements to the monorepo root (SSOT hub).
  Use when sharing an app's improved config with other apps or generalizing scripts for reuse.
  Triggers on: "promote", "push up config", "share this improvement", "generalize",
  "move to root", "make this shared", "upstream this".
---

# Config Promote (App -> Root)

## Overview

Promotes improvements from `apps/<app-name>/` to the monorepo root so `config-sync` can distribute them (bottom-up flow).

## Promote flow

### Step 1: Identify source

User names app + file, or detect from cwd + mention.

### Step 2: Check manifest

Read `.claude/config-manifest.json` for category and merge strategy.

### Step 3: Generalize

Remove app-specific values before placing at root:

| Pattern | Replace with |
| --- | --- |
| Hard-coded app name | Variable or comment placeholder |
| Firebase project IDs | `<FIREBASE_PROJECT_ID>` |
| Bundle IDs | `<BUNDLE_ID>` |
| Apple team IDs | `<APPLE_TEAM_ID>` |
| Absolute app paths | Relative paths or `<APP_ROOT>` |

See `references/generalization-rules.md`.

### Step 4: Place in root

| Category | Action |
| --- | --- |
| `shared-identical` | Merge at same path (union of rules) |
| `shared-template` | Generalized template at same path |
| `app-specific` | Promote structure only, not secret values |

### Step 5: Confirm with user

Never auto-merge. Show diff and generalized changes; wait for approval.

### Step 6: Propose sync

Suggest running `config-sync` to other apps after promote.

## Override registration

Record intentional per-app differences in `.claude/config-manifest.json` under `intentional_overrides`.

## References

- `references/generalization-rules.md`
- `references/promotable-files.md`
