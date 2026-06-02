---
project: shigindo-flutter-skills
status: active
version: 0.1.0
updated: 2026-06-02
audience: [human, agent]
---

# SPEC — shigindo-flutter-skills

> 本書では shigindo-flutter-skills が**何を**するか、**なぜ**そうするかを述べる。
> **どう**作るかは [ARCHITECTURE.md](./ARCHITECTURE.md)、用語は
> [GLOSSARY.md](./GLOSSARY.md)、Flutter 向けスキル規約は
> [docs/stacks/flutter.md](./docs/stacks/flutter.md) を参照。

---

## 1. 目的

### 1.1 一行サマリ

> shigindo-flutter-skills は、ソロ〜小規模チームの Flutter 開発向けに、
> DevOps・モノレポ設定同期・ストアリリースをカバーする Agent Skills の
> SSOT リポジトリである。

### 1.2 解決したい問題

公式の Dart/Flutter スキルセットは汎用的だが、shigindo-inc が実際の
モノレポで使う DevOps 手順、設定の SSOT 同期、ストア提出チェックリストは
含まれない。各プロジェクトで同じ知見を毎回プロンプトに書くのは非効率で、
エージェントの出力も揺れる。

### 1.3 解決策

再利用可能な `SKILL.md` と `references/` を GitHub 上で公開し、
`npx skills add` で各 AI ツールにインストールできる形で配布する。
アプリコードは含まず、スキル定義のみを SSOT とする。

---

## 2. ゴール／非ゴール

### 2.1 ゴール（スコープ内）

- 4 つの公開スキル（`flutter-devops`, `config-sync`, `config-promote`, `store-release`）を安定提供
- Claude Code と universal（`.agents/skills/`）の両レイアウトに対応したインストール手順
- モノレポ `apps/<name>/` レイアウトを前提とした設定同期・昇格ワークフローの文書化
- 公式 Dart/Flutter スキルとの共存（名前衝突なし）

### 2.2 非ゴール（スコープ外）

- Flutter アプリケーション本体の実装
- 公式 Dart/Flutter スキルの代替
- npm パッケージとしての配布（GitHub + skills CLI が SSOT）
- モノレポ専用スキル（`ui-kit`, `app-foundation`）— [flutter_suite](https://github.com/shigindo-inc/flutter_suite) 側

### 2.3 ユーザー

| 層 | ペルソナ | ニーズ |
|---|---|---|
| 主要 | ソロ / 小規模チームの Flutter 開発者 | エージェントに DevOps・設定・リリース手順を一貫して実行させたい |
| 副次 | shigindo-inc メンテナー | スキル SSOT の更新と flutter_suite への同期 |

### 2.4 対応プラットフォーム

- **配布対象**: Claude Code, Cursor, Codex, Gemini CLI 等（skills CLI 対応エージェント）
- **想定利用先**: iOS / Android Flutter モノレポ（`apps/<app-name>/`）

---

## 3. 機能要件

### 3.1 公開スキル

| スキル | 観測可能なふるまい |
|---|---|
| `flutter-devops` | FVM 対応の build/run/clean/version/format/analyze/test 手順をエージェントが実行 |
| `config-sync` | ルート設定を `apps/<name>/` へマニフェストに従って同期 |
| `config-promote` | アプリ側の改善をルート SSOT へ昇格 |
| `store-release` | App Store / Play Store 提出パイプラインとチェックリストを案内 |

### 3.2 インストール

- `npx skills add shigindo-inc/shigindo-flutter-skills` で単体または全スキルを取得
- `./scripts/install-official.sh` で公式 Dart/Flutter スキルを追加可能
- `./scripts/sync-dual-layout.sh` で Claude / universal レイアウトをミラー

---

## 4. 非機能要件

- **信頼性**: スキル内のコマンド例は実際の shigindo モノレポで検証済みであること
- **可搬性**: プロジェクト固有名を避け、プレースホルダ（`apps/<app-name>/`）を使用
- **互換性**: skills CLI の frontmatter 規約に準拠
- **保守性**: aikata による canonical ドキュメント管理（`AGENTS.md` 等）

---

## 5. 未決定事項

- CI でのスキル frontmatter 検証の導入要否
- 追加スキルの公開基準（flutter_suite からの昇格フロー）
