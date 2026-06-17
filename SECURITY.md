# Security Policy

Claude Code Workbench is a local macOS/tmux utility. It does not run a hosted service, collect telemetry, or require cloud credentials.

## Reporting Security Issues

Open a GitHub issue if the report does not contain sensitive data. Use a private channel if the report requires unreleased exploit details or private logs.

Do not include secrets in public issues:

- API keys
- access tokens
- private keys
- local absolute paths that reveal private usernames or project names
- unpublished customer, employer, or client data

## Before Sharing Workflow Output

Run the public safety audit:

```bash
./scripts/audit_public_safety.sh
```

For generated workflow folders, also run:

```bash
./scripts/validate_workflow.sh <workflow-dir>
```

These checks reduce common publishing mistakes. They do not prove that generated notes are factually correct or safe to publish without human review.

## Local Boundary

This project launches local CLI sessions and writes markdown files in local folders. Review prompts, generated notes, archives, and issue attachments before sharing them.
