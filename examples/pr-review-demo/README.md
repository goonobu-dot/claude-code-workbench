# Pull Request Review Demo

This is a Fictional demo showing how Claude Code Workbench can turn a pull request into a structured maintainer review.

No real user data, credentials, logs, or private project details are included.

## Scenario

A fictional pull request changes a CLI cache option:

```text
PR: Add --cache-dir support to demo-tool audit
```

The PR lets users choose where audit cache files are written. It touches argument parsing, cache path creation, and documentation.

## How To Read This Demo

The files model a 9-pane Claude Code CLI review session:

- `question.md` contains the PR summary.
- `pane-roles.md` assigns one review angle to each pane.
- `pane-1-behavior.md` through `pane-6-docs.md` show sample review outputs.
- `final-review.md` shows the maintainer-ready review.
- `handoff-summary.md` shows the output a maintainer could generate with `scripts/close_workflow.sh`.

## What This Demonstrates

The useful pattern is independent review angles:

- behavior
- tests
- safety
- compatibility
- release notes
- documentation

The final review is easier to trust because it is built from separate checks rather than one broad response.
