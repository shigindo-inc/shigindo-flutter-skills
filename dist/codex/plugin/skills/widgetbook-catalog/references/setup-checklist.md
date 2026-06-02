# Setup checklist — manual Widgetbook

A working skeleton for a no-codegen catalog under `lib/widgetbook/`.

## `lib/widgetbook/theme_wrapper.dart`

Frame each use-case on the app background with padding. Theme/locale come from addons, so this
only handles presentation.

```dart
import 'package:flutter/material.dart';
// import your tokens

class UseCaseScaffold extends StatelessWidget {
  const UseCaseScaffold({required this.child, this.center = true, super.key});
  final Widget child;
  final bool center; // false for wide widgets / lists (top-left + scroll)

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: const EdgeInsets.all(24), child: child);
    return ColoredBox(
      color: /* AppTokens.background */ Theme.of(context).scaffoldBackgroundColor,
      child: center ? Center(child: content) : Align(alignment: Alignment.topLeft, child: SingleChildScrollView(child: content)),
    );
  }
}
```

## `lib/widgetbook/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:widgetbook/widgetbook.dart';
// import buildAppTheme(), use_cases/*

void main() => runApp(const CatalogApp());

class CatalogApp extends StatelessWidget {
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        MaterialThemeAddon(themes: [WidgetbookTheme(name: 'app', data: buildAppTheme())]),
        LocalizationAddon(
          locales: const [Locale('ja')],
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
        ),
        TextScaleAddon(),
      ],
      directories: [
        WidgetbookFolder(name: 'Inputs', children: [/* component()... */]),
        WidgetbookFolder(name: 'Display', children: [/* component()... */]),
      ],
    );
  }
}
```

## Notes

- `widgetbook` is a **dev-dependency**. The release build of `lib/main.dart` never compiles
  `lib/widgetbook/`, so the dependency is not shipped. If your analyzer flags importing a
  dev-dependency from `lib/`, isolate the entrypoint or promote the dep.
- Confirm `flutter build web -t lib/widgetbook/main.dart` succeeds **before** investing in many
  use-cases — a cataloged widget that transitively imports a non-web plugin fails the web build,
  which is your sharing mechanism.
