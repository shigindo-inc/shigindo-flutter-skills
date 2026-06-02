# Sync Procedures

Detailed procedures for syncing each file type from root to app.

## shared-identical: analysis_options.yaml

### Procedure
1. Read root `analysis_options.yaml`
2. Read app's `analysis_options.yaml`
3. Check `intentional_overrides` in manifest for this app
4. Merge using union strategy:
   - **Lint rules:** Union of both. If root enables a rule, enable in app.
   - **Exclude patterns:** Union of both when syncing files manually. Note: Dart
     `include` does **not** merge `analyzer.exclude` — if the app file defines
     its own `exclude` list, it **replaces** the included file's excludes. Apps
     that redefine `exclude` must repeat shared patterns (e.g. `build/**`,
     `**/*.g.dart`) from `analysis_options_base.yaml`.
   - **Severity overrides:** Take root version, preserve app overrides from manifest.
   - **Formatter config:** Root is authoritative (line_length, page_width).
5. Present diff to user
6. Apply if approved
7. Run `flutter analyze` to verify

### Preserving Overrides
If the manifest lists overrides like:
```json
{"analysis_options.yaml": ["added lib/l10n/** exclude"]}
```
Keep those specific patterns even if they're not in the root version.

## shared-identical: .fvmrc

### Procedure
1. Read root `.fvmrc`
2. Copy to app directory
3. Run `fvm use` to activate (if fvm is installed)

## shared-template: scripts/_common.sh

### Procedure
1. Copy root version to app's `scripts/_common.sh`
2. Ensure executable: `chmod +x`
3. No template substitution needed (file is already generic)

## shared-template: scripts/flutter_run_with_env.sh

### Procedure
1. Copy root version
2. Substitute template variables:
   - Header comment: Replace `<APP_NAME>` with actual app name
3. Ensure executable: `chmod +x`
4. Verify the app has the expected `env/*.json` files

## shared-template: scripts/flutter_build_with_env.sh

### Procedure
Same as run script.

## shared-template: Makefile

### Procedure
1. Read root Makefile template
2. Substitute:
   - App name in header comments
   - Verify env file paths match what exists in app's `env/` directory
3. Diff against app's current Makefile
4. Present changes for approval
5. Apply

### Handling Missing Env Files
If the root Makefile references `env/emulator.json` but the app doesn't have it:
- Remove or comment out the corresponding `run-emu` target
- Or create a minimal env file

## shared-template: AGENTS.md

### Procedure
1. Sync sections 1-6 from root (design principles, architecture, workflow, constraints, deletion policy)
2. Keep section 3.4 (wiring SSOT) as app-specific
3. Update section 7 (references) if app has the referenced docs
4. If app doesn't have AGENTS.md yet, copy root template and customize wiring section

## Validation After Sync

After syncing any file, validate:

```bash
cd apps/<app-name>

# If analysis_options.yaml changed
flutter analyze

# If Makefile changed
make help    # verify targets parse correctly

# If scripts changed
./scripts/flutter_run_with_env.sh --help 2>&1 || true  # verify script runs

# Full validation
make check   # if Makefile exists
```
