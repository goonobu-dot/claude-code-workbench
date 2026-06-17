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

You can also start from a public GitHub issue or pull request URL:

```bash
./scripts/create_workflow_from_url.sh https://github.com/owner/repo/issues/123
./scripts/create_workflow_from_url.sh https://github.com/owner/repo/pull/123
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
7. Run `./scripts/close_workflow.sh <workflow-dir>` to create `handoff-summary.md`.

## Role-Specific Prompts

`scripts/new_workflow.sh` also creates prompt files:

```text
prompts/
  pane-1.md
  pane-2.md
  ...
  pane-9.md
```

Each prompt is generated from `pane-roles.md`. Review these files before launch if you want to edit the role instructions.

To pass the prompts to Claude Code panes at startup:

```bash
CLAUDE_WORKBENCH_IDEA_DIR="$HOME/ClaudeCodeWorkbench/Idea/pr-123" \
CLAUDE_WORKBENCH_USE_ROLE_PROMPTS=1 \
./scripts/launch_claude_tmux.sh
```

This is opt-in so the generated prompts remain transparent and easy to inspect.

## Closing A Workflow

`scripts/close_workflow.sh` creates a handoff summary with:

- markdown file inventory
- line and word counts
- open checkboxes
- empty second-level sections that still need human review
- a suggested next step

Example:

```bash
./scripts/close_workflow.sh "$HOME/ClaudeCodeWorkbench/Idea/pr-123"
```
