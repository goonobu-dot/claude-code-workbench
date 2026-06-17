#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

fail=0

check_contains() {
  local file="$1"
  local expected="$2"
  if ! grep -Fq -- "$expected" "$file"; then
    echo "missing in $file: $expected"
    fail=1
  fi
}

check_not_contains() {
  local file="$1"
  local unexpected="$2"
  if grep -Fq -- "$unexpected" "$file"; then
    echo "unexpected in $file: $unexpected"
    fail=1
  fi
}

private_home='/'"Users"'/admin'

check_contains scripts/launch_claude_tmux.sh 'PANE_COUNT="${CLAUDE_WORKBENCH_PANE_COUNT:-9}"'
check_contains scripts/launch_claude_tmux.sh 'SESSION_NAME="${CLAUDE_WORKBENCH_SESSION:-claude-code-9}"'
check_contains scripts/launch_claude_tmux.sh 'CLAUDE_COMMAND="${CLAUDE_WORKBENCH_COMMAND:-}"'
check_contains scripts/launch_claude_tmux.sh '$HOME/.local/bin/claude'
check_contains scripts/launch_claude_tmux.sh 'IDEA_DIR="${CLAUDE_WORKBENCH_IDEA_DIR:-$BASE_DIR/Idea}"'
check_contains scripts/launch_claude_tmux.sh 'workspace="$IDEA_DIR"'
check_contains scripts/launch_claude_tmux.sh 'CLAUDE_APPEND_SYSTEM_PROMPT="${CLAUDE_WORKBENCH_APPEND_SYSTEM_PROMPT:-'
check_contains scripts/launch_claude_tmux.sh '--append-system-prompt %q'
check_contains scripts/launch_claude_tmux.sh 'AUTO_SUBMIT="${CLAUDE_WORKBENCH_AUTO_SUBMIT:-1}"'
check_contains scripts/launch_claude_tmux.sh 'watch_claude_tmux_autosubmit.sh'
check_contains scripts/watch_claude_tmux_autosubmit.sh 'SESSION_NAME="${CLAUDE_WORKBENCH_SESSION:-claude-code-9}"'
check_contains scripts/watch_claude_tmux_autosubmit.sh 'AUTO_SUBMIT_DELAY="${CLAUDE_WORKBENCH_AUTO_SUBMIT_DELAY:-4}"'
check_contains scripts/build_claude_app.sh 'APP_BUNDLE="${CLAUDE_WORKBENCH_APP_BUNDLE:-$HOME/Applications/Claude Code Workbench.app}"'
check_contains scripts/build_claude_app.sh 'CLAUDE_WORKBENCH_REGENERATE_ICON'
check_contains scripts/build_claude_app.sh 'SCRIPT_PATH="$ROOT_DIR/scripts/launch_claude_tmux.applescript"'
check_contains scripts/build_claude_app.sh 'ICON_NAME="ClaudeCode9Panes"'
check_contains scripts/launch_claude_tmux.applescript 'system attribute "CLAUDE_WORKBENCH_SCRIPT"'
check_contains scripts/launch_claude_tmux.applescript 'Claude Code 9 tmux'
check_contains scripts/send_enter_to_claude_tmux.applescript 'claude-code-9'
check_contains scripts/create_app_icon.py 'ClaudeCode9Panes.iconset'
check_contains scripts/create_app_icon.py 'ClaudeCode9Panes.png'
check_contains scripts/create_app_icon.py '"9"'
check_contains scripts/doctor.sh 'Claude Code Workbench doctor'
check_contains scripts/install.sh 'Claude Code Workbench installer'
check_contains scripts/install.sh 'CLAUDE_WORKBENCH_INSTALL_DIR'
check_contains scripts/new_workflow.sh 'issue-triage'
check_contains scripts/new_workflow.sh 'CLAUDE_WORKBENCH_IDEA_DIR'
check_contains scripts/close_workflow.sh 'Workflow Handoff Summary'
check_contains scripts/close_workflow.sh 'Empty Sections To Fill'
check_contains README.md 'docs/oss-maintainer-use-cases.md'
check_contains README.md 'docs/showcase.md'
check_contains README.md 'docs/workflow-templates.md'
check_contains README.md 'docs/openai-codex-for-oss.md'
check_contains README.md 'docs/adoption-plan.md'
check_contains README.md 'examples/issue-triage-demo'
check_contains README.md 'ROADMAP.md'
check_contains ROADMAP.md 'Near-Term Improvements'
check_contains CHANGELOG.md 'v0.5.0'
check_contains docs/openai-codex-for-oss.md 'Relationship To Codex Work'
check_contains docs/adoption-plan.md 'Do not fake adoption'
check_contains examples/README.md 'issue-triage-demo'
check_contains examples/issue-triage-demo/README.md 'Fictional demo'
check_contains examples/issue-triage-demo/final-triage.md 'Recommended Fix'
check_contains examples/issue-triage-demo/handoff-summary.md 'Workflow Handoff Summary'

check_not_contains scripts/launch_claude_tmux.sh "$private_home"
check_not_contains scripts/launch_claude_tmux.applescript "$private_home"
check_not_contains README.md "$private_home"
check_not_contains scripts/launch_claude_tmux.sh 'Idea-$pane_number'
check_not_contains scripts/build_claude_app.sh 'LEGACY_APP_BUNDLE'
check_not_contains scripts/build_claude_app.sh 'launch_12_claude_terminals.applescript'

exit "$fail"
