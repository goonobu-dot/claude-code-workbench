# Issue Triage Demo

This is a Fictional demo showing how Claude Code Workbench can turn a vague issue report into a structured maintainer handoff.

No real user data, credentials, logs, or private project details are included.

## Scenario

A small CLI tool has a bug: when a user runs `demo-tool audit --json`, the command exits successfully but prints non-JSON warning text before the JSON object. This breaks downstream scripts that expect clean JSON.

## How To Read This Demo

The files model a 9-pane Claude Code CLI session:

- `question.md` contains the issue report.
- `pane-roles.md` assigns one job to each pane.
- `pane-1-reproduction.md` through `pane-6-maintainer-response.md` show sample agent outputs.
- `final-triage.md` shows the maintainer-ready synthesis.
- `handoff-summary.md` shows the output a maintainer could generate with `scripts/close_workflow.sh`.

## What This Demonstrates

The important pattern is not that nine agents all agree. The value is that each pane checks a different part of the maintenance decision:

- reproduction
- likely code path
- minimal fix
- tests
- risk
- maintainer reply

That makes the final triage memo easier to trust and act on.
