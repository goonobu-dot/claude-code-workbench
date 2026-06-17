# Quality Gates

This project is intentionally small, but every public change should leave a
trail that another maintainer can verify.

## Local Gate

Run the full local release check before publishing changes:

```bash
make release-check
```

That target runs shell syntax checks, configuration coverage, documentation link
checks, public safety scanning, and installer smoke tests.

## Safety Gate

Public workflow archives and examples should not include secrets or private
local paths. Run:

```bash
./scripts/audit_public_safety.sh
```

When sharing a generated diagnosis, prefer `make doctor-report` and inspect the
resulting `doctor-report.md` before posting it publicly.

## CI Gate

GitHub Actions runs the same test and installer smoke paths on every push to
`main`. Do not publish a release until the latest `main` run is green.

## User-Reproduction Gate

Before asking another user to try the workbench, confirm at least one simple
path works:

```bash
make demo
./scripts/new_workflow.sh --list --verbose
```

The goal is not just passing CI. The goal is a repo that a first-time user can
evaluate, diagnose, and report on without private context from the original
author's machine.
