# Pane 1 - User Workflow

## Current Friction

The user has to infer the first workflow from the README. That is acceptable for maintainers who read docs carefully, but not ideal for someone trying the project quickly.

## Proposed Happy Path

1. Run `./scripts/new_workflow.sh --list`.
2. Pick `issue-triage`, `pr-review`, `release-prep`, or `feature-discovery`.
3. Generate a folder.
4. Run `./scripts/validate_workflow.sh <folder>` before export or issue attachment.

## Why This Helps

The first-run path becomes discoverable from the terminal, not only from documentation.
