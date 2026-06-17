# Issue Triage

## Fictional Issue Report

When I run:

```bash
demo-tool audit --json
```

I expect stdout to contain valid JSON only.

Actual output:

```text
warning: using default config
{"status":"ok","warnings":1}
```

This breaks my CI script because `jq` fails on the warning line.

## Expected Behavior

In `--json` mode:

- stdout should contain valid JSON only.
- warnings should go to stderr or be included inside the JSON response.
- exit code should remain `0` when the audit succeeds.

## Notes

This is a fictional example for documentation. It is intentionally small so readers can understand the workflow without knowing a real codebase.
