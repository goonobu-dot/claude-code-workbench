# Pane 3 - Safety Review

## Finding

The main risk is unsafe path handling.

## Risks To Check

- accidental deletion of a user-provided directory
- following symlinks in surprising ways
- writing cache files outside the intended directory
- unclear errors for permission-denied paths

## Recommendation

The implementation should create directories but should not delete user-provided paths. If cleanup is needed, it should only remove files it owns.

## Review Note

Ask the PR author to confirm that `--cache-dir` is only used for cache writes and is not passed into any destructive cleanup path.
