# Command Reference

## Fast Checks

```bash
make demo
make doctor
make doctor-report
make test
```

## Workflow Creation

```bash
./scripts/new_workflow.sh --list
./scripts/new_workflow.sh issue-triage
./scripts/new_workflow.sh pr-review
./scripts/new_workflow.sh release-prep
./scripts/new_workflow.sh feature-discovery
```

Start from a public GitHub URL:

```bash
./scripts/create_workflow_from_url.sh https://github.com/owner/repo/issues/123
./scripts/create_workflow_from_url.sh https://github.com/owner/repo/pull/123
```

## Launch

```bash
./scripts/launch_claude_tmux.sh
CLAUDE_WORKBENCH_USE_ROLE_PROMPTS=1 ./scripts/launch_claude_tmux.sh
```

## Close And Share

```bash
./scripts/close_workflow.sh <workflow-dir>
./scripts/validate_workflow.sh <workflow-dir>
./scripts/export_workflow.sh <workflow-dir>
./scripts/import_workflow.sh <workflow-export.tar.gz>
```

## Safety

```bash
./scripts/audit_public_safety.sh
./scripts/doctor.sh --report doctor-report.md
```
