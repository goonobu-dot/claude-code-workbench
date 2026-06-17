# Architecture

Claude Code Workbench is intentionally small. It is a local tmux launcher plus workflow-folder utilities.

## Local boundary

The project runs on your machine. It does not host a server, collect telemetry, or upload workflow notes.

Public GitHub only sees what you commit and push. Generated workflow folders stay local unless you explicitly export, attach, commit, or publish them.

## Main Pieces

- `scripts/launch_claude_tmux.sh` starts the tmux layout.
- `scripts/new_workflow.sh` creates workflow folders.
- `scripts/create_workflow_from_url.sh` starts from public GitHub issue or pull request URLs.
- `scripts/close_workflow.sh` creates a handoff summary.
- `scripts/validate_workflow.sh` checks workflow folders before sharing.
- `scripts/export_workflow.sh` and `scripts/import_workflow.sh` move markdown workflow archives safely.

## Shared workflow folder

All panes read and write against one shared workflow folder.

```text
workflow/
  question.md
  pane-roles.md
  prompts/
    pane-1.md
    pane-2.md
  final-triage.md
  handoff-summary.md
```

This keeps the system inspectable. The user can review every prompt and every generated note before using the result.

## Flow

```text
new_workflow.sh or create_workflow_from_url.sh
  -> shared workflow folder
  -> launch_claude_tmux.sh
  -> pane notes
  -> close_workflow.sh
  -> validate_workflow.sh
  -> optional export_workflow.sh
```

## Safety Model

The safety tools reduce common mistakes:

- `audit_public_safety.sh` checks repository files before publishing.
- `validate_workflow.sh` checks generated workflow folders before sharing.
- `export_workflow.sh` refuses common private-data patterns and includes `workflow-manifest.json`.
- `import_workflow.sh` refuses unsafe archive paths and unexpected file types.

These checks do not replace human review.
