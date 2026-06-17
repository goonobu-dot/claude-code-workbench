# Workflows

Use the workbench as a small local agent team. Keep assignments explicit so the panes do not all produce the same answer.

## Parallel Research

1. Put the question in `~/ClaudeCodeWorkbench/Idea/question.md`.
2. Launch 4, 6, or 9 panes.
3. Give each pane a different role.
4. Ask each pane to write findings to a separate file.
5. Synthesize the best evidence into one final brief.

Suggested roles:

- evidence finder
- skeptic
- implementation planner
- user workflow reviewer
- security/privacy reviewer
- README writer

## Competing Hypotheses

Use different panes to investigate different explanations.

```text
Pane 1: Defend hypothesis A, then list weak points.
Pane 2: Defend hypothesis B, then list weak points.
Pane 3: Try to falsify both.
Pane 4: Produce a decision memo.
```

## Feature Planning

```text
Pane 1: user problem
Pane 2: CLI/API design
Pane 3: implementation steps
Pane 4: tests
Pane 5: docs
Pane 6: risks
```

## Small Task Mode

Nine panes are useful for broad exploration. Smaller tasks usually need fewer panes.

```bash
CLAUDE_WORKBENCH_PANE_COUNT=4 ./scripts/launch_claude_tmux.sh
```

Decision rule:

- 1 pane: direct implementation
- 4 panes: small research or implementation options
- 6 panes: feature planning
- 9 panes: broad exploration or competing approaches

## Public Output Checklist

Before sharing workbench output:

- remove local paths
- remove credentials
- remove private screenshots
- remove terminal logs with account names or tokens
- keep generated research output separate from source code

For a portable markdown-only bundle, use:

```bash
./scripts/export_workflow.sh "$HOME/ClaudeCodeWorkbench/Idea"
```

To review a shared archive safely, use:

```bash
./scripts/import_workflow.sh ./Idea-workflow-export.tar.gz
```

Before publishing the repository itself:

```bash
make test
```

See [workflow sharing](workflow-sharing.md) for the export/import safety boundaries.
