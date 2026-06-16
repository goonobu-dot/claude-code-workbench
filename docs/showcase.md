# Showcase

## What It Demonstrates

Claude Code Workbench demonstrates a practical pattern for AI-assisted open-source maintenance:

> Run several Claude Code CLI sessions against one shared workspace, then compare their outputs before acting.

This is intentionally small and inspectable. The repository is mostly shell scripts, AppleScript launchers, docs, tests, and CI.

## Why It Is Useful

Most AI-agent usage is single-threaded. Maintainers often need parallel review:

- one agent checks code paths
- one agent looks for tests
- one agent writes user-facing notes
- one agent tries to falsify the proposed fix

The workbench makes that workflow repeatable without building a large platform.

## Evidence In The Repository

- Public CI validates shell syntax, configuration expectations, and the public safety audit.
- `scripts/audit_public_safety.sh` checks for common private-data leaks before publishing.
- `docs/workflows.md` explains practical pane assignment patterns.
- `docs/oss-maintainer-use-cases.md` maps the tool to maintainer workflows.
- `scripts/doctor.sh` checks a user's local setup before launch.

## Boundary

This is not a hosted service and does not manage accounts. It launches local terminal sessions and keeps generated work in a local shared folder.

That boundary is deliberate: it makes the project easier to audit, fork, and adapt.
