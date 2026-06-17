# Dependency Update Review

## Update

Upgrade a terminal helper dependency used by the local launcher scripts.

## Compatibility

No public environment variable names change. Existing workflow folders remain
valid.

## Tests To Run

1. `make test`
2. `make install-smoke`
3. `./scripts/doctor.sh --report doctor-report.md`

## Release Risk

Low if the installer smoke test passes on a clean clone. Medium if the update
changes shell path handling or macOS app bundle behavior.

## Recommendation

Merge only after CI is green and the release notes mention the dependency
change plainly.
