---
project: shigindo-flutter-skills
status: active
version: 0.1.0
updated: 2026-06-02
audience: agent
---

# shigindo-flutter-skills のエージェント指示書

## 1. プロジェクト概要

何を／なぜは [SPEC.md](./SPEC.md) を、技術構造は
[ARCHITECTURE.md](./ARCHITECTURE.md) を、用語は
[GLOSSARY.md](./GLOSSARY.md) を参照。

**本リポジトリは Agent Skills の SSOT である。** Flutter アプリコードは
含まない。`skills/*/SKILL.md` と `references/` の編集が主な作業対象。

## 2. 作業を始める前に

次の順に読む（markdown が自動採番する — `1.` の重複は意図的）:

1. [README.md](./README.md) — 概要・インストール
1. **本ファイル (AGENTS.md)** — 運用ルール
1. [SPEC.md](./SPEC.md) — 要件
1. [ARCHITECTURE.md](./ARCHITECTURE.md) — リポジトリ構造
1. [GLOSSARY.md](./GLOSSARY.md) — 用語
1. [`docs/stacks/flutter.md`](./docs/stacks/flutter.md) — スキル執筆規約
1. [`docs/tasks/current.md`](./docs/tasks/current.md) — 現在の作業メモ

## 3. ナビゲーション

| 作業の種類 | まず読むファイル |
|---|---|
| スキル内容の追加・変更 | `skills/<name>/SKILL.md`, 同 skill の `references/` |
| 新スキルの追加 | [ARCHITECTURE.md](./ARCHITECTURE.md), [CONTRIBUTING.md](./CONTRIBUTING.md) |
| README / インストール手順の更新 | [README.md](./README.md), [SPEC.md](./SPEC.md) §3.2 |
| 設計判断の記録 | `docs/adr/` — 書式は [ADR 0001](./docs/adr/0001-record-architecture-decisions.md) |
| 用語の更新 | [GLOSSARY.md](./GLOSSARY.md) を更新後、旧表記を grep |
| canonical ドキュメント編集後 | `aikata generate` を実行（`CLAUDE.md`, `.cursor/rules/` を再生成） |
| 厄介な問題の調査 | まず [docs/troubleshooting.md](./docs/troubleshooting.md) |

## 4. 厳守ルール

- **シークレットをコミットしない。**
- **作業の開始時と終了時に [`docs/tasks/current.md`](./docs/tasks/current.md) を更新する。**
- **スキル編集時は YAML frontmatter の `name` と `description` を正確に保つ**
  — 自動トリガー精度に直結する。
- **プロジェクト固有名を避ける** — 例は `apps/<app-name>/` 等のプレースホルダを使う。
- **README のスキル一覧を変更したら** [SPEC.md](./SPEC.md) §3.1 も整合させる。
- **[Conventional Commits](https://www.conventionalcommits.org/) を使う** —
  種別: feat, fix, docs, style, refactor, test, chore, perf, ci, build。
- **コミットに AI 署名を入れない** — ツールではなく変更を記述する。
- **設計判断は [`docs/adr/`](./docs/adr/) に ADR として記録する。**
- **新しいドメイン用語が出てきたら [GLOSSARY.md](./GLOSSARY.md) を更新する。**
- **`CLAUDE.md` や `.cursor/rules/main.mdc` を手編集しない** —
  [AGENTS.md](./AGENTS.md) を編集し `aikata generate` で再生成する。

## 5. 詰まったとき

優先順位は次のとおり:

1. [`docs/troubleshooting.md`](./docs/troubleshooting.md) を確認。
2. [`docs/adr/`](./docs/adr/) で過去の設計判断を確認。
3. [`docs/stacks/flutter.md`](./docs/stacks/flutter.md) でスキル執筆規約を確認。
4. 質問を文書化し、`docs/tasks/current.md` に追記してメンテナーに surface する。
