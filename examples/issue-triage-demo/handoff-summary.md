# Workflow Handoff Summary

- Workflow directory: `examples/issue-triage-demo`
- Demo type: fictional issue triage

## Files

- `README.md` - explains the demo and reading order
- `question.md` - contains the fictional issue report
- `pane-roles.md` - assigns each pane a separate maintenance role
- `pane-1-reproduction.md` - restates and reproduces the bug
- `pane-2-code-paths.md` - identifies likely code areas
- `pane-3-fix-plan.md` - proposes a minimal fix
- `pane-4-tests.md` - lists regression tests
- `pane-5-safety-review.md` - checks compatibility and risk
- `pane-6-maintainer-response.md` - drafts a maintainer reply
- `final-triage.md` - combines the useful findings into one maintainer memo

## Open Checkboxes

- No open checkboxes in this demo.

## Empty Sections To Fill

- No empty sections in this demo.

## Suggested Next Step

Use this folder as a model for real issue triage. In a real workflow, create the folder with `scripts/new_workflow.sh`, run Claude Code panes against that shared folder, then generate a fresh handoff with `scripts/close_workflow.sh`.
