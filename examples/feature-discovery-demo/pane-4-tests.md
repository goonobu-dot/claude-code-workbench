# Pane 4 - Tests

## Acceptance Tests

- `new_workflow.sh --list` prints all supported workflow names.
- `validate_workflow.sh` passes for a folder with `question.md` and `pane-roles.md`.
- `validate_workflow.sh` fails when required files are missing.
- `validate_workflow.sh` fails when markdown appears to contain local absolute paths or token-like secrets.

## Regression Risk

The main risk is breaking existing workflow creation. Keep the existing smoke loop for all workflow templates.
