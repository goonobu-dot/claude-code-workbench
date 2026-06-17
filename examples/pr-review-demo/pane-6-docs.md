# Pane 6 - Documentation Review

## Finding

README docs should include one example and one sentence explaining path behavior.

## Suggested README Addition

```bash
demo-tool audit --cache-dir ./tmp/cache
```

Suggested explanation:

```text
Use `--cache-dir` to choose where audit cache files are stored. Relative paths are resolved from the current working directory.
```

## Review Note

Documentation should not imply that the cache directory is temporary or safe to delete unless the implementation guarantees that.
