# Workflow Handoff Summary

- Workflow directory: `examples/pr-review-demo`
- Demo type: fictional pull request review

## Files

- `README.md` - explains the demo and reading order
- `question.md` - contains the fictional PR summary
- `pane-roles.md` - assigns each pane a review angle
- `pane-1-behavior.md` - reviews user-visible behavior
- `pane-2-tests.md` - identifies missing tests
- `pane-3-safety.md` - reviews path handling and safety
- `pane-4-compatibility.md` - checks backward compatibility
- `pane-5-release-notes.md` - drafts release-note guidance
- `pane-6-docs.md` - reviews README documentation needs
- `final-review.md` - combines the useful findings into one maintainer review

## Open Checkboxes

- No open checkboxes in this demo.

## Empty Sections To Fill

- No empty sections in this demo.

## Suggested Next Step

Use this folder as a model for real PR review. In a real workflow, create the folder with `scripts/new_workflow.sh pr-review`, run Claude Code panes against that shared folder, then generate a fresh handoff with `scripts/close_workflow.sh`.
