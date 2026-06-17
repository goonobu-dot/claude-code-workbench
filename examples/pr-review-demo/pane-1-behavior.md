# Pane 1 - Behavior Review

## Finding

The proposed `--cache-dir` flag is useful and fits the audit command.

## Behavior To Confirm

- Relative paths are resolved from the current working directory.
- Existing default cache behavior is unchanged when the flag is omitted.
- The command creates the cache directory if missing.
- The command fails with a clear error if the path exists as a file.

## Review Note

The PR should document whether `--cache-dir` accepts relative paths, absolute paths, or both.
