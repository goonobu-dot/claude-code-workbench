# Pane 2 - Test Review

## Finding

The PR has basic tests but should add path edge cases before merge.

## Tests To Request

- omitted flag keeps default cache path
- relative `--cache-dir` works
- absolute `--cache-dir` works
- missing directory is created
- existing file at cache path fails clearly
- path with spaces works

## Suggested Test

```bash
demo-tool audit --cache-dir "./tmp/cache with spaces"
test -d "./tmp/cache with spaces"
```

## Review Note

This is a small feature, but path handling bugs can be annoying for users. The edge-case tests are worth adding.
