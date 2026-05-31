#!/usr/bin/env bash
# Install official flutter/skills and dart-lang/skills into the current project.
set -euo pipefail

ROOT="${1:-.}"
cd "$ROOT"

echo "Installing official Flutter skills (claude-code -> .claude/skills/)..."
npx skills add flutter/skills --skill '*' --agent claude-code --yes

echo "Installing official Dart skills (claude-code -> .claude/skills/)..."
npx skills add dart-lang/skills --skill '*' --agent claude-code --yes

echo "Installing official Flutter skills (universal -> .agents/skills/)..."
npx skills add flutter/skills --skill '*' --agent universal --yes

echo "Installing official Dart skills (universal -> .agents/skills/)..."
npx skills add dart-lang/skills --skill '*' --agent universal --yes

echo "Done. Official skills are not vendored in shigindo-flutter-skills; re-run this script to refresh."
