# Pane 5 - Safety Review

## User Impact

This affects automation users more than interactive users. A human can ignore the warning line, but scripts that parse stdout cannot.

## Compatibility Risk

Low to medium.

Moving warnings from stdout to stderr in `--json` mode is usually expected behavior, but a small number of users may have scripts that read warnings from stdout.

## Security And Privacy Risk

Low.

The issue does not expose secrets by itself. However, mixing diagnostic text with machine-readable output can cause downstream automation to fail open or skip checks if parsing errors are ignored.

## Recommended Release Note

`audit --json` now keeps stdout valid JSON by sending human-readable warnings to stderr.
