# FAQ

## Does This Expose My Local Mac?

No. A public GitHub repository only exposes files committed and pushed to that repository.

This project launches local terminal sessions and writes markdown files in local folders. Your local files, app data, shell history, and other repositories are not published unless you intentionally copy, commit, and push them.

Before publishing generated output, run:

```bash
./scripts/audit_public_safety.sh
./scripts/validate_workflow.sh <workflow-dir>
```

## What Does GitHub Make Public?

For a public repository, GitHub makes the repository contents, commit history, releases, issues, pull requests, and public discussions visible.

It does not automatically expose unrelated private repositories, local folders, local credentials, or files on your Mac.

## Do I Need API Keys?

The workbench scripts do not require API keys. They launch local CLI tools that you install and authenticate separately.

Do not put API keys, personal access tokens, or `.env` files in this repository.

## Can I Use It Without Opening The macOS App?

Yes. The shell scripts are the main interface:

```bash
make demo
./scripts/new_workflow.sh --list
./scripts/new_workflow.sh issue-triage
```

The app bundle is only a convenience wrapper for launching the tmux layout.
