# Pane 6 - Maintainer Response

## Draft Reply

Thanks for the clear report. This looks valid: `--json` mode should keep stdout parseable, and human-readable warnings should not appear before the JSON payload.

The likely fix is to route warnings to stderr when JSON output is enabled. We should also add a regression test that pipes `audit --json` into `jq` and confirms warning text is absent from stdout.

I would classify this as a bug affecting automation and CI users.

## Suggested Labels

- `bug`
- `cli`
- `json-output`
- `good first issue` if the output reporter is simple

## Suggested Priority

Medium. It breaks automation, but there is a likely narrow fix.
