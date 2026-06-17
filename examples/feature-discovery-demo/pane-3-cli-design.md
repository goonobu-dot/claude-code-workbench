# Pane 3 - CLI Design

## Recommendation

Add two small commands rather than a larger interactive wizard:

- `./scripts/new_workflow.sh --list`
- `./scripts/validate_workflow.sh <workflow-dir>`

## Rationale

This keeps the project transparent and scriptable. It also avoids turning a local maintainer utility into a platform.

## Non-Goals

- No telemetry.
- No remote API checks.
- No hidden configuration.
