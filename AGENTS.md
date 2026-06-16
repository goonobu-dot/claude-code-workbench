# Agent Instructions

This repository is intended for public release.

Rules for AI coding agents:

- Do not commit secrets, tokens, `.env` files, logs, databases, or personal vault content.
- Keep changes local-first and easy to audit.
- Preserve compatibility with the `CLAUDE_WORKBENCH_*` environment variables.
- Do not add generated `.app` bundles or local build folders.
- Run `./Tests/test_claude_workbench_config.sh` before claiming the repo is ready.
