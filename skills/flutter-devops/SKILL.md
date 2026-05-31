---
name: flutter-devops
description: >
  Build, run, clean, version management, and code quality for Flutter apps in a monorepo
  or single-package repo. Use when the user asks to build, run, clean, bump version, format,
  analyze, test, or perform dev-ops on a Flutter app.
  Triggers on: "build", "run", "bump", "clean", "format", "analyze", "test", "check", "dev",
  "prod", "apk", "aab", "ipa", "pub get", "rebuild", "deep clean", "version", "fvm".
---

# Flutter DevOps

## Overview

Unified build/run/clean/version/quality workflows for Flutter apps. In a monorepo, apps typically live under `apps/<app-name>/`. In a single-package repo, use the repository root as the app root.

Prefer **FVM** when `.fvmrc` or `.fvm/flutter_sdk` exists; otherwise use `flutter` on PATH. Override with `FLUTTER_BIN` if needed.

## App detection

1. If cwd is `apps/<app-name>/` (or a subdirectory), that is the target app.
2. If the user names an app explicitly, use that.
3. If cwd is the repo root and layout is single-package, use the root.
4. If ambiguous, ask which app.

## Command routing

| App has... | Route commands via |
| --- | --- |
| `Makefile` | `make <target>` (preferred when present) |
| `scripts/*.sh` only | `./scripts/<script>.sh` with env vars |
| Neither | `fvm flutter` or `flutter` directly |

## Build and run (Makefile pattern)

When a Makefile exists (common in mature apps):

```bash
make dev          # example: DART_DEFINE_FILE=env/dev.json
make prod         # example: DART_DEFINE_FILE=env/prod.json
make apk          # dev APK
make aab          # Play Store AAB
make ipa          # App Store IPA (EXPORT_METHOD=app-store)
```

## Build and run (scripts pattern)

```bash
DART_DEFINE_FILE=env/dev.json ./scripts/flutter_run_with_env.sh
BUILD_TARGET=apk DART_DEFINE_FILE=env/dev.json ./scripts/flutter_build_with_env.sh
```

Typical build script variables:

- `BUILD_TARGET`: `apk`, `appbundle`, `ipa`
- `DART_DEFINE_FILE`: path to env JSON (e.g. `env/dev.json`)
- `EXPORT_METHOD` (ipa): `app-store`, `ad-hoc`, `development`, `enterprise`
- `FLUTTER_BUILD_MODE` (optional): `debug`, `release`, `profile`

See `references/build-and-run-scripts.md` when present in the app.

## Version management

`pubspec.yaml` is the SSOT: `MAJOR.MINOR.PATCH+BUILD`.

When Makefile targets exist:

```bash
make v             # show version
make bump          # increment build number
make bump-patch    # bump patch, reset build
```

CI may validate that build numbers increase on release branches.

## Code quality

```bash
make format-check  # or: dart format --set-exit-if-changed .
make format        # auto-fix
make analyze       # fvm flutter analyze / flutter analyze
make test          # fvm flutter test
make check         # format + analyze + test
```

Follow the project's `analysis_options.yaml` for line length and lints (many teams use 80 or 160 columns).

Optional codegen:

```bash
make gen-l10n
make build-runner  # dart run build_runner build --delete-conflicting-outputs
```

## Clean and rebuild

| Command (examples) | Scope |
| --- | --- |
| `make clean` | `flutter clean` |
| `make clean-ios` / `clean-android` | platform artifacts |
| `make deep-clean` | clean + `.dart_tool` |
| `make rebuild` | deep-clean + pub get + pods |

## Flutter binary detection

Scripts often resolve Flutter in order:

1. `.fvm/flutter_sdk/bin/flutter`
2. `fvm flutter`
3. `flutter`

## References

- `references/makefile-targets.md`
- `references/build-and-run-scripts.md`
- `references/env-system.md`
- `references/version-management.md`
