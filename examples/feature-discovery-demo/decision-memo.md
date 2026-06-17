# Feature Decision Memo

## User Problem

New users need a faster way to discover workflow templates and check a generated workflow folder before sharing it.

## Recommended Scope

Add terminal-first discovery and validation:

- `./scripts/new_workflow.sh --list`
- `./scripts/validate_workflow.sh <workflow-dir>`

## Non-Goals

- Do not add a hosted service.
- Do not collect usage analytics.
- Do not require GitHub credentials.

## Implementation Plan

1. Add a list mode to `new_workflow.sh`.
2. Add a workflow validator that checks required markdown files and common private-data patterns.
3. Document both commands in workflow template and sharing docs.
4. Cover the behavior in CI.

## Tests

Run:

```bash
make test
make install-smoke
```

## Risks

Validation is a guardrail, not a proof of correctness. Maintainers still need to review generated markdown before publishing.
