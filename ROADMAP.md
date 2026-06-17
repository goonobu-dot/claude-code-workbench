# Roadmap

Claude Code Workbench is focused on practical, local-first AI-agent workflows for open-source maintenance.

## Current Focus

- Claude Code CLI multi-pane workbench for macOS and tmux.
- Repeatable maintainer workflows for issue triage, pull request review, release preparation, and feature discovery.
- Handoff summaries that turn parallel agent work into reviewable maintainer notes.
- Safety checks that reduce the chance of publishing private local data.

## Near-Term Improvements

- Generated workflow import/export for sharing review artifacts without local paths.
- A public demo walkthrough that starts from a GitHub issue or pull request and ends with a handoff summary.
- More role prompt templates for maintainer workflows beyond triage, review, release prep, and feature discovery.
- Stronger markdown safety checks for generated workflow outputs.
- Clearer examples of when to use 4, 6, or 9 panes.

## Larger Ideas

- Shared workflow format across Claude Code Workbench and Local Agent Workbench.
- Optional GitHub issue/PR helpers that create workflow folders from public issue URLs.
- Adapter boundaries for additional local agent CLIs.

## Non-Goals

- Hosted account management.
- Cloud storage of user workflows.
- Hidden telemetry.
- Replacing human maintainer judgment.

The project should stay small enough that a maintainer can inspect the scripts and understand what will run locally.
