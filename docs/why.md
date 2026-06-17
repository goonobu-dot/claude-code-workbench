# Why This Exists

AI coding tools are often used as a single chat thread. That is useful for direct answers, but open-source maintenance often needs parallel maintainer thinking:

- one pass for reproduction
- one pass for tests
- one pass for security and privacy risk
- one pass for docs and release notes
- one skeptical pass that tries to disprove the leading plan

Claude Code Workbench makes that pattern concrete without building a hosted platform.

## The Core Idea

Run multiple local Claude Code panes against one shared workflow folder. Each pane gets a role. The maintainer reviews the outputs and decides what to keep.

The important part is not the number of panes. The important part is separating responsibilities so one answer does not collapse every concern into a single blended response.

## Why Local

Local-first keeps the system inspectable:

- prompts are files
- pane outputs are files
- archives are markdown plus a small manifest
- safety checks run before sharing

There is no telemetry layer and no hosted account system in this repository.

## What It Is Not

This is not a replacement for maintainer judgment. It is a workbench for generating, comparing, and preserving useful notes before a human acts.
