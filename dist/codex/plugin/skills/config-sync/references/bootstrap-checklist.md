# Bootstrap Checklist

Complete setup checklist for standardizing a new or bare app with the monorepo's shared tooling.

## Prerequisites

- App exists under `apps/<app-name>/`
- App has a valid `pubspec.yaml`
- Flutter SDK available (preferably via fvm)

## Step-by-Step

### 1. Flutter Version Manager (.fvmrc)

```bash
cp .fvmrc apps/<app-name>/
cd apps/<app-name> && fvm use
```

**Verify:** `fvm flutter --version` shows expected version.

### 2. Build/Run Scripts

```bash
mkdir -p apps/<app-name>/scripts/
cp scripts/_common.sh apps/<app-name>/scripts/
cp scripts/flutter_run_with_env.sh apps/<app-name>/scripts/
cp scripts/flutter_build_with_env.sh apps/<app-name>/scripts/
chmod +x apps/<app-name>/scripts/*.sh
```

**Customize:**
- Update header comments with app name
- Verify BUILD_FLAVOR enum values match app's `build_flavor.dart` (if it has one)

**Verify:** `cd apps/<app-name> && DART_DEFINE_FILE=env/dev.json ./scripts/flutter_run_with_env.sh --help` (or similar smoke test)

### 3. Environment Files

```bash
mkdir -p apps/<app-name>/env/
```

Create minimum env files:

**env/dev.json:**
```json
{
  "BUILD_FLAVOR": "dev"
}
```

**env/prod.json:**
```json
{
  "BUILD_FLAVOR": "prod"
}
```

Add app-specific keys as needed (API URLs, feature flags, etc.).

### 4. Analysis Options

```bash
cp analysis_options.yaml apps/<app-name>/
```

**Customize:**
- Add app-specific exclude patterns for generated code
- Verify `include: package:flutter_lints/flutter.yaml` matches app's dependency

**Verify:** `cd apps/<app-name> && flutter analyze`

### 5. Makefile

Copy root Makefile template and customize:

**Required changes:**
- Header comment: update app name
- Verify `RUN_SCRIPT` and `BUILD_SCRIPT` paths
- Verify env file targets match actual `env/*.json` files
- Remove targets for env files that don't exist

**Verify:** `cd apps/<app-name> && make help`

### 6. AGENTS.md

Copy root template:
```bash
cp AGENTS.md apps/<app-name>/
```

**Customize:**
- Section 3.4 (Wiring SSOT): Fill in app-specific DI, routing, provider info
- Section 3.5 (Generated files): List app-specific generated files
- Section 7 (References): List app-specific docs

### 7. Scripts README

Create `scripts/README.md` documenting available scripts and make targets.
Can copy from <app-name> and adjust.

### 8. Final Validation

```bash
cd apps/<app-name>
make pub-get        # or: flutter pub get
make format-check   # or: dart format --line-length=160 --output=none --set-exit-if-changed .
make analyze        # or: flutter analyze
make test           # or: flutter test
make check          # all of the above
```

All commands should pass. Fix any issues before considering bootstrap complete.

## Post-Bootstrap

- [ ] Register the app in `config-manifest.json` intentional_overrides (if any known differences)
- [ ] Run config-harmonizer to verify alignment with other apps
- [ ] Consider adding CI workflows (copy from <app-name> and customize)

## Optional Additions

These can be added later as needed:

- **Fastlane:** `cd ios && bundle exec fastlane init`
- **CI/CD workflows:** `.github/workflows/`
- **Git hooks:** Pre-commit format check
- **CLAUDE.md:** Pointer to AGENTS.md
