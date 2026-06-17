# Pane 4 - Tests

## Regression Tests

1. `audit --json` stdout parses as JSON.
2. config warnings do not appear on stdout in JSON mode.
3. config warnings do appear on stderr in JSON mode.
4. human-readable mode keeps current warning behavior.

## Example Test Shape

```bash
stdout="$(demo-tool audit --json 2>stderr.txt)"
printf '%s' "$stdout" | jq .
! grep -q "warning:" <<<"$stdout"
grep -q "warning:" stderr.txt
```

## Edge Cases

- missing config file
- deprecated config field
- multiple warnings
- successful audit with warnings
- failed audit with JSON error output
