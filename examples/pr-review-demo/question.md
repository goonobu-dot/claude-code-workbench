# Pull Request Review

## Fictional PR Summary

PR title:

```text
Add --cache-dir support to demo-tool audit
```

The PR adds a new CLI flag:

```bash
demo-tool audit --cache-dir ./tmp/cache
```

The intended behavior:

- use the provided cache directory for audit cache files
- create the directory if it does not exist
- keep the previous default cache location when the flag is omitted
- document the new flag in README examples

## Changed Files

```text
src/cli/audit.*
src/cache/path.*
tests/audit-cache.test.*
README.md
```

## Maintainer Question

Is this PR safe to merge, and what changes should be requested before approval?
