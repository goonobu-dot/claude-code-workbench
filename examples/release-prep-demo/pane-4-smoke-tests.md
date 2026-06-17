# Pane 4 - Smoke Tests

## Required Smoke Tests

```bash
demo-tool audit
demo-tool audit --cache-dir ./tmp/cache
demo-tool audit --json | jq .
demo-tool audit --json 2>warnings.log | jq .
```

## Edge Checks

- cache path with spaces
- missing cache directory
- existing file at cache path
- missing config warning in JSON mode

## Release Gate

Do not tag until JSON stdout parses successfully and cache path behavior is documented.
