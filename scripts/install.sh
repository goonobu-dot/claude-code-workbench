#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${CLAUDE_WORKBENCH_REPO_URL:-https://github.com/goonobu-dot/claude-code-workbench.git}"
INSTALL_DIR="${CLAUDE_WORKBENCH_INSTALL_DIR:-$HOME/ClaudeCodeWorkbench/claude-code-workbench}"
SKIP_APP="${CLAUDE_WORKBENCH_SKIP_APP:-0}"

echo "Claude Code Workbench installer"
echo

if ! command -v git >/dev/null 2>&1; then
  echo "git is required."
  exit 1
fi

if [[ -d "$INSTALL_DIR/.git" ]]; then
  echo "Updating existing checkout: $INSTALL_DIR"
  git -C "$INSTALL_DIR" pull --ff-only
else
  echo "Cloning into: $INSTALL_DIR"
  mkdir -p "$(dirname "$INSTALL_DIR")"
  git clone "$REPO_URL" "$INSTALL_DIR"
fi

cd "$INSTALL_DIR"
chmod +x scripts/*.sh Tests/*.sh

echo
./scripts/doctor.sh || true

if [[ "$SKIP_APP" != "1" && "$(uname -s)" == "Darwin" ]]; then
  if command -v osacompile >/dev/null 2>&1 && command -v iconutil >/dev/null 2>&1; then
    echo
    echo "Building macOS app shortcut..."
    ./scripts/build_claude_app.sh
  else
    echo "Skipping app build because osacompile or iconutil is missing."
  fi
fi

echo
echo "Installed."
echo
echo "Launch from Terminal:"
echo "  cd \"$INSTALL_DIR\""
echo "  ./scripts/launch_claude_tmux.sh"
echo
echo "Create a maintainer workflow:"
echo "  ./scripts/new_workflow.sh issue-triage"
