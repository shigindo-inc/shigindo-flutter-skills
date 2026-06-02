# Makefile Targets Reference

Complete reference for all Makefile targets available in your-monorepo apps.
Extracted from `apps/<app-name>/Makefile` as the canonical source.

## Section A: Pod / iOS Setup

| Target | Description | Command |
|---|---|---|
| `pods` | Pod reinstall (delete Pods/ & Podfile.lock first) | `cd ios && rm -rf Pods Podfile.lock && pod install` |
| `pod-i` | Pod install | `cd ios && pod install` |
| `pod-u` | Pod update | `cd ios && pod update` |
| `setup-ios` | Full iOS setup (pods + open Xcode) | Runs `pods` then `open-x` |
| `open-x` | Open Xcode workspace | `open ios/Runner.xcworkspace` |

## Section B: Clean Commands

| Target | Description | Scope |
|---|---|---|
| `clean` | flutter clean | Flutter cache only |
| `clean-ios` | Delete iOS build artifacts | Pods, Podfile.lock, .symlinks, build/ios |
| `clean-android` | Delete Android artifacts + gradlew clean | build/app, gradlew clean |
| `deep-clean` | Full clean (all platforms) | clean + clean-ios + clean-android + .dart_tool, .packages |
| `rebuild` | Deep clean + restore | deep-clean + pub get + pod install |

## Section C: Run Commands

All delegate to `flutter_run_with_env.sh`:

| Target | Env File | Alias |
|---|---|---|
| `run-dev` | `env/dev.json` | `dev` |
| `run-mock` | `env/mock.json` | `mock` |
| `run-emu` | `env/emulator.json` | - |
| `run-testdb` | `env/test_db.json` | - |
| `run-prod` | `env/prod.json` | `prod` |

## Section D: Build Commands

All delegate to `flutter_build_with_env.sh`:

| Target | BUILD_TARGET | Env File | EXPORT_METHOD | Alias |
|---|---|---|---|---|
| `build-apk` | apk | env/dev.json | - | `apk` |
| `build-apk-prod` | apk | env/prod.json | - | - |
| `build-aab` | appbundle | env/prod.json | - | `aab` |
| `build-ipa` | ipa | env/prod.json | app-store | `ipa` |
| `build-ipa-adhoc` | ipa | env/dev.json | ad-hoc | - |

## Section E: Version Management

| Target | Description | Alias |
|---|---|---|
| `show-version` | Show current version (e.g. 0.6.0 (38)) | `v` |
| `bump` | Increment build number +1 | `b` |
| `bump-patch` | Bump patch version, reset build to 1 | - |
| `bump-minor` | Bump minor version, reset patch & build | - |
| `bump-major` | Bump major version, reset all lower | - |
| `set-version` | Set version interactively | - |

## Section F: Code Quality

| Target | Description |
|---|---|
| `pub-get` | `flutter pub get` |
| `format` | `dart format --line-length=160 .` |
| `format-check` | `dart format --line-length=160 --output=none --set-exit-if-changed .` |
| `analyze` | `flutter analyze` |
| `test` | `flutter test` |
| `check` | `format-check` + `analyze` + `test` (all checks) |
| `gen-l10n` | `flutter gen-l10n` |
| `build-runner` | `dart run build_runner build --delete-conflicting-outputs` |

## Section G: Fastlane

| Target | Description |
|---|---|
| `release-ios` | Build IPA + upload to App Store via Fastlane |
| `fastlane-screenshots` | Generate iOS screenshots via Fastlane |

## Variables

```makefile
PUBSPEC       := pubspec.yaml
LINE_LENGTH   := 160
RUN_SCRIPT    := ./scripts/flutter_run_with_env.sh
BUILD_SCRIPT  := ./scripts/flutter_build_with_env.sh
```

Flutter is auto-detected: fvm local > fvm global > system flutter.
