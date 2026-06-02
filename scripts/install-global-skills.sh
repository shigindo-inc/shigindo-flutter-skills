#!/usr/bin/env bash
# Install published + official Flutter/Dart skills to user-global agent dirs.
# Safe to run from any directory. Re-run to refresh after upstream updates.
set -euo pipefail

SHIGINDO_SOURCE="${SHIGINDO_SKILLS_SOURCE:-shigindo-inc/shigindo-flutter-skills}"

echo "Installing skills to user-global paths (~/.claude/skills, ~/.agents/skills or agent-specific global dirs)"
echo ""

echo "-> shigindo published ($SHIGINDO_SOURCE)"
npx skills add "$SHIGINDO_SOURCE" --skill '*' --agent claude-code --global --yes
npx skills add "$SHIGINDO_SOURCE" --skill '*' --agent universal --global --yes

echo ""
echo "-> official flutter/skills + dart-lang/skills"
npx skills add flutter/skills --skill '*' --agent claude-code --global --yes
npx skills add dart-lang/skills --skill '*' --agent claude-code --global --yes
npx skills add flutter/skills --skill '*' --agent universal --global --yes
npx skills add dart-lang/skills --skill '*' --agent universal --global --yes

echo ""
echo "Done. Update later: npx skills update --global"
echo "Per-repo suite-local only: run sync-local-skills.sh in flutter_suite after clone."
