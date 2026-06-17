# Release Notes

## demo-tool v1.4.0

This release improves audit workflows for automation and CI users.

### Added

- `demo-tool audit --cache-dir <path>` to choose where audit cache files are stored.

### Fixed

- `demo-tool audit --json` now keeps stdout valid JSON when warnings are present.
- JSON-mode warnings are written to stderr.

### Documentation

- Added README examples for custom cache directories and JSON parsing.

### Upgrade Notes

No migration is required. Existing users keep the default cache location unless they use `--cache-dir`.
