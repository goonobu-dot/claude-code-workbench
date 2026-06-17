# クイックスタート

## 最初のワークフロー

Issue 調査から始めるのが一番わかりやすいです。

```bash
cd "$HOME/ClaudeCodeWorkbench/claude-code-workbench"
./scripts/new_workflow.sh issue-triage
CLAUDE_WORKBENCH_IDEA_DIR="$HOME/ClaudeCodeWorkbench/Idea" ./scripts/launch_claude_tmux.sh
```

それぞれの pane が別の視点を担当します。

- 再現条件
- 関連コード
- 修正方針
- テスト
- 安全性
- メンテナー返信案

## GitHub URL から始める

```bash
./scripts/create_workflow_from_url.sh https://github.com/owner/repo/issues/123
./scripts/create_workflow_from_url.sh https://github.com/owner/repo/pull/123
```

公開 Issue や PR のURLを起点に、質問ファイルと役割別ファイルを作れます。

## 終了時にまとめる

```bash
./scripts/close_workflow.sh "$HOME/ClaudeCodeWorkbench/Idea"
```

`handoff-summary.md` が作られ、各 pane の結果を1つの引き継ぎメモにまとめられます。

## 迷ったら

```bash
./scripts/recommend_workflow.sh issue
./scripts/recommend_workflow.sh pr
./scripts/recommend_workflow.sh release
./scripts/recommend_workflow.sh security
```

やりたい作業に近いテンプレートを選べます。
