---
name: store-release
description: >
  App Store and Play Store release pipeline, Fastlane integration, and submission checklists
  for Flutter apps. Use when releasing, uploading to stores, Fastlane setup, or review prep.
  Triggers on: "release", "app store", "play store", "fastlane", "upload", "submit",
  "review guidelines", "screenshots", "metadata", "testflight".
---

# Store Release

## Overview

End-to-end release workflow for App Store and Google Play. Assumes optional Makefile + Fastlane under `apps/<app-name>/` or project root.

## Release pipeline

1. Version bump (`make bump` or edit `pubspec.yaml`)
2. Code quality (`make check` or analyze + test)
3. Build (`make ipa` / `make aab` or build scripts)
4. Upload (Fastlane or store consoles)
5. Verify processing in App Store Connect / Play Console

## iOS (Fastlane pattern)

```bash
make bump
make check
make release-ios   # when defined: build IPA + fastlane release
```

Manual steps:

```bash
make ipa
cd ios && bundle exec fastlane release
```

Typical paths: `ios/fastlane/Fastfile`, `ios/fastlane/Appfile`, IPA under `build/ios/ipa/`.

## Android

```bash
make bump
make check
make aab
```

Output often at `build/app/outputs/bundle/release/app-release.aab`. Upload via Play Console (manual or CI).

## Pre-submission checklist (summary)

### Version and quality

- [ ] Version and build number incremented
- [ ] `flutter analyze` / `make check` clean
- [ ] Production env (`env/prod.json` or equivalent), not dev/mock

### iOS

- [ ] Signing and profiles valid
- [ ] `EXPORT_METHOD=app-store` for store builds

### Android

- [ ] Release keystore configured
- [ ] AAB (not APK) for Play production

See `references/release-checklist.md` and `references/review-guidelines.md`.

## References

- `references/ios-release-pipeline.md`
- `references/android-release-pipeline.md`
- `references/fastlane-setup.md`
- `references/release-checklist.md`
- `references/review-guidelines.md`
