# Generalization Rules

Rules for converting app-specific configurations into reusable root templates.

## String Replacements

When promoting a file from `apps/<name>/` to root, apply these substitutions:

### App Identity

| Pattern | Replacement | Example |
|---|---|---|
| Hard-coded app name | `<APP_NAME>` or remove | `<app-name>` -> `<APP_NAME>` |
| Bundle ID | `<BUNDLE_ID>` | `com.virtual.<app-name>` -> `<BUNDLE_ID>` |
| Display name in strings | `<APP_DISPLAY_NAME>` | `"KnocQnow"` -> `<APP_DISPLAY_NAME>` |

### Firebase / Backend

| Pattern | Replacement |
|---|---|
| Firebase project ID | `<FIREBASE_PROJECT_ID>` |
| Firebase app ID | `<FIREBASE_APP_ID>` |
| API keys | `<API_KEY>` (never commit real keys) |
| Database URLs | `<DATABASE_URL>` |

### Apple Developer

| Pattern | Replacement |
|---|---|
| Apple Team ID | `<APPLE_TEAM_ID>` |
| App Store Connect Team ID | `<ITC_TEAM_ID>` |
| Apple Developer email | `<APPLE_ID>` |

### Paths

| Pattern | Replacement |
|---|---|
| Absolute path to specific app | Relative path from app root |
| `apps/<app-name>/` prefix | `apps/<APP_NAME>/` |

## File-Type Specific Rules

### Makefile
- App name in comments: generalize
- Env file paths: keep as `env/<flavor>.json` (same across apps)
- Script paths: keep as `./scripts/<name>.sh` (same relative structure)
- Line length variable: keep as-is (shared standard)

### Shell Scripts (_common.sh, build/run scripts)
- Generally already generic (no app-specific references)
- Header comment may mention app name: replace with `<APP_NAME>`
- If script references specific env filenames beyond the standard set, note them

### analysis_options.yaml
- Exclude patterns: keep all (union strategy)
- Lint rules: keep all (union strategy, enable takes precedence)
- Severity overrides: keep all
- App-specific generated code paths: mark as app-specific in comments

### Fastlane (Appfile, Fastfile)
- Appfile: all values are app-specific -> template only
- Fastfile: lanes are generally reusable -> promote logic, not IDs

### AGENTS.md
- Core principles (sections 1-6): shared, promote as-is
- Wiring section (3.4): app-specific -> template with placeholder

## Decision Tree

When promoting a file:

1. **Is the file identical across apps?** -> Promote as `shared-identical`
2. **Does the file have app-specific values but shared structure?** -> Promote as `shared-template`, apply substitutions above
3. **Is the file inherently per-app?** -> Promote structure only as documentation

## What NOT to Generalize

- Actual secret values (API keys, passwords) - these should never be in the repo
- App-specific business logic
- Generated files (firebase_options.dart, *.g.dart)
- Platform-specific config that's auto-generated (Xcode project settings, Gradle wrapper)
