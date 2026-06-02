# Promotable Files

Files that can be promoted from an app to the monorepo root.

## shared-identical Files

Files that should be the same (or near-identical) across all apps.

### analysis_options.yaml
- **Merge strategy:** `union`
- **Promote procedure:**
  1. Read app version and root version
  2. Diff lint rules: take union (if app enables a rule, add it to root)
  3. Diff exclude patterns: take union
  4. Diff severity overrides: take union (stricter wins)
  5. Present merged result for approval
- **Known overrides:** Some apps may have extra exclude patterns for generated code

### .fvmrc
- **Merge strategy:** `copy`
- **Promote procedure:**
  1. Compare Flutter SDK version
  2. If app has newer version, propose updating root
  3. If app has older version, suggest syncing from root instead
- **Note:** All apps should use the same Flutter SDK version

## shared-template Files

Files that share structure but contain app-specific values.

### scripts/_common.sh
- **Merge strategy:** `copy`
- **Promote procedure:**
  1. Diff against root version
  2. If app has improvements (new error patterns, better detection), promote
  3. This file is already generic (no app-specific values)

### scripts/flutter_run_with_env.sh
- **Merge strategy:** `template`
- **Promote procedure:**
  1. Diff against root version
  2. Check for app-specific references in header comment
  3. Generalize header comment
  4. Promote improvements to BUILD_FLAVOR handling, logging, etc.

### scripts/flutter_build_with_env.sh
- **Merge strategy:** `template`
- **Promote procedure:** Same as run script

### Makefile
- **Merge strategy:** `template`
- **Promote procedure:**
  1. Diff target definitions
  2. New targets in app -> add to root template
  3. Modified targets -> compare and take better version
  4. App-specific env file references: generalize to `env/<flavor>.json`
  5. App name in comments: replace with `<APP_NAME>`

### AGENTS.md
- **Merge strategy:** `template`
- **Promote procedure:**
  1. Sections 1-6 (principles, architecture, workflow, constraints): promote improvements
  2. Section 3.4 (wiring): app-specific, do not promote values
  3. Section 7 (references): may reference app-specific docs

## app-specific Files (structure only)

### env/*.json
- **What to promote:** Key names and structure (not values)
- **Root template:** Document expected keys with placeholder values

### ios/fastlane/Appfile
- **What to promote:** Template structure showing required fields
- **Never promote:** Actual team IDs, bundle IDs, Apple IDs

### ios/fastlane/Fastfile
- **What to promote:** Lane definitions (logic is reusable)
- **Generalize:** Remove any app-specific path references

## Promotion Checklist

For any file promotion:
1. [ ] Identified source app and file
2. [ ] Checked manifest for category and strategy
3. [ ] Applied generalization rules
4. [ ] Generated diff with root version
5. [ ] Presented diff to user
6. [ ] User approved changes
7. [ ] Applied to root
8. [ ] Updated manifest if needed (new overrides discovered)
9. [ ] Suggested sync to other apps
