# Pane 4 - Compatibility Review

## Finding

The feature is backward compatible if the default cache path remains unchanged.

## Compatibility Checklist

- existing `demo-tool audit` behavior unchanged
- no required config migration
- no change to JSON output
- no change to exit codes
- no change to cache invalidation semantics unless documented

## Review Note

The PR should include a test proving the default path remains the same when `--cache-dir` is not provided.
