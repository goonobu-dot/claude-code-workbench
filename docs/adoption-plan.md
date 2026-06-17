# Adoption Plan

This project is early, so adoption depends on reducing friction and making the value obvious.

## Target Users

- developers already using Claude Code CLI
- open-source maintainers experimenting with parallel AI-agent workflows
- users comfortable with macOS, Terminal, and tmux

## Adoption Hooks

1. One-command install:

   ```bash
   curl -fsSL https://raw.githubusercontent.com/goonobu-dot/claude-code-workbench/main/scripts/install.sh | bash
   ```

2. Demo folder:

   `examples/issue-triage-demo`

3. Workflow templates:

   ```bash
   ./scripts/new_workflow.sh issue-triage
   ./scripts/new_workflow.sh pr-review
   ./scripts/new_workflow.sh release-prep
   ```

4. Handoff summary:

   ```bash
   ./scripts/close_workflow.sh "$HOME/ClaudeCodeWorkbench/Idea"
   ```

## Near-Term Outreach

- Share a short X post with the repository link.
- Add a screenshot or short GIF showing the tmux grid.
- Ask for feedback from developers already using Claude Code CLI.
- Open roadmap issues so visitors can see the project is actively maintained.

## Success Signals

- stars or forks from people outside the maintainer account
- issue comments or workflow suggestions
- clones from unique users
- PRs that improve templates or installation
- maintainers adapting the workflow to their own repos

## Principle

Do not fake adoption. Make the repository easy to understand, easy to install, and easy to evaluate. Let real usage emerge from that.
