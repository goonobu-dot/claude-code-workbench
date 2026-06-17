# Pane 1 - Reproduction

## Finding

The reported behavior is internally consistent. The command is expected to emit JSON, but a human-readable warning appears first.

## Minimal Reproduction

```bash
demo-tool audit --json | jq .
```

Expected result:

```text
valid parsed JSON
```

Actual result:

```text
parse error: Invalid numeric literal at line 1, column 8
```

## Triage Note

The core bug is not the warning itself. The bug is that machine-readable mode sends non-machine-readable text to stdout.
