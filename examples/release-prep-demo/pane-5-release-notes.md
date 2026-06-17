# Pane 5 - Release Notes Draft

## Draft Notes

`demo-tool v1.4.0` improves audit workflow reliability for automation users.

Highlights:

- Added `audit --cache-dir <path>` to choose where audit cache files are stored.
- Fixed `audit --json` so stdout remains parseable JSON when warnings are present.
- Moved JSON-mode warnings to stderr.
- Added regression tests for JSON output behavior.
- Updated README examples.

## Upgrade Notes

No migration is required. Existing users keep the default cache location unless they use the new `--cache-dir` flag.

Automation users should read warnings from stderr when using `--json`.
