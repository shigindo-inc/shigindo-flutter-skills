#!/usr/bin/env bash
# Copy skills from this repo into a consumer project's .claude/skills and .agents/skills.
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <project-root>" >&2
  exit 1
fi

PROJECT_ROOT="$(cd "$1" && pwd)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$(cd "$SCRIPT_DIR/.." && pwd)/skills"

PUBLISHED=(flutter-devops config-sync config-promote store-release widgetbook-catalog)

for name in "${PUBLISHED[@]}"; do
  src="$SKILLS_SRC/$name"
  if [[ ! -d "$src" ]]; then
    echo "Missing skill source: $src" >&2
    exit 1
  fi
  mkdir -p "$PROJECT_ROOT/.claude/skills" "$PROJECT_ROOT/.agents/skills"
  rm -rf "$PROJECT_ROOT/.claude/skills/$name" "$PROJECT_ROOT/.agents/skills/$name"
  cp -R "$src" "$PROJECT_ROOT/.claude/skills/$name"
  cp -R "$src" "$PROJECT_ROOT/.agents/skills/$name"
  echo "Synced $name -> .claude/skills and .agents/skills"
done

echo "Dual-layout sync complete."
