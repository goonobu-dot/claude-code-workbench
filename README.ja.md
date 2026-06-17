# Claude Code Workbench 日本語ガイド

Claude Code Workbench は、Claude Code CLI を最大9画面まで1つの tmux ウィンドウに並べて、同じ作業フォルダに向けて動かすためのローカル作業台です。

リサーチ、アイデア出し、実装計画、比較検討、OSSメンテナンスの調査を、複数の視点で同時に進めたい人向けです。

このプロジェクトは Anthropic 公式プロジェクトではありません。

## まず読むもの

- [docs/ja/install.md](docs/ja/install.md): 60秒で導入、試してから導入、アンインストール
- [docs/ja/quickstart.md](docs/ja/quickstart.md): 最初のワークフロー
- [docs/ja/use-cases.md](docs/ja/use-cases.md): 何に使えるか
- [docs/ja/faq.md](docs/ja/faq.md): ローカルMac、GitHub公開、APIキー、個人情報の不安
- [docs/ja/share.md](docs/ja/share.md): X投稿例、GitHub紹介文、プロフィール文
- [docs/ja/openai-credit-note.md](docs/ja/openai-credit-note.md): OSSクレジット応募で説明しやすい価値

## 最短導入

```bash
curl -fsSL https://raw.githubusercontent.com/goonobu-dot/claude-code-workbench/main/scripts/install.sh | bash
cd "$HOME/ClaudeCodeWorkbench/claude-code-workbench"
make first-run
```

インストールせずに確認したい場合:

```bash
git clone https://github.com/goonobu-dot/claude-code-workbench.git
cd claude-code-workbench
./scripts/doctor.sh
make demo
```

## これは何がうれしいのか

- 9つの Claude Code セッションを同じフォルダに向けられる
- 役割別プロンプトで、調査、設計、リスク確認、ドキュメント化を分担できる
- 出力が Markdown として残るので、あとから Issue、PR、Obsidian、日報に転用しやすい
- 公開用のサンプル、導入チェック、セーフティ監査が同梱されている

## 安全面の考え方

このリポジトリを GitHub で見る人は、あなたのローカルMacや非公開フォルダを見られません。公開されるのは、このリポジトリに push したファイルだけです。

ワークフロー共有前には `./scripts/validate_workflow.sh` と `./scripts/export_workflow.sh` が、ローカル絶対パスや秘密情報らしき文字列を検査します。

## 英語版

English README: [README.md](README.md)
