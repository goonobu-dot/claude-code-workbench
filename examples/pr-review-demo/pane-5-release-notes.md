# Pane 5 - Release Notes Review

## Finding

This should be listed as a small feature in release notes.

## Suggested Release Note

```text
Added `demo-tool audit --cache-dir <path>` to let users choose where audit cache files are stored.
```

## Migration Note

No migration required. Existing users keep the default cache location unless they opt into the new flag.

## Review Note

If the PR changes default cache behavior, this must be called out as a breaking or behavior-changing update. Current stated intent is non-breaking.
