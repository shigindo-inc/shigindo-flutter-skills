#!/usr/bin/env bash
# Build dist/ plugin artifacts from skills/ SSOT (aikata-style distribution).
# Do not hand-edit dist/ — re-run this script after changing skills/*.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILLS_SRC="$ROOT/skills"
VERSION="${SKILLS_DIST_VERSION:-0.1.0}"

PUBLISHED=(
  flutter-devops
  config-sync
  config-promote
  store-release
  widgetbook-catalog
)

CLAUDE_PLUGIN="$ROOT/dist/claude-code/plugin"
CODEX_PLUGIN="$ROOT/dist/codex/plugin"
CLAUDE_SKILLS="$CLAUDE_PLUGIN/skills"
CODEX_SKILLS="$CODEX_PLUGIN/skills"

rm -rf "$CLAUDE_SKILLS" "$CODEX_SKILLS"
mkdir -p "$CLAUDE_SKILLS" "$CODEX_SKILLS"

skill_paths=()
for name in "${PUBLISHED[@]}"; do
  src="$SKILLS_SRC/$name"
  if [[ ! -d "$src" ]]; then
    echo "Missing skill: $src" >&2
    exit 1
  fi
  cp -R "$src" "$CLAUDE_SKILLS/$name"
  cp -R "$src" "$CODEX_SKILLS/$name"
  skill_paths+=("skills/$name/SKILL.md")
  echo "Copied $name"
done

skills_json="$(printf '"%s",' "${skill_paths[@]}")"
skills_json="[${skills_json%,}]"

mkdir -p "$CODEX_PLUGIN/.codex-plugin"
cat >"$CLAUDE_PLUGIN/plugin.json" <<EOF
{
  "name": "shigindo-flutter-skills",
  "version": "$VERSION",
  "description": "Flutter DevOps, monorepo config sync/promote, store release, and Widgetbook catalog skills for solo and small teams.",
  "homepage": "https://github.com/shigindo-inc/shigindo-flutter-skills",
  "repository": "https://github.com/shigindo-inc/shigindo-flutter-skills",
  "license": "MIT",
  "authors": [
    {
      "name": "shigindo-inc",
      "url": "https://github.com/shigindo-inc"
    }
  ],
  "category": "development",
  "keywords": ["flutter", "dart", "devops", "monorepo", "agent-skills"],
  "tags": ["flutter", "dart", "devops", "monorepo"],
  "components": {
    "skills": $skills_json
  }
}
EOF

cat >"$CODEX_PLUGIN/.codex-plugin/plugin.json" <<EOF
{
  "name": "shigindo-flutter-skills",
  "version": "$VERSION",
  "description": "Flutter DevOps, monorepo config, store release, and Widgetbook skills.",
  "author": {
    "name": "shigindo-inc",
    "url": "https://github.com/shigindo-inc"
  },
  "homepage": "https://github.com/shigindo-inc/shigindo-flutter-skills",
  "repository": "https://github.com/shigindo-inc/shigindo-flutter-skills",
  "license": "MIT",
  "keywords": ["flutter", "dart", "devops", "monorepo", "agent-skills"],
  "skills": "./skills/",
  "interface": {
    "displayName": "shigindo Flutter Skills",
    "shortDescription": "Flutter DevOps and monorepo agent skills.",
    "longDescription": "Opinionated Agent Skills for Flutter DevOps, config sync/promote, store release, and Widgetbook.",
    "developerName": "shigindo-inc",
    "category": "Productivity",
    "capabilities": [],
    "defaultPrompt": [
      "Use flutter-devops to run analyze and tests in this Flutter project.",
      "Use config-sync to align app config from the monorepo root."
    ]
  }
}
EOF

echo "Wrote plugin manifests (version $VERSION)"
