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
make test
make release-check
```

Use `make doctor` for local setup checks, `make doctor-report` when asking for help, and `make install-smoke` when changing installer behavior.

Do not include private logs, local vaults, app bundles, or generated research output. If a contribution adds a generated workflow example, keep it fictional and run `make safety` before opening the pull request. Use `scripts/validate_workflow.sh` before exporting a generated workflow, `scripts/export_workflow.sh` when sharing a workflow folder outside your machine, and `scripts/import_workflow.sh` when reviewing a shared archive.
