# Pane 1 - Changelog Review

## Draft Changelog

```text
## v1.4.0

- Added `audit --cache-dir <path>` for custom audit cache locations.
- Fixed `audit --json` so stdout remains valid JSON when warnings are present.
- Moved JSON-mode warning text to stderr.
- Added regression tests for JSON output parsing.
- Updated README examples for audit cache configuration.
```

## Review Note

The changelog should mention that existing users keep the default cache path unless they opt into `--cache-dir`.
