# Claude Code Workbench

[![CI](https://github.com/goonobu-dot/claude-code-workbench/actions/workflows/ci.yml/badge.svg)](https://github.com/goonobu-dot/claude-code-workbench/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/goonobu-dot/claude-code-workbench)](https://github.com/goonobu-dot/claude-code-workbench/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Japanese readers: start with [README.ja.md](README.ja.md) or the full [Japanese documentation hub](docs/ja/README.md).

A macOS/tmux workbench for running up to 9 Claude Code CLI sessions in one Terminal window.

This is a focused public version of a real local workflow: launch several Claude Code panes, point them at one shared idea folder, and use them for research, ideation, implementation planning, and comparison.

This project is not affiliated with Anthropic.

![Claude Code Workbench terminal preview](docs/assets/workbench-preview.svg)

## Install In 60 Seconds

```bash
curl -fsSL https://raw.githubusercontent.com/goonobu-dot/claude-code-workbench/main/scripts/install.sh | bash
cd "$HOME/ClaudeCodeWorkbench/claude-code-workbench"
make first-run
```

Full setup notes are in [docs/install.md](docs/install.md).

## Try Without Installing

```bash
git clone https://github.com/goonobu-dot/claude-code-workbench.git
cd claude-code-workbench
./scripts/doctor.sh
make demo
```

## Demo Preview

The fastest no-risk preview is `make first-run`: it checks your machine, creates
a temporary demo workflow, closes it into a handoff summary, and lists available
workflow templates.

Read [docs/demo-transcript.md](docs/demo-transcript.md) to see the expected
output shape before running anything locally.

If you are unsure where to start, run:

```bash
./scripts/recommend_workflow.sh issue
./scripts/recommend_workflow.sh security
```

## Who This Is For

- OSS maintainers who need faster issue triage, pull request review, release preparation, or security screening.
- Developers who want several independent Claude Code angles on one local folder without building a hosted system.
- Researchers and builders who want reusable markdown outputs instead of scattered chat transcripts.

## What You Get In 5 Minutes

- a local 4, 6, or 9 pane tmux workbench
- workflow templates for issue triage, PR review, release prep, and feature discovery
- one shared folder containing role prompts, pane notes, and a final handoff summary
- a doctor report and quality gates so setup problems are easier to diagnose

## Example Outputs

- [issue triage result](examples/issue-triage-demo/final-triage.md)
- [pull request review verdict](examples/pr-review-demo/final-review.md)
- [release checklist](examples/release-prep-demo/release-checklist.md)
- [feature decision memo](examples/feature-discovery-demo/decision-memo.md)
- [security triage](examples/security-triage-demo/security-triage.md)
- [documentation improvement plan](examples/docs-improvement-demo/docs-plan.md)
- [dependency update review](examples/dependency-update-demo/update-review.md)

## Share A Usage Report

If the workbench helps you make a real maintenance decision, open a
[usage report](.github/ISSUE_TEMPLATE/usage_report.yml). Short reports are
useful: the workflow used, what it produced, and where the setup was confusing.

## Why This Exists

One AI-agent chat is useful. Several panes are better when you want independent angles on the same problem.

Use this workbench for:

- parallel research
- competing solution ideas
- feature planning
- review and risk checks
- collecting outputs into one shared folder
- keeping a repeatable Claude Code multi-pane setup

## Requirements

- macOS
- `tmux`
- Claude Code CLI installed as `claude` or configured with `CLAUDE_WORKBENCH_COMMAND`
- Python 3 and Pillow only if you regenerate the icon

Install tmux with Homebrew:

```bash
brew install tmux
```

## Quick Start

One-command install:

```bash
curl -fsSL https://raw.githubusercontent.com/goonobu-dot/claude-code-workbench/main/scripts/install.sh | bash
```

Then launch:

```bash
cd "$HOME/ClaudeCodeWorkbench/claude-code-workbench"
make demo
./scripts/launch_claude_tmux.sh
```

Check your local setup without starting a workbench session:

```bash
./scripts/doctor.sh
```

Run the local validation suite:

```bash
make test
```

Create a reusable maintainer workflow folder before launching panes:

```bash
./scripts/new_workflow.sh issue-triage
CLAUDE_WORKBENCH_IDEA_DIR="$HOME/ClaudeCodeWorkbench/Idea" ./scripts/launch_claude_tmux.sh
```

Start directly from a public GitHub issue or pull request URL:

```bash
./scripts/create_workflow_from_url.sh https://github.com/owner/repo/issues/123
./scripts/create_workflow_from_url.sh https://github.com/owner/repo/pull/123
```

Launch with role-specific prompts generated from `pane-roles.md`:

```bash
CLAUDE_WORKBENCH_IDEA_DIR="$HOME/ClaudeCodeWorkbench/Idea" \
CLAUDE_WORKBENCH_USE_ROLE_PROMPTS=1 \
./scripts/launch_claude_tmux.sh
```

After the panes write their notes, create a handoff summary:

```bash
./scripts/close_workflow.sh "$HOME/ClaudeCodeWorkbench/Idea"
```

Export a workflow folder for sharing:

```bash
./scripts/export_workflow.sh "$HOME/ClaudeCodeWorkbench/Idea"
```

Import a shared workflow archive:

```bash
./scripts/import_workflow.sh ./Idea-workflow-export.tar.gz
```

All panes use one shared idea folder by default:

```bash
~/ClaudeCodeWorkbench/Idea
```

Manual clone instead of the installer:

```bash
mkdir -p "$HOME/ClaudeCodeWorkbench"
git clone https://github.com/goonobu-dot/claude-code-workbench.git "$HOME/ClaudeCodeWorkbench/claude-code-workbench"
cd "$HOME/ClaudeCodeWorkbench/claude-code-workbench"
./scripts/doctor.sh
```

## Controls

The workbench uses tmux. The prefix is usually `control-b`.

- `control-b z`: zoom or unzoom the active pane
- mouse support is enabled
- each pane starts a separate Claude Code session

## Configuration

```bash
CLAUDE_WORKBENCH_PANE_COUNT=4 ./scripts/launch_claude_tmux.sh
CLAUDE_WORKBENCH_BASE="$HOME/ClaudeCodeWorkbench" ./scripts/launch_claude_tmux.sh
CLAUDE_WORKBENCH_IDEA_DIR="$HOME/ClaudeCodeWorkbench/Research" ./scripts/launch_claude_tmux.sh
CLAUDE_WORKBENCH_COMMAND="/opt/homebrew/bin/claude" ./scripts/launch_claude_tmux.sh
CLAUDE_WORKBENCH_MODEL="sonnet" ./scripts/launch_claude_tmux.sh
CLAUDE_WORKBENCH_AUTO_SUBMIT=0 ./scripts/launch_claude_tmux.sh
```

Defaults:

| Setting | Default |
| --- | --- |
| `CLAUDE_WORKBENCH_PANE_COUNT` | `9` |
| `CLAUDE_WORKBENCH_SESSION` | `claude-code-9` |
| `CLAUDE_WORKBENCH_BASE` | `~/ClaudeCodeWorkbench` |
| `CLAUDE_WORKBENCH_IDEA_DIR` | `~/ClaudeCodeWorkbench/Idea` |
| `CLAUDE_WORKBENCH_MODEL` | `sonnet` |
| `CLAUDE_WORKBENCH_EFFORT` | `low` |
| `CLAUDE_WORKBENCH_PERMISSION_MODE` | `auto` |
| `CLAUDE_WORKBENCH_AUTO_SUBMIT` | `1` |

## Build The macOS App

```bash
./scripts/build_claude_app.sh
open "$HOME/Applications/Claude Code Workbench.app"
```

The generated app opens Terminal and launches the tmux workbench. The checked-in AppleScript does not contain a personal path. By default, it expects this repository at:

```bash
~/ClaudeCodeWorkbench/claude-code-workbench
```

## Workflow Recipes

See [docs/workflows.md](docs/workflows.md) for practical ways to use the panes without creating noise.

See also:

- [docs/oss-maintainer-use-cases.md](docs/oss-maintainer-use-cases.md)
- [docs/showcase.md](docs/showcase.md)
- [docs/why.md](docs/why.md)
- [docs/one-minute-demo.md](docs/one-minute-demo.md)
- [docs/evaluation-guide.md](docs/evaluation-guide.md)
- [docs/install.md](docs/install.md)
- [docs/demo-transcript.md](docs/demo-transcript.md)
- [docs/adoption-scorecard.md](docs/adoption-scorecard.md)
- [docs/continuous-improvement-loops.md](docs/continuous-improvement-loops.md)
- [docs/commands.md](docs/commands.md)
- [docs/architecture.md](docs/architecture.md)
- [docs/quality-gates.md](docs/quality-gates.md)
- [docs/workflow-templates.md](docs/workflow-templates.md)
- [docs/workflow-sharing.md](docs/workflow-sharing.md)
- [docs/troubleshooting.md](docs/troubleshooting.md)
- [docs/faq.md](docs/faq.md)
- [SUPPORT.md](SUPPORT.md)
- [docs/publication-checklist.md](docs/publication-checklist.md)
- [docs/openai-codex-for-oss.md](docs/openai-codex-for-oss.md)
- [docs/adoption-plan.md](docs/adoption-plan.md)

Example:

- [examples/issue-triage-demo](examples/issue-triage-demo)
- [examples/pr-review-demo](examples/pr-review-demo)
- [examples/release-prep-demo](examples/release-prep-demo)
- [examples/feature-discovery-demo](examples/feature-discovery-demo)
- [examples/security-triage-demo](examples/security-triage-demo)
- [examples/docs-improvement-demo](examples/docs-improvement-demo)
- [examples/dependency-update-demo](examples/dependency-update-demo)

Project operations:

- [ROADMAP.md](ROADMAP.md)
- [CHANGELOG.md](CHANGELOG.md)
- [SECURITY.md](SECURITY.md)

If you try it on a real or fictional maintainer task, share the result with the
[usage report issue template](.github/ISSUE_TEMPLATE/usage_report.yml). Reports
about confusing setup steps are as useful as reports about successful workflows.

## Safety Notes

This repository intentionally does not include local logs, `.env` files, prompt histories, Obsidian vaults, generated agent output, or app bundles.

Before publishing your own fork, run:

```bash
make test
```

## Project Status

This is an early public release. It is intentionally small: shell scripts, AppleScript launchers, generated icon assets, tests, and CI.
