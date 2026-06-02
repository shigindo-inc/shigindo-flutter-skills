# iOS Release Pipeline

## Full Pipeline

```
Version bump -> Code quality -> Build IPA -> Upload via Fastlane -> Verify in App Store Connect
```

## Step 1: Version Bump

```bash
make bump          # or bump-patch/bump-minor/bump-major
make v             # verify version
```

## Step 2: Code Quality

```bash
make check         # format-check + analyze + test
```

All must pass before proceeding.

## Step 3: Build IPA

```bash
make ipa
# Equivalent to:
# BUILD_TARGET=ipa DART_DEFINE_FILE=env/prod.json EXPORT_METHOD=app-store ./scripts/flutter_build_with_env.sh
```

Output: `build/ios/ipa/*.ipa`

### Build Requirements
- Xcode installed with valid signing certificates
- Provisioning profile for App Store distribution
- `env/prod.json` with `BUILD_FLAVOR=prod`

### Common Build Failures
| Error | Fix |
|---|---|
| "No signing certificate" | Open Xcode, check Signing & Capabilities |
| "Provisioning profile expired" | Regenerate in Apple Developer Portal |
| CocoaPods error | `make pods` |
| Archive failed | `make rebuild` then retry |

## Step 4: Upload via Fastlane

```bash
cd ios && bundle exec fastlane release
# Or combined:
make release-ios   # runs build-ipa first, then fastlane release
```

### What Fastlane Does
1. Finds the IPA in `../build/ios/ipa/`
2. Uploads to App Store Connect via `upload_to_app_store`
3. Reports success/failure

### Fastlane Authentication
Fastlane uses App Store Connect API or Apple ID credentials.
Configure via environment variables or `ios/fastlane/Appfile`.

### Current Appfile Config
- Bundle ID: configured per app
- Apple ID: developer email
- Team IDs: for App Store Connect and Developer Portal

## Step 5: Verify

After upload:
1. Open App Store Connect
2. Check the build appears under TestFlight or the app's builds
3. Wait for processing (usually 10-30 minutes)
4. If processing fails, check for compliance issues

## Screenshots

```bash
make fastlane-screenshots
# Generates screenshots on iPhone 15 via Fastlane snapshot
```

Screenshots are stored in `ios/fastlane/screenshots/`.
