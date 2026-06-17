#!/usr/bin/env bash
set -euo pipefail

echo "Claude Code Workbench uninstaller"

BASE_DIR="${CLAUDE_WORKBENCH_BASE:-$HOME/ClaudeCodeWorkbench}"
INSTALL_DIR="${CLAUDE_WORKBENCH_INSTALL_DIR:-$BASE_DIR/claude-code-workbench}"
APP_BUNDLE="${CLAUDE_WORKBENCH_APP_BUNDLE:-$HOME/Applications/Claude Code Workbench.app}"
IDEA_DIR="${CLAUDE_WORKBENCH_IDEA_DIR:-$BASE_DIR/Idea}"
REMOVE_APP="${CLAUDE_WORKBENCH_REMOVE_APP:-0}"
REMOVE_IDEA="${CLAUDE_WORKBENCH_REMOVE_IDEA:-0}"
CONFIRM="${CLAUDE_WORKBENCH_CONFIRM_UNINSTALL:-0}"

cat <<EOF
Install directory: $INSTALL_DIR
App bundle:        $APP_BUNDLE
Idea directory:    $IDEA_DIR

This script only removes files when confirmation is explicit.
Set CLAUDE_WORKBENCH_CONFIRM_UNINSTALL=1 to remove the install directory.
Set CLAUDE_WORKBENCH_REMOVE_APP=1 to also remove the app bundle.
Set CLAUDE_WORKBENCH_REMOVE_IDEA=1 to also remove the idea directory.
EOF

if [[ "$CONFIRM" != "1" ]]; then
  echo "No files removed."
  exit 0
fi

rm -rf "$INSTALL_DIR"

if [[ "$REMOVE_APP" == "1" ]]; then
  rm -rf "$APP_BUNDLE"
fi

if [[ "$REMOVE_IDEA" == "1" ]]; then
  rm -rf "$IDEA_DIR"
fi

echo "Uninstall complete."
