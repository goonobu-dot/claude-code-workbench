# Five-Minute Evaluation Guide

Use this path when you want to decide quickly whether the workbench is useful
for your own OSS maintenance or research workflow.

## 1. Check Your Machine

```bash
./scripts/doctor.sh
```

If anything is missing, fix the doctor output before opening panes.

## 2. Create A Demo Workflow

```bash
make demo
```

This creates a temporary workflow with sample prompts and handoff files so you
can inspect the folder structure without using private work.

## 3. Inspect Built-In Workflows

```bash
./scripts/new_workflow.sh --list --verbose
```

Pick the workflow closest to your real task. The strongest first tests are
issue triage, pull request review, release preparation, and feature discovery.

## 4. Run One Short Session

Launch 4 panes first if you are testing the idea:

```bash
CLAUDE_WORKBENCH_PANE_COUNT=4 ./scripts/launch_claude_tmux.sh
```

Ask each pane for a different angle, then compare the notes in the shared idea
folder.

## 5. Close The Loop

```bash
./scripts/close_workflow.sh "$HOME/ClaudeCodeWorkbench/Idea"
```

The evaluation is successful if you end with a clearer decision, a reusable
handoff summary, or a concrete next action you would not have reached as quickly
in a single chat window.
