---
name: widgetbook-catalog
description: >
  Set up and grow a Flutter component catalog with Widgetbook (manual, no code generation),
  reusing the app's real theme and design tokens. Use when the user wants a component
  gallery/showcase, a shareable UI catalog, to document widgets, or to extract inline screen
  widgets into reusable, cataloged components.
  Triggers on: "widgetbook", "component catalog", "component gallery", "storybook", "showcase",
  "widget catalog", "design system catalog", "share components", "extract widget".
---

# Widgetbook Component Catalog

## Overview

Build a component catalog **as code** instead of in a design tool. The catalog reuses the app's
real `ThemeData` and design tokens, so it never drifts from the app, costs nothing, and can be
shared with reviewers as a static web build.

This skill uses **manual Widgetbook** (no `build_runner` / no codegen): you compose a
`directories: [...]` tree by hand. Prefer this when the app has no codegen pipeline. The
annotation + generator approach is an optional later migration.

Prefer **FVM** when `.fvmrc` / `.fvm/flutter_sdk` exists; otherwise `flutter` on PATH.

## App detection

In a monorepo, the target app is usually `apps/<app-name>/`. If cwd is inside an app, use it; if
the user names an app, use that; if the repo is single-package, use the root; if ambiguous, ask.

## Setup (one time)

1. Add the dev-dependency to the app's `pubspec.yaml`:
   ```yaml
   dev_dependencies:
     widgetbook: ^3.x   # pin the current major from pub.dev
   ```
   `widgetbook` is catalog-only — never import it from shipped code outside `lib/widgetbook/`.
2. `fvm flutter pub get`.
3. Create the catalog under `lib/widgetbook/`:
   - `main.dart` — the entrypoint (`Widgetbook.material(addons: [...], directories: [...])`).
   - `theme_wrapper.dart` — a small helper that frames each use-case (background, padding).
   - `use_cases/*.dart` — one file per component group, each returning a `WidgetbookComponent`.
   - `fixtures.dart` — sample model instances for widgets that need domain data.
4. Reuse the **real** theme and localization via addons — do not hardcode token values:
   ```dart
   Widgetbook.material(
     addons: [
       MaterialThemeAddon(themes: [WidgetbookTheme(name: '<app>', data: buildAppTheme())]),
       LocalizationAddon(locales: const [Locale('ja')], localizationsDelegates: GlobalMaterialLocalizations.delegates),
       TextScaleAddon(),
     ],
     directories: [ /* WidgetbookFolder / WidgetbookComponent tree */ ],
   );
   ```

See [references/setup-checklist.md](references/setup-checklist.md) for the full skeleton and
[references/use-case-patterns.md](references/use-case-patterns.md) for the manual directory API.

## Add components

- Catalog already-public widgets and theme-driven Material widgets first (buttons, inputs, nav) —
  these need no refactor and get a working catalog fast.
- For widgets currently inline/private inside screens, **extract them to public, presentational
  widgets**, then catalog them. See [references/extraction-pattern.md](references/extraction-pattern.md).
  - Feature-agnostic widgets → `lib/shared/widgets/`.
  - Widgets coupled to a feature's domain model → `lib/features/<feature>/presentation/widgets/`.
  - Pass side effects (navigation, callbacks) in from the screen so the widget stays presentational.
  - The screen imports the extracted widget; behavior must stay identical.

## Verify

- `fvm flutter analyze` is clean.
- `fvm flutter test` passes — extraction must not change screen behavior. If the app lacks unit
  coverage for the extracted widgets, rely on the existing screen-level widget tests plus a visual
  pass; say so honestly rather than implying guaranteed no-regression.
- Run the catalog: `fvm flutter run -t lib/widgetbook/main.dart -d chrome`.

## Share

Build a static bundle and serve it for reviewers — see [references/web-build-share.md](references/web-build-share.md):

```bash
fvm flutter build web -t lib/widgetbook/main.dart   # outputs build/web/
```

Add Makefile targets when the app uses a Makefile:

```makefile
WIDGETBOOK_TARGET := lib/widgetbook/main.dart
widgetbook: ## Run the component catalog (Widgetbook) in Chrome
	$(FLUTTER) run -t $(WIDGETBOOK_TARGET) -d chrome
widgetbook-web: ## Build the catalog as a static web bundle (build/web)
	$(FLUTTER) build web -t $(WIDGETBOOK_TARGET)
```

## References

- [setup-checklist.md](references/setup-checklist.md) — entrypoint + theme wrapper skeleton
- [use-case-patterns.md](references/use-case-patterns.md) — manual directories / components / use-cases
- [extraction-pattern.md](references/extraction-pattern.md) — inline → public presentational widget
- [web-build-share.md](references/web-build-share.md) — web build and sharing
