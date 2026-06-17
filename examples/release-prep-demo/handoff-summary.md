# Workflow Handoff Summary

- Workflow directory: `examples/release-prep-demo`
- Demo type: fictional release preparation

## Files

- `README.md` - explains the demo and reading order
- `question.md` - contains the release context
- `pane-roles.md` - assigns each pane a release responsibility
- `pane-1-changelog.md` - drafts changelog notes
- `pane-2-compatibility.md` - checks compatibility risk
- `pane-3-docs.md` - reviews documentation readiness
- `pane-4-smoke-tests.md` - builds smoke-test checklist
- `pane-5-release-notes.md` - drafts release notes
- `pane-6-follow-ups.md` - identifies follow-up issues
- `release-checklist.md` - summarizes release readiness
- `release-notes.md` - contains draft release notes

## Open Checkboxes

- `release-checklist.md`: smoke tests run on a clean checkout
- `release-checklist.md`: tag created
- `release-checklist.md`: release published
- `release-checklist.md`: follow-up issues created

## Empty Sections To Fill

- No empty sections in this demo.

## Suggested Next Step

Use this folder as a model for real release preparation. In a real workflow, create the folder with `scripts/new_workflow.sh release-prep`, run Claude Code panes against that shared folder, then generate a fresh handoff with `scripts/close_workflow.sh`.
