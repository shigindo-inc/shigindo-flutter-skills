# dist/

Shippable artifacts for Claude Code plugin / marketplace distribution.

**v1:** Skills install via `npx skills add` from the repository root `skills/` tree. This directory is reserved for a future v1.1 Claude Code plugin bundle (see [aikata dist/](https://github.com/shigindo-inc/aikata/tree/main/dist) for the pattern).

Planned layout:

```
dist/
└── claude-code/
    └── plugin/
        ├── plugin.json
        └── skills/
```

Until then, use the install commands in the root [README.md](../README.md).
