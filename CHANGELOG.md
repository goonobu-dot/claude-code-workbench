# Changelog

## Unreleased

- Added `examples/pr-review-demo`, a fictional end-to-end pull request review workflow.

## v0.5.0

- Added `examples/issue-triage-demo`, a fictional end-to-end maintainer workflow.
- Linked the example from the README.
- Extended config tests to verify the example remains present.

## v0.4.1

- Updated GitHub Actions checkout to v5.

## v0.4.0

- Added one-command installer.
- Added installer smoke test in CI.
- Allowed app builds to reuse checked-in icons without requiring Pillow unless icons are regenerated.

## v0.3.0

- Added `scripts/close_workflow.sh`.
- Added handoff summary generation for workflow folders.
- Added CI smoke test for `new_workflow.sh` and `close_workflow.sh`.

## v0.2.0

- Added `scripts/new_workflow.sh`.
- Added maintainer workflow templates for issue triage, PR review, release preparation, and feature discovery.

## v0.1.1

- Added showcase and maintainer workflow documentation.
- Added local setup doctor.
- Added GitHub issue templates.

## v0.1.0

- Initial public release.
- Added macOS/tmux Claude Code workbench.
- Added CI, safety audit, README, security notes, and release packaging.
