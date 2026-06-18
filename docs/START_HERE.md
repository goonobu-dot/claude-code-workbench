# Start Here

This page helps a first-time visitor decide what to do in the First 3 minutes.

## What This Project Is

Claude Code Workbench is a local macOS/tmux workspace for running several Claude Code CLI sessions against one shared folder. It is useful when one AI chat is too narrow and you want parallel perspectives on the same project.

This project is not affiliated with Anthropic.

## First 3 Minutes

1. Read the [beginner guide](BEGINNER_GUIDE.md) if the concept is new.
2. Skim [Use Cases](USE_CASES.md) and choose the workflow closest to your work.
3. Run `./scripts/doctor.sh` to check whether your Mac has the required tools.
4. Run `make demo` if you want a no-risk preview before launching panes.

## Choose Your Path

| You are | Read next | Try first |
| --- | --- | --- |
| New to the project | [Beginner guide](BEGINNER_GUIDE.md) | `make demo` |
| OSS maintainer | [Use Cases](USE_CASES.md) | issue triage or PR review |
| Developer testing locally | [Install guide](install.md) | `make first-run` |
| Japanese reader | [まずここから](START_HERE.ja.md) | [日本語ガイド](../README.ja.md) |

## Safety Note

The repository runs locally. It does not publish your Mac files by itself. Only files you commit and push to GitHub become public.
