# Build and Run Scripts Reference

## Scripts Overview

| Script | Purpose |
|---|---|
| `scripts/_common.sh` | Shared helpers (Flutter detection, failure hints) |
| `scripts/flutter_run_with_env.sh` | Run app with dart-define-from-file injection |
| `scripts/flutter_build_with_env.sh` | Build APK/AAB/IPA with dart-define-from-file injection |

## _common.sh

Shared helpers sourced by other scripts. Not executed directly.

### `_detect_flutter()`
Sets `_flutter_cmd` array. Priority:
1. `FLUTTER_BIN` env var (if set)
2. `${PROJECT_ROOT}/.fvm/flutter_sdk/bin/flutter` (local fvm)
3. `fvm flutter` (global fvm command)
4. `flutter` (system)
5. Error exit if none found

### `_print_failure_hints(log_file)`
Scans log file for known error patterns and prints recovery suggestions:

| Pattern | Suggestion |
|---|---|
| CocoaPods errors | `make pods` |
| Gradle dependency errors | `make clean-android && make pub-get` |
| pub get not run | `make pub-get` or `make rebuild` |

## flutter_run_with_env.sh

### Environment Variables

| Variable | Required | Default | Description |
|---|---|---|---|
| `DART_DEFINE_FILE` | Yes | - | Path to env JSON (e.g. `env/dev.json`) |
| `LOG_FILE` | No | `env/run_<env>.log` | Log file path |
| `LOG_FILE_TRUNCATE` | No | - | Set to `true`/`1` to truncate log before run |
| `FLUTTER_BIN` | No | auto-detect | Override Flutter binary |

### Behavior
1. Changes to project root directory
2. Sources `_common.sh` and detects Flutter
3. Validates `DART_DEFINE_FILE` exists
4. Infers `BUILD_FLAVOR` from JSON content or filename
5. Resolves log file (from JSON `RUN_LOG_FILE` field or default)
6. Injects `--dart-define-from-file` and `--dart-define=BUILD_FLAVOR=<value>`
7. Runs `flutter run` with tee to log file
8. On failure, calls `_print_failure_hints`

### BUILD_FLAVOR Inference
Priority:
1. `BUILD_FLAVOR` key in the JSON file
2. Filename-based inference: `dev.json` -> `dev`, `prod.json` -> `prod`, etc.
3. Special mappings: `stg`/`staging`/`emulator`/`emu` -> `dev` (with note)

Valid values: `prod`, `dev`, `mock`, `testDB`

### VSCode Machine Mode
When `--machine` flag is detected, stdout and stderr are kept separate (required by VSCode's flutter run integration).

## flutter_build_with_env.sh

### Environment Variables

| Variable | Required | Default | Description |
|---|---|---|---|
| `BUILD_TARGET` | Yes | - | `apk`, `appbundle`, or `ipa` |
| `DART_DEFINE_FILE` | Yes | - | Path to env JSON |
| `EXPORT_METHOD` | For ipa | - | `app-store`, `ad-hoc`, `development`, `enterprise` |
| `FLUTTER_BUILD_MODE` | No | `release` | `debug`, `release`, or `profile` |
| `FLUTTER_BIN` | No | auto-detect | Override Flutter binary |

### Behavior
1. Changes to project root directory
2. Sources `_common.sh` and detects Flutter
3. Validates required env vars and files
4. Infers BUILD_FLAVOR (same logic as run script)
5. Builds with `flutter build <target> --<mode> --dart-define-from-file=<file>`
6. For IPA: adds `--export-method=<method>`
7. On failure, calls `_print_failure_hints`

### Output Locations
- APK: `build/app/outputs/flutter-apk/app-release.apk`
- AAB: `build/app/outputs/bundle/release/app-release.aab`
- IPA: `build/ios/ipa/*.ipa`
