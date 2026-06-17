# Pane 3 - Documentation Review

## README Checks

- Include one `--cache-dir` example.
- Explain relative path behavior.
- Explain that JSON mode keeps stdout parseable.
- Mention that warnings are sent to stderr in JSON mode.

## Suggested README Snippet

```bash
demo-tool audit --cache-dir ./tmp/cache
demo-tool audit --json 2>warnings.log | jq .
```

## Review Note

Docs should describe what users can rely on: JSON on stdout, human-readable warnings on stderr.
