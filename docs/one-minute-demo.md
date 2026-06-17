# One-Minute Demo

Use this path when you want to understand the project without configuring a real repository first.

## 1. Create A Workflow From A Public URL

```bash
./scripts/create_workflow_from_url.sh https://github.com/owner/repo/issues/123
```

For a pull request review workflow, use:

```bash
./scripts/create_workflow_from_url.sh https://github.com/owner/repo/pull/123
```

The command creates a workflow folder with:

- `question.md` for the task brief
- `pane-roles.md` for pane responsibilities
- `prompts/` for role-specific pane prompts
- a final output file such as `final-triage.md` or `final-review.md`

## 2. Launch The Workbench

```bash
CLAUDE_WORKBENCH_USE_ROLE_PROMPTS=1 ./scripts/launch_claude_tmux.sh
```

Each pane reads from the same shared workflow folder, but starts with a different responsibility.

## 3. Close The Loop

```bash
./scripts/close_workflow.sh "$HOME/ClaudeCodeWorkbench/Idea"
```

This creates `handoff-summary.md`, which is easier to review than raw pane notes.

## 4. Share Feedback

If the demo was useful or confusing, open the usage report issue template and include the command you ran, what it produced, and what slowed you down.
