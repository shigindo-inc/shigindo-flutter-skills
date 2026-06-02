# Release Checklist

## Pre-Release

### Code
- [ ] All features for this release are merged
- [ ] `make check` passes (format + analyze + test)
- [ ] No TODO/FIXME items blocking release
- [ ] All critical bugs fixed

### Version
- [ ] Version bumped appropriately (`make bump-patch/minor/major`)
- [ ] Build number incremented (`make bump`)
- [ ] `make v` shows expected version
- [ ] Version in pubspec.yaml matches intended release

### Configuration
- [ ] `env/prod.json` is correct and complete
- [ ] BUILD_FLAVOR is `prod` (check `lib/utils/build_flavor.dart`)
- [ ] All debug/dev feature flags are OFF in prod config
- [ ] No dev-only dependencies in release build

### Git
- [ ] All changes committed
- [ ] Branch is up to date with develop
- [ ] CI passes on the PR to main

## iOS Release

### Build
- [ ] `make ipa` succeeds
- [ ] IPA exists at `build/ios/ipa/*.ipa`
- [ ] Signed with App Store distribution certificate
- [ ] Correct provisioning profile

### Upload
- [ ] `make release-ios` or `cd ios && bundle exec fastlane release`
- [ ] Build appears in App Store Connect
- [ ] Processing completes without errors

### App Store Connect
- [ ] App description up to date
- [ ] Screenshots current (all required sizes)
- [ ] Privacy policy URL valid
- [ ] Support URL valid
- [ ] What's New text written
- [ ] Age rating correct
- [ ] Review notes added (if needed for reviewer)

## Android Release

### Build
- [ ] `make aab` succeeds
- [ ] AAB exists at `build/app/outputs/bundle/release/app-release.aab`
- [ ] Signed with upload key

### Upload
- [ ] AAB uploaded to Play Console
- [ ] Release notes written (all languages)
- [ ] Rollout percentage set (consider staged rollout)

### Play Console
- [ ] App description up to date
- [ ] Screenshots current
- [ ] Data safety section accurate
- [ ] Content rating current
- [ ] Privacy policy URL valid

## Post-Release

- [ ] Build appears in TestFlight / Internal testing
- [ ] Smoke test on real device
- [ ] Monitor crash reports (Crashlytics) for 24-48 hours
- [ ] Merge develop -> main (or create release tag)
- [ ] Announce release to stakeholders
