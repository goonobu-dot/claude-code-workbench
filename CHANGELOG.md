# Changelog

## Unreleased

- Added `examples/pr-review-demo`, a fictional end-to-end pull request review workflow.
- Added role-specific prompt generation for workflow panes.
- Improved first-run diagnostics with actionable setup recommendations.
- Added a README terminal preview SVG for first-time visitors.
- Redacted absolute local paths from generated workflow handoff summaries.
- Added `question.md` templates for every generated workflow and expanded CI smoke coverage.
- Clarified Quick Start so installer and manual clone paths are separate.
- Added a troubleshooting guide for common first-run setup problems.
- Added a `Makefile` with standard doctor, test, safety, smoke, and installer-smoke targets.
- Updated contributor guidance and roadmap items to match the current validation flow.
- Added `scripts/export_workflow.sh` for sharing markdown workflow folders with private-data checks.
- Added `scripts/import_workflow.sh` for safely unpacking shared workflow archives.
- Added `docs/workflow-sharing.md` with export/import usage and safety boundaries.
- Connected workflow sharing to the showcase and workflow safety checklist.
- Added `scripts/create_workflow_from_url.sh` for starting workflows from public GitHub issue and pull request URLs.
- Surfaced the GitHub URL workflow helper in the README and showcase.
- Added a usage report issue template so adopters can share successful workflows and setup friction.
- Added `docs/one-minute-demo.md` for a faster first evaluation path.
- Added `./scripts/doctor.sh --report` for shareable Markdown diagnostics.
- Updated the bug report template to request the generated doctor report.
- Added `scripts/validate_workflow.sh` for pre-export workflow checks.
- Added `./scripts/new_workflow.sh --list` for quick workflow discovery.
- Added `examples/feature-discovery-demo`.
- Added `examples/release-prep-demo`.
- Added `make demo` for a temporary one-command workflow demo.
- Added `SECURITY.md` with reporting and workflow-sharing safety guidance.

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
