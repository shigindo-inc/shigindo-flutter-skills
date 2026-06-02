# Extracting inline screen widgets into reusable, cataloged components

Many catalog-worthy widgets start life as private `_Widget` classes inside a screen. To catalog
them (and improve reuse), extract them to public, presentational widgets without changing behavior.

## Where to put it

| Widget couples to... | Destination |
| --- | --- |
| Only Flutter + design tokens (no feature domain) | `lib/shared/widgets/<name>.dart` |
| A feature's domain model (e.g. an `Event`) | `lib/features/<feature>/presentation/widgets/<name>.dart` |

Putting a domain-coupled widget in `lib/shared/` would make shared code depend on a feature — keep
it in the feature instead.

## Make it presentational

- Replace any direct side effect (navigation, provider reads, sheet/dialog opening) with a
  **callback parameter** (`onTap`, `onAction`, ...). The screen supplies the behavior.
- Replace feature-enum inputs with primitive inputs when it removes a layering dependency
  (e.g. `StepDots({required int count, required int activeIndex})` instead of taking an
  onboarding-step enum).
- Keep any small pure formatting helper local to the widget file (self-contained).

## Procedure (one widget at a time)

1. Create the public widget file; copy the build logic verbatim; swap side effects for callbacks.
2. Export it via the relevant `index.dart` if the repo uses barrel files.
3. In the screen: import it, replace the private usage, delete the now-dead private class, and
   remove imports/helpers that became unused.
4. `fvm flutter analyze` — clean.
5. `fvm flutter test` — the screen's existing widget tests must still pass.
6. Add a Widgetbook use-case (with a fixture from `lib/widgetbook/fixtures.dart` if it needs a model).

## Honesty about regression safety

If there is no unit test rendering the widget in isolation, the safety net is the screen-level
widget tests plus a visual pass — not a guarantee. State that plainly. Adding golden tests is
optional and may require standing up golden infrastructure the app does not yet have.
