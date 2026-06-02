# Version Management

## Version Format

`MAJOR.MINOR.PATCH+BUILD` (e.g. `0.6.0+38`)

- **MAJOR**: Breaking changes or major milestones
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes
- **BUILD**: Auto-incrementing build number (must always increase)

## SSOT

`pubspec.yaml` is the single source of truth for version:
```yaml
version: 0.6.0+38
```

## Makefile Commands

| Command | Before | After | Notes |
|---|---|---|---|
| `make bump` | 0.6.0+38 | 0.6.0+39 | Build number +1 |
| `make bump-patch` | 0.6.0+38 | 0.6.1+1 | Patch +1, build reset to 1 |
| `make bump-minor` | 0.6.0+38 | 0.7.0+1 | Minor +1, patch & build reset |
| `make bump-major` | 0.6.0+38 | 1.0.0+1 | Major +1, all lower reset |
| `make set-version` | - | (interactive) | Prompts for full version string |
| `make v` | - | 0.6.0 (38) | Display only |

## CI Version Validation

`.github/scripts/validate_version.py` runs on PRs to main:

### Rules
1. Version format must match `x.y.z+w` (all integers)
2. Source (PR branch) version must be greater than target (main) version
3. Build number must always increase
4. Source and target versions must not be identical

### How It Works
1. Checks out base branch, reads `pubspec.yaml` version
2. Checks out head branch, reads `pubspec.yaml` version
3. Compares: source > target for semver, source build > target build

### Failure Scenarios
- Same version on both branches: "Source and target must not be the same"
- Source version lower: "Source version must be greater than target"
- Build number not incremented: "Build number must be incremented"

## CI Build Flavor Enforcement

`.github/scripts/force_build_flavor.py` ensures correct BUILD_FLAVOR:

- On `main`: Forces `BuildFlavor.prod` in `lib/utils/build_flavor.dart`
- On `develop*`: Forces `BuildFlavor.dev`
- Auto-commits if a change is needed
- Can run in `--check-only` mode (exit 0 = correct, exit 1 = needs update)

## Release Version Workflow

1. During development: `make bump` as needed (increment build number)
2. For feature releases: `make bump-minor` (or `bump-patch` for fixes)
3. Before PR to main: Ensure version > main's version
4. CI validates automatically on PR
