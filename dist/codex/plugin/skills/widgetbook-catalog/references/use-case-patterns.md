# Manual directories / components / use-cases

No codegen. You build a tree of `WidgetbookNode`s passed to `Widgetbook.material(directories: [...])`.

| Node | Purpose |
| --- | --- |
| `WidgetbookFolder(name, children)` | Grouping in the nav tree |
| `WidgetbookComponent(name, useCases)` | One component with its variants |
| `WidgetbookUseCase(name, builder)` | One named variant; `builder` is `Widget Function(BuildContext)` |

## One file per component group

Each file returns a `WidgetbookComponent`. Keep builders pure and deterministic (no `DateTime.now()`,
no randomness) so the catalog renders consistently.

```dart
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
// import the widget + UseCaseScaffold

WidgetbookComponent chipComponent() {
  return WidgetbookComponent(
    name: 'AppChip',
    useCases: [
      WidgetbookUseCase(
        name: 'neutral',
        builder: (context) => const UseCaseScaffold(child: AppChip(label: 'Label')),
      ),
      WidgetbookUseCase(
        name: 'all tones',
        builder: (context) => const UseCaseScaffold(
          child: Wrap(spacing: 8, runSpacing: 8, children: [/* one per variant */]),
        ),
      ),
    ],
  );
}
```

## Tips

- **Theme-driven widgets** (Material `FilledButton`, `TextField`, `NavigationBar`, FAB) need no
  wrapper widget — just instantiate them; the `MaterialThemeAddon` applies your theme. Show
  disabled via `onPressed: null`.
- **Wide widgets** (cards, banners, nav): wrap in `SizedBox(width: ...)` and use
  `UseCaseScaffold(center: false)`.
- **Widgets with an intrinsic-height dependency** (e.g. a rail using `Expanded`): give them a
  bounded `SizedBox(height: ...)`.
- **`const` pitfall:** some Material widgets (e.g. `NavigationBar`) are not `const` constructors —
  drop `const` on the wrapping use-case when the child can't be const.
- Register the component in `main.dart`'s `directories` under the right `WidgetbookFolder`.
