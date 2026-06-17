# Release Preparation Demo

This is a Fictional demo showing how Claude Code Workbench can structure release preparation for a small open-source CLI.

No real user data, credentials, logs, or private project details are included.

## Scenario

A fictional project is preparing `demo-tool v1.4.0`.

The release includes:

- a new `--cache-dir` flag
- a fix for JSON output warnings
- README updates
- regression tests for CLI output behavior

## How To Read This Demo

The files model a 9-pane Claude Code release preparation session:

- `question.md` contains the release context.
- `pane-roles.md` assigns one release responsibility to each pane.
- `pane-1-changelog.md` through `pane-6-follow-ups.md` show sample release-prep outputs.
- `release-checklist.md` shows the final readiness checklist.
- `release-notes.md` shows draft release notes.
- `handoff-summary.md` shows the maintainer handoff.

## What This Demonstrates

Release work is often scattered across tests, docs, changelog, compatibility, and known risks. The workbench makes each responsibility explicit and turns the result into a reviewable handoff.
