# Environment Configuration System

## Overview

your-monorepo apps use `--dart-define-from-file` to inject environment-specific configuration
at build/run time. The env JSON files live in each app's `env/` directory.

## dart-define-from-file

Flutter's `--dart-define-from-file=<path>` reads a JSON file and passes each key-value pair
as a compile-time constant accessible via `const String.fromEnvironment('KEY')` in Dart code.

## Env File Structure

Typical env JSON structure:
```json
{
  "BUILD_FLAVOR": "dev",
  "RUN_LOG_FILE": "env/run_dev.log"
}
```

### Standard Env Files (<app-name>)

| File | Purpose | BUILD_FLAVOR |
|---|---|---|
| `env/dev.json` | Development | `dev` |
| `env/mock.json` | Mock data | `mock` |
| `env/emulator.json` | Emulator testing | (inferred as `dev`) |
| `env/test_db.json` | Test database | `testDB` |
| `env/prod.json` | Production | `prod` |

## BUILD_FLAVOR

Controls app behavior (database root names, debug features, force-exit flags).

### Valid Values
- `prod` - Production
- `dev` - Development
- `mock` - Mock data
- `testDB` - Test database

### In Dart Code
Defined in `lib/utils/build_flavor.dart`:
```dart
const BuildFlavor _buildFlavor = BuildFlavor.dev;
```

For release builds, the app forces `BuildFlavor.prod` regardless of the constant.
The `_buildFlavor` constant only affects debug builds.

### CI Enforcement
`.github/scripts/force_build_flavor.py` ensures:
- `main` branch: `_buildFlavor = BuildFlavor.prod`
- `develop*` branches: `_buildFlavor = BuildFlavor.dev`
- Auto-commits the fix if mismatched

## BUILD_FLAVOR Inference in Scripts

Both build and run scripts infer BUILD_FLAVOR:

1. Read `BUILD_FLAVOR` key from the JSON file (if present)
2. If not in JSON, infer from filename:
   - `dev.json` -> `dev`
   - `prod.json` -> `prod`
   - `mock.json` -> `mock`
   - `test_db.json` / `testdb.json` -> `testDB`
   - `staging.json` / `emulator.json` -> `dev` (with warning)
3. Validate against allowed values
4. Inject as `--dart-define=BUILD_FLAVOR=<value>`

## Adding Env Files for New Apps

Minimum required:
1. `env/dev.json` with `{"BUILD_FLAVOR": "dev"}`
2. `env/prod.json` with `{"BUILD_FLAVOR": "prod"}`

Add app-specific keys as needed (API URLs, feature flags, etc.).
