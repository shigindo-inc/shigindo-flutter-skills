# Android Release Pipeline

## Full Pipeline

```
Version bump -> Code quality -> Build AAB -> Upload to Play Console -> Review & Rollout
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

## Step 3: Build AAB

```bash
make aab
# Equivalent to:
# BUILD_TARGET=appbundle DART_DEFINE_FILE=env/prod.json ./scripts/flutter_build_with_env.sh
```

Output: `build/app/outputs/bundle/release/app-release.aab`

**Important:** Use AAB (not APK) for Play Store submissions. APK uploads are no longer accepted for new apps.

### Build Requirements
- Android SDK installed
- Signing keystore configured in `android/key.properties` (or `android/app/build.gradle`)
- `env/prod.json` with `BUILD_FLAVOR=prod`

### Common Build Failures
| Error | Fix |
|---|---|
| Gradle dependency resolution | `make clean-android && make pub-get` |
| Keystore not found | Verify `key.properties` path and keystore file |
| SDK version mismatch | Update `compileSdk` / `targetSdk` in `build.gradle` |

## Step 4: Upload to Play Console

Currently manual process:

1. Open Google Play Console
2. Select the app
3. Navigate to **Production** (or appropriate track)
4. Click **Create new release**
5. Upload `build/app/outputs/bundle/release/app-release.aab`
6. Add release notes (in all supported languages)
7. Click **Review release**
8. Click **Start rollout**

### Staged Rollouts
Consider using staged rollouts for production:
- Start with 10-20% of users
- Monitor crash rates and feedback
- Increase to 100% if stable

## Future Automation

Play Store upload can be automated via:
- Fastlane `supply` action
- Google Play Developer API
- GitHub Actions with `r0adkll/upload-google-play`

This is a future improvement candidate.
