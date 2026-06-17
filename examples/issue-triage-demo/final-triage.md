# Final Triage

## Summary

The issue is valid. In `--json` mode, stdout should contain valid JSON only. The current behavior emits a human-readable warning before the JSON payload, which breaks downstream parsers such as `jq`.

## Reproduction

```bash
demo-tool audit --json | jq .
```

The command fails because stdout begins with:

```text
warning: using default config
```

## Likely Cause

A shared warning or logging helper is writing to stdout before or during JSON output. The warning path probably does not know whether the CLI is in human-readable or machine-readable mode.

## Recommended Fix

Route warnings to stderr when JSON output is active. Keep stdout reserved for the JSON payload.

If the codebase already has an output reporter, add a machine-mode branch there. If it does not, introduce a small reporter abstraction rather than scattering stream checks across command code.

## Tests

- `audit --json` stdout parses with `jq`.
- warning text is absent from stdout in JSON mode.
- warning text appears on stderr in JSON mode.
- human-readable mode still displays warnings.

## Risk

Compatibility risk is low to medium. The change matches common CLI expectations, but release notes should mention that warnings in JSON mode now go to stderr.

## Maintainer Response

Thanks for the report. This is a valid bug for automation users. `--json` should keep stdout parseable, so warnings should move to stderr when JSON output is enabled. A fix should include a regression test that pipes JSON output into `jq`.
