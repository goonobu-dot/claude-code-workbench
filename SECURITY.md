# Security

## Reporting A Vulnerability

Please open a private advisory or contact the maintainer directly if you find a vulnerability.

Do not publish:

- API keys or access tokens
- local prompt histories
- terminal logs
- Obsidian vault contents
- `.env` files
- generated agent output containing personal data

## Local Behavior

This project launches local terminal sessions and does not intentionally send data anywhere by itself. The Claude Code CLI you run inside each pane may use its own account, configuration, and network behavior.

Review the scripts before running them with custom workspace paths or elevated permissions.
