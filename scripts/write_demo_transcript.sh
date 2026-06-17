#!/usr/bin/env bash
set -euo pipefail

OUT_FILE="${1:-docs/demo-transcript.md}"
mkdir -p "$(dirname "$OUT_FILE")"

cat >"$OUT_FILE" <<'EOF'
# Claude Code Workbench Demo Transcript

This transcript shows what a first-time GitHub reader should expect before
installing or launching panes.

## Command

```bash
make first-run
```

## What Happens

1. `./scripts/doctor.sh` checks local dependencies and prints suggested fixes.
2. `make demo` creates a temporary issue-triage workflow from a public GitHub URL.
3. `./scripts/validate_workflow.sh` checks the workflow folder.
4. `./scripts/close_workflow.sh` writes a `Workflow Handoff Summary`.
5. `./scripts/new_workflow.sh --list --verbose` lists available workflows.

## Example Output Shape

```text
Claude Code Workbench doctor
Suggested fixes:
- Install tmux if missing.

Demo workflow ready: /tmp/tmp.example

Available workflows:
- issue-triage
- pr-review
- release-prep
- feature-discovery

First-run check complete
```

## Files A User Should Inspect

- `question.md`
- `pane-roles.md`
- `prompts/pane-1.md`
- `handoff-summary.md`

The key artifact is the `Workflow Handoff Summary`: it turns scattered pane
notes into a maintainer-readable next-action summary.
EOF

echo "Demo transcript written to: $OUT_FILE"
