#!/usr/bin/env bash
set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR" || exit 1

echo "Claude Code Workbench doctor"
echo

fail=0

check_command() {
  local label="$1"
  local command_name="$2"
  if command -v "$command_name" >/dev/null 2>&1; then
    printf "ok   %-18s %s\n" "$label" "$(command -v "$command_name")"
  else
    printf "miss %-18s %s\n" "$label" "$command_name"
    fail=1
  fi
}

check_file() {
  local path="$1"
  if [[ -f "$path" ]]; then
    printf "ok   %-18s %s\n" "file" "$path"
  else
    printf "miss %-18s %s\n" "file" "$path"
    fail=1
  fi
}

check_command "tmux" "${TMUX_BIN:-tmux}"

if [[ -n "${CLAUDE_WORKBENCH_COMMAND:-}" ]]; then
  if command -v "$CLAUDE_WORKBENCH_COMMAND" >/dev/null 2>&1; then
    printf "ok   %-18s %s\n" "claude command" "$(command -v "$CLAUDE_WORKBENCH_COMMAND")"
  else
    printf "miss %-18s %s\n" "claude command" "$CLAUDE_WORKBENCH_COMMAND"
    fail=1
  fi
else
  check_command "claude" "claude"
fi

check_file "scripts/launch_claude_tmux.sh"
check_file "scripts/audit_public_safety.sh"
check_file "Tests/test_claude_workbench_config.sh"

echo
if ./scripts/audit_public_safety.sh >/dev/null; then
  echo "ok   public safety audit"
else
  echo "fail public safety audit"
  fail=1
fi

echo
if (( fail == 0 )); then
  echo "Ready to launch:"
  echo "  ./scripts/launch_claude_tmux.sh"
else
  echo "Fix the missing items above, then run this doctor again."
fi

exit "$fail"
