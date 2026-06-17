# FAQ

## ローカルのMacは外部から見られますか

GitHubで公開されるのは、あなたが push したリポジトリ内のファイルだけです。GitHubの閲覧者が、あなたのローカルのMac、ホームフォルダ、別プロジェクト、APIキーを直接見ることはできません。

## APIキーや個人情報を入れても大丈夫ですか

リポジトリには入れないでください。必要な認証情報は、各CLIやローカル環境の安全な設定に置きます。公開前には `./scripts/audit_public_safety.sh` を実行してください。

## 作ったワークフローを共有できますか

共有できます。ただし、先に検査してください。

```bash
./scripts/validate_workflow.sh "$HOME/ClaudeCodeWorkbench/Idea"
./scripts/export_workflow.sh "$HOME/ClaudeCodeWorkbench/Idea"
```

## 9画面は多すぎませんか

用途によります。軽い調査なら4画面、比較やレビューなら6画面、Issue調査やリリース準備のように観点が多い作業なら9画面が向いています。

## 何から始めるべきですか

最初は `make demo` と `./scripts/recommend_workflow.sh issue` がよいです。実プロジェクトを触る前に、出力の形を確認できます。

## GitHubに公開すると自分の全リポジトリが見られますか

見られません。公開リポジトリの中身だけが見えます。非公開リポジトリやローカルMac内のファイルは、あなたが明示的に公開しない限り見えません。
