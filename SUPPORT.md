# Getting Help

This project is a local tmux workbench. Most setup issues are about missing
commands, shell paths, or a workflow folder that is not where the launcher
expects it to be.

## First Checks

Run the doctor before opening an issue:

```bash
./scripts/doctor.sh
make doctor-report
```

The generated `doctor-report.md` is designed for sharing in a bug report. Read
it first and remove anything you do not want to publish.

## Common Next Steps

- Read [docs/troubleshooting.md](docs/troubleshooting.md) for first-run setup
  problems.
- Run `./scripts/new_workflow.sh --list` to confirm the built-in workflow names.
- Run `make demo` to create a temporary local workflow and verify the basic
  folder structure.
- Run `make release-check` before reporting a project-level regression.

## Opening An Issue

Use the closest matching issue template:

- [bug report](.github/ISSUE_TEMPLATE/bug_report.yml) for setup or launcher
  failures
- [usage report](.github/ISSUE_TEMPLATE/usage_report.yml) for successful
  workflows, adoption notes, or confusing moments

Include the command you ran, your macOS version, and the generated doctor report
when it is safe to share.

Do not paste API keys, private repository contents, client data, or local
personal paths into public issues.
