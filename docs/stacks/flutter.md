---
project: shigindo-flutter-skills
status: active
version: 0.1.0
updated: 2026-06-02
audience: [human, agent]
---

# Flutter — スタック固有ルール

> shigindo-flutter-skills が **Flutter 向け Agent Skills** を提供することに
> 由来する規約。[AGENTS.md](../../AGENTS.md) の不変則に *追加* される。
> 衝突した場合は AGENTS.md が勝つ。

---

## 1. スキル執筆規約

- 各スキルは `skills/<name>/SKILL.md` に YAML frontmatter を置く:
  - `name`: ディレクトリ名と一致（kebab-case）
  - `description`: いつトリガーすべきかを 1〜2 文で（英語推奨 — エージェント向け）
- 長い手順・チェックリストは `skills/<name>/references/` に分割し、
  `SKILL.md` からリンクする。
- コマンド例は FVM 対応を明示（`fvm flutter` vs `flutter`）—
  `flutter-devops` スキルに合わせる。
- 公式 Dart/Flutter スキル（`flutter-*`, `dart-*` プレフィックス）と
  名前衝突しないこと。本リポジトリは `config-*`, `flutter-devops`,
  `store-release` を使用。

## 2. 想定利用先プロジェクト

スキルが参照する Flutter プロジェクトの前提:

- モノレポ: ルート + `apps/<app-name>/`
- 設定 SSOT: ルートの `.claude/config-manifest.json`（[例](../../references/config-manifest.example.json)）
- DevOps: Makefile または shell スクリプト、FVM（任意）

## 3. 設定同期スキル（config-sync / config-promote）

- **sync**: ルート → アプリへ。マニフェストに列挙されたファイルのみ。
- **promote**: アプリ → ルートへ。一般化ルール（`references/generalization-rules.md`）に従う。
- 双方向の SSOT 原則: ルートが canonical。アプリ固有の上書きはマニフェストで明示。

## 4. ストアリリーススキル（store-release）

- iOS / Android パイプラインは `references/` 内のチェックリストに従う。
- Fastlane 設定例はプロジェクト非依存のテンプレートとして記述。
- 審査ガイドラインはプラットフォーム公式を参照し、スキル内では要点のみ。

## 5. スキル変更の検証

```bash
# 一時ディレクトリからローカル checkout をインストール
npx skills add /path/to/shigindo-flutter-skills --skill <name> --agent claude-code --yes
```

dogfooding は [flutter_suite](https://github.com/shigindo-inc/flutter_suite) で行う。

## 6. 本書を改訂するタイミング

- 新スキル追加または既存スキルのワークフロー変更
- shigindo モノレポの DevOps 慣習変更（FVM、Makefile 等）
- 公式 skills CLI の frontmatter 規約変更
