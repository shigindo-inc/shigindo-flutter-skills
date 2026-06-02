---
project: shigindo-flutter-skills
status: active
version: 0.1.0
updated: 2026-06-02
audience: [human, agent]
---

# ARCHITECTURE — どう作るか

> 本書は shigindo-flutter-skills の**作り方**を説明する。
> **何を／なぜ**は [SPEC.md](./SPEC.md) を参照。
> 個別の判断は [`docs/adr/`](./docs/adr/) に。Flutter 向けスキル規約は
> [`docs/stacks/flutter.md`](./docs/stacks/flutter.md) に。

---

## 1. 実装言語とランタイム

- **Markdown** — スキル定義（`SKILL.md`）と参照資料（`references/`）
- **Shell** — インストール・同期ヘルパー（`scripts/`）
- **Node.js** — エンドユーザーが `npx skills` でインストール（本リポジトリに package.json は不要）

本リポジトリは Flutter **アプリ**ではない。Dart/Flutter コードは含まない。

## 2. リポジトリ構成

```
shigindo-flutter-skills/
├── README.md                 # 人間向け概要 + インストール手順
├── AGENTS.md                 # エージェント運用ルール（canonical）
├── SPEC.md                   # 要件
├── ARCHITECTURE.md           # 本ファイル
├── GLOSSARY.md
├── ROADMAP.md
├── CONTRIBUTING.md
├── LICENSE
├── .aikata/
│   ├── aikata.yaml           # aikata 設定
│   └── manifest.yaml         # enable 済みコンポーネント
├── docs/
│   ├── adr/
│   ├── stacks/flutter.md     # Flutter 向けスキル規約
│   ├── tasks/current.md      # 短期作業メモ
│   └── troubleshooting.md
├── skills/                   # 公開スキル SSOT
│   ├── flutter-devops/
│   │   ├── SKILL.md
│   │   └── references/
│   ├── config-sync/
│   ├── config-promote/
│   ├── store-release/
│   └── widgetbook-catalog/
├── references/               # リポジトリ横断の参照例
│   └── config-manifest.example.json
├── scripts/
│   ├── build-dist.sh         # skills/ → dist/ + plugin.json
│   ├── install-official.sh
│   └── sync-dual-layout.sh
├── dist/                     # 生成物（build-dist.sh）。Claude/Codex plugin
├── .claude-plugin/marketplace.json
└── .agents/plugins/marketplace.json
```

## 3. 主要コンポーネント

### 3.1 `skills/<name>/`

各スキルの SSOT。`SKILL.md` に YAML frontmatter（`name`, `description`）と
本文（トリガー条件、手順、制約）を記述。詳細は `references/` に分割。

### 3.2 `scripts/`

- `build-dist.sh` — `skills/` から `dist/` と plugin マニフェストを再生成
- `install-official.sh` — 公式 flutter/skills, dart-lang/skills のインストール
- `sync-dual-layout.sh` — Claude Code / universal レイアウトのミラー

### 3.4 `dist/` と marketplace

- `dist/claude-code/plugin/` — Claude Code 自前 marketplace 用プラグイン
- `dist/codex/plugin/` — Codex 自前 marketplace 用プラグイン
- ルートの `.claude-plugin/marketplace.json` / `.agents/plugins/marketplace.json` が self-hosted 源

### 3.3 `references/`

スキル横断の設定例（例: `.claude/config-manifest.json` のサンプル）。

## 4. データフロー

```
[メンテナー編集] → skills/*/SKILL.md
       ↓
[./scripts/build-dist.sh] → dist/ + marketplace.json（Claude/Codex plugin）
       ↓
[GitHub 公開] → npx skills add / plugin marketplace install
       ↓
[利用者プロジェクト] → .claude/skills/ および .agents/skills/
       ↓
[AI エージェント] → スキル自動/手動トリガー → 手順実行
```

[flutter_suite](https://github.com/shigindo-inc/flutter_suite) は GitHub から
`npx skills add` で公開スキルを bootstrap し、dogfooding する（ローカルコピーは Git に含めない）。

## 5. 依存

| 依存 | 用途 |
|---|---|
| [skills CLI](https://github.com/vercel-labs/skills) | スキルのインストール・更新 |
| [aikata](https://github.com/shigindo-inc/aikata) | canonical ドキュメント管理 |
| [flutter/skills](https://github.com/flutter/skills) | 公式 Flutter スキル（別途インストール） |
| [dart-lang/skills](https://github.com/dart-lang/skills) | 公式 Dart スキル（別途インストール） |

## 6. 品質とレビュー

- スキル変更は [CONTRIBUTING.md](./CONTRIBUTING.md) に従う
- frontmatter の `description` は自動トリガー精度に直結 — 変更時は必ず見直す
- インストール検証: `npx skills add . --agent claude-code --yes` を temp ディレクトリから実行

## 7. テスト戦略

アプリコードが無いため `flutter test` は不要。代わりに:

- スキル frontmatter の手動レビュー
- サンプルプロジェクトでの dogfooding（flutter_suite）
- `aikata doctor` によるドキュメント整合性チェック

## 8. 配布とリリース

- GitHub リポジトリが SSOT。タグ付けは任意。
- `npx skills update` で利用者が最新を取得。
- `./scripts/build-dist.sh` で `dist/` を再生成してからコミット（aikata と同方針）。
- flutter_suite は `install-published-skills.sh` で GitHub から取得。
