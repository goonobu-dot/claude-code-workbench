# Workflow Templates

`scripts/new_workflow.sh` creates a shared folder of markdown files for common maintainer tasks.

The goal is to make a 4/6/9-pane session concrete before launching agents. Each pane gets a role, and outputs land in files that the maintainer can inspect and merge.

## Commands

```bash
./scripts/new_workflow.sh issue-triage
./scripts/new_workflow.sh pr-review
./scripts/new_workflow.sh release-prep
./scripts/new_workflow.sh feature-discovery
```

You can also choose a destination:

```bash
./scripts/new_workflow.sh pr-review "$HOME/ClaudeCodeWorkbench/Idea/pr-123"
CLAUDE_WORKBENCH_IDEA_DIR="$HOME/ClaudeCodeWorkbench/Idea/pr-123" ./scripts/launch_claude_tmux.sh
```

## Included Templates

| Template | Use It For | Main Output |
| --- | --- | --- |
| `issue-triage` | Reproducing, classifying, and planning an issue | `final-triage.md` |
| `pr-review` | Reviewing a pull request from multiple angles | `final-review.md` |
| `release-prep` | Preparing a small release | `release-checklist.md` |
| `feature-discovery` | Turning a feature idea into scope and tests | `decision-memo.md` |

## Suggested Process

1. Generate the workflow folder.
2. Paste the issue, PR, or feature context into the generated files.
3. Launch the workbench pointed at that folder.
4. Assign each pane the role from `pane-roles.md`.
5. Ask panes to write concrete notes to files, not only chat responses.
6. Merge the useful findings into the final output file.
