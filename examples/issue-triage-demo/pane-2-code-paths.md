# Pane 2 - Likely Code Paths

## Finding

The likely problem is a shared logging or warning helper writing to stdout by default.

## Files To Inspect In A Real Project

```text
src/cli/audit.*
src/output/json.*
src/logging.*
src/config.*
```

## What To Look For

- `print(...)` or `console.log(...)` calls before JSON serialization.
- warning helpers that do not distinguish stdout and stderr.
- config-loading warnings emitted before the command mode is known.
- tests that check exit code but not stdout parseability.

## Triage Note

If warnings are emitted during config loading, the command may need to initialize output mode before loading config, or route all warnings through a stream-aware reporter.
