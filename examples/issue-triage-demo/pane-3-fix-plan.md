# Pane 3 - Fix Plan

## Minimal Fix

Route warnings to stderr when `--json` is active.

## Better Fix

Introduce an output reporter with explicit streams:

```text
reporter.info -> stderr in machine mode
reporter.warn -> stderr in machine mode
reporter.json -> stdout
```

## Acceptance Criteria

- `demo-tool audit --json | jq .` succeeds.
- human-readable mode still shows warnings normally.
- warnings remain visible in CI logs.
- no warning text appears before or after the JSON payload on stdout.

## Non-Goals

- Redesigning the full CLI output system.
- Changing the JSON schema unless maintainers decide to include warnings in the JSON payload.
