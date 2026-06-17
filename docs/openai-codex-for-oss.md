# OpenAI Codex For Open Source Context

This companion repository demonstrates the same local-first maintainer workflow pattern with Claude Code CLI.

The primary OpenAI-focused project is `local-agent-workbench`, which uses Codex CLI. This repository helps show that the workflow model is portable across local AI-agent CLIs.

## Why This Matters

Open-source maintainers often compare tools and approaches. A shared workflow pattern across Codex CLI and Claude Code CLI makes it easier to evaluate how parallel agent workflows can support:

- issue triage
- pull request review
- release preparation
- documentation review
- handoff generation

## Evidence In This Repository

- CI validates shell syntax, configuration expectations, installer behavior, workflow generation, handoff generation, and safety audit.
- `scripts/new_workflow.sh` creates structured maintainer workflows.
- `scripts/close_workflow.sh` creates reviewable handoff summaries.
- `examples/issue-triage-demo` shows a fictional end-to-end issue triage flow.
- `examples/pr-review-demo` shows a fictional pull request review flow.

## Relationship To Codex Work

This repository is not the main OpenAI application target. It is a companion implementation that shows the workflow concept can generalize beyond one CLI.
