# Pane 2 - Compatibility Review

## Finding

The release appears backward compatible if default cache behavior is unchanged.

## Compatibility Checks

- `demo-tool audit` still uses the existing default cache path.
- `demo-tool audit --json` remains valid JSON.
- warnings still appear in logs through stderr.
- no config migration is required.

## Risk

Low to medium. Moving warning text from stdout to stderr in JSON mode is the correct machine-readable behavior, but scripts that expected warnings on stdout may notice the change.

## Recommendation

Mention the stdout/stderr behavior change in release notes.
