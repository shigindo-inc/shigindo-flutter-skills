# Build the catalog for web and share it

The catalog's sharing mechanism is a static web build of the Widgetbook entrypoint.

## Build

```bash
fvm flutter build web -t lib/widgetbook/main.dart
# outputs build/web/
```

Run this **early** (right after the first few use-cases), not only at the end: a cataloged widget
that transitively pulls in a plugin without web support will fail here, and you want to know before
investing in extraction work.

## Serve locally for review

```bash
cd build/web && python3 -m http.server 5566
# open http://localhost:5566/
```

## Share with a reviewer

- Quickest: serve `build/web/` and share the URL on the same network, or zip `build/web/` and send it.
- Durable (optional, not required): host `build/web/` on any static host (GitHub Pages, Netlify
  drop, Firebase Hosting). Automating this in CI is a deliberate later step — call it out as
  optional rather than doing it silently.

## Notes

- The web build tree-shakes icon fonts; a `MaterialIcons`/`CupertinoIcons` font note in the output
  is informational, not an error.
- Keep the entrypoint free of `Firebase.initializeApp()` and other runtime bootstrapping — the
  catalog should render widgets, not boot the app.
