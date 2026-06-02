---
project: shigindo-flutter-skills
status: active
version: 0.1.0
updated: 2026-06-02
audience: [human, agent]
---

# 現在の作業 — shigindo-flutter-skills

> 本ファイルはエージェントの**短期作業メモリ**。作業の進行に合わせて
> 自由に書き換えてよい。不変ルールの更新は [AGENTS.md](../../AGENTS.md) で行う。

---

## 状況

- スキル配布: `skills/` SSOT + `dist/`（`build-dist.sh`）+ marketplace（aikata パターン）
- flutter_suite: 公開スキルは GitHub から `install-published-skills.sh`、ローカルは `skills/` + `sync-local-skills.sh`

## 次のアクション

- [ ] GitHub push 後、flutter_suite で `install-published-skills.sh` を検証
- [ ] `aikata doctor` を CI に組み込むか検討

## メモ

- canonical ドキュメント編集後は `aikata generate` を実行すること
- `skills/` 変更後は `./scripts/build-dist.sh` を実行してから `dist/` をコミット
