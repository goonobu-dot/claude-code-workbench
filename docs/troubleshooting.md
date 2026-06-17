# Troubleshooting

This project is intentionally small, but first-run failures usually come from local setup. Start here before changing the scripts.

## Run The Doctor

```bash
./scripts/doctor.sh
```

To create a Markdown report you can attach to an issue, run:

```bash
./scripts/doctor.sh --report doctor-report.md
```

Or use the Makefile shortcut:

```bash
make doctor-report
```

The doctor checks:

- `tmux`
- `git`
- `python3`
- Claude Code CLI command discovery
- required workbench scripts
- public safety audit status

If it prints `Suggested fixes`, apply those first and run the doctor again.

## tmux Is Missing

Install tmux with Homebrew:

```bash
brew install tmux
```

Then verify:

```bash
tmux -V
./scripts/doctor.sh
```

## Claude Code CLI Is Not Found

If `claude` is not on `PATH`, point the workbench at the full command path:

```bash
CLAUDE_WORKBENCH_COMMAND="/path/to/claude" ./scripts/doctor.sh
CLAUDE_WORKBENCH_COMMAND="/path/to/claude" ./scripts/launch_claude_tmux.sh
```

If you use a shell version manager, open a fresh Terminal window after installation so `PATH` changes are loaded.

## Panes Launch But Do Nothing

Disable auto-submit and inspect the prompt in each pane:

```bash
CLAUDE_WORKBENCH_AUTO_SUBMIT=0 ./scripts/launch_claude_tmux.sh
```

For role-specific prompts, confirm the workflow folder contains generated prompt files:

```bash
./scripts/new_workflow.sh issue-triage
ls "$HOME/ClaudeCodeWorkbench/Idea/prompts"
```

## Wrong Workflow Folder

Every pane writes against one shared folder. Set it explicitly when switching projects:

```bash
CLAUDE_WORKBENCH_IDEA_DIR="$HOME/ClaudeCodeWorkbench/Idea/my-review" ./scripts/launch_claude_tmux.sh
```

## Before Publishing Output

Generated workflow summaries are designed to avoid exposing absolute local paths, but you should still review generated notes before sharing them. Run:

```bash
./scripts/audit_public_safety.sh
```
