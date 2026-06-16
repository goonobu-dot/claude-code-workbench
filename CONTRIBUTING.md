# Contributing

Contributions are welcome when they keep the workbench small, local-first, and easy to audit.

Useful areas:

- safer Claude Code launch defaults
- clearer workflow recipes
- tests for pane configuration
- macOS app packaging improvements
- adapters shared with other local-agent workbenches

Before opening a pull request:

```bash
./Tests/test_claude_workbench_config.sh
./scripts/audit_public_safety.sh
```

Do not include private logs, local vaults, app bundles, or generated research output.
