---
project: shigindo-flutter-skills
status: active
version: 0.1.0
updated: 2026-06-02
audience: [human, agent]
---

# ROADMAP — shigindo-flutter-skills

> このドキュメントは **shigindo-flutter-skills の今後の方向性** を粗い順で
> 示すもの。**何を / なぜ** は [SPEC.md](./SPEC.md)、**どうやって**
> は [ARCHITECTURE.md](./ARCHITECTURE.md) を参照。

---

## v0.1 — ドキュメント基盤 ✅

- ✅ aikata init（standard + flutter stack, ja, claude/cursor）
- ✅ SPEC / ARCHITECTURE / AGENTS のスキルリポジトリ向けカスタマイズ
- ⬜ `aikata doctor` CI ゲート

## v0.2 — スキル品質

- ⬜ 各スキルの frontmatter description レビュー
- ⬜ スキル frontmatter 検証スクリプト（任意）
- ⬜ troubleshooting.md の充実

## v1.0 — 安定版

- ⬜ 4 公開スキルの API（手順・参照パス）凍結
- ✅ flutter_suite からの bootstrap フロー文書化（npx + `skills/` ローカル SSOT）
- ⬜ 利用者向けマイグレーションガイド

---

## スコープ外

- Flutter アプリテンプレートの提供
- 公式 dart-lang/skills, flutter/skills のフォーク・再配布
- npm パッケージ化

---

## 更新方針

- 完了項目は `✅` を付与。
- `aikata sync` を時々走らせてテンプレ改善を取り込む。
