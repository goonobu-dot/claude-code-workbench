# Installation Guide

Use this page when you are deciding whether to try Claude Code Workbench from
GitHub.

## Requirements

- macOS
- `tmux`
- Claude Code CLI installed as `claude` or configured with `CLAUDE_WORKBENCH_COMMAND`
- `git` and `python3`

Install tmux with Homebrew:

```bash
brew install tmux
```

## Install In 60 Seconds

```bash
curl -fsSL https://raw.githubusercontent.com/goonobu-dot/claude-code-workbench/main/scripts/install.sh | bash
cd "$HOME/ClaudeCodeWorkbench/claude-code-workbench"
make first-run
```

`make first-run` runs the local doctor, creates a temporary demo workflow, closes
it into a handoff summary, and lists available workflow templates.

If you want to inspect the flow before running commands, read
[docs/demo-transcript.md](demo-transcript.md).

## Try Without Installing

Clone first if you want to inspect the scripts before running the installer:

```bash
git clone https://github.com/goonobu-dot/claude-code-workbench.git
cd claude-code-workbench
./scripts/doctor.sh
make demo
```

## First Real Workflow

```bash
./scripts/create_workflow_from_url.sh https://github.com/owner/repo/issues/123
CLAUDE_WORKBENCH_IDEA_DIR="$HOME/ClaudeCodeWorkbench/Idea" \
CLAUDE_WORKBENCH_USE_ROLE_PROMPTS=1 \
./scripts/launch_claude_tmux.sh
```

## If Setup Fails

```bash
make doctor-report
```

Review `doctor-report.md` before sharing it publicly. It is designed to make bug
reports easier, but you should remove anything private before posting.

## Uninstall

Dry-run first:

```bash
./scripts/uninstall.sh
```

Remove the installed checkout:

```bash
CLAUDE_WORKBENCH_CONFIRM_UNINSTALL=1 ./scripts/uninstall.sh
```

Also remove the generated app and idea folder:

```bash
CLAUDE_WORKBENCH_CONFIRM_UNINSTALL=1 \
CLAUDE_WORKBENCH_REMOVE_APP=1 \
CLAUDE_WORKBENCH_REMOVE_IDEA=1 \
./scripts/uninstall.sh
```

The uninstaller does not remove anything unless confirmation is explicit.
