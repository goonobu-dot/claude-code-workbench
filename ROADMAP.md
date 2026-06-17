# Roadmap

Claude Code Workbench is focused on practical, local-first AI-agent workflows for open-source maintenance.

## Current Focus

- Claude Code CLI multi-pane workbench for macOS and tmux.
- Repeatable maintainer workflows for issue triage, pull request review, release preparation, and feature discovery.
- Handoff summaries that turn parallel agent work into reviewable maintainer notes.
- Safety checks that reduce the chance of publishing private local data.

## Near-Term Improvements

- More end-to-end examples for pull request review and release preparation.
- Better starter prompts for each workflow role.
- Optional pane seeding so each pane can start with a role-specific prompt.
- More robust install diagnostics for users new to tmux.
- Screenshots or short demo assets for the README.

## Larger Ideas

- Shared workflow format across Claude Code Workbench and Local Agent Workbench.
- Import/export of workflow folders for maintainers who want to share review artifacts.
- Optional GitHub issue/PR helpers that create workflow folders from public issue URLs.
- Additional safety checks for generated markdown before publication.

## Non-Goals

- Hosted account management.
- Cloud storage of user workflows.
- Hidden telemetry.
- Replacing human maintainer judgment.

The project should stay small enough that a maintainer can inspect the scripts and understand what will run locally.
