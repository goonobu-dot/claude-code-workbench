#!/usr/bin/env bash
set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR" || exit 1

REPORT_PATH=""
if [[ "${1:-}" == "--report" ]]; then
  REPORT_PATH="${2:-}"
  if [[ -z "$REPORT_PATH" ]]; then
    echo "Usage: ./scripts/doctor.sh [--report path.md]"
    exit 2
  fi
elif [[ $# -gt 0 ]]; then
  echo "Usage: ./scripts/doctor.sh [--report path.md]"
  exit 2
fi

DOCTOR_LOG="$(mktemp)"
cleanup() {
  rm -f "$DOCTOR_LOG"
}
trap cleanup EXIT

say() {
  printf "%s\n" "$*" | tee -a "$DOCTOR_LOG"
}

sayf() {
  printf "$@" | tee -a "$DOCTOR_LOG"
}

fail=0
recommendations=()

add_recommendation() {
  recommendations+=("$1")
}

check_command() {
  local label="$1"
  local command_name="$2"
  local advice="${3:-}"
  if command -v "$command_name" >/dev/null 2>&1; then
    sayf "ok   %-18s %s\n" "$label" "$(command -v "$command_name")"
  else
    sayf "miss %-18s %s\n" "$label" "$command_name"
    if [[ -n "$advice" ]]; then
      add_recommendation "$advice"
    fi
    fail=1
  fi
}

check_file() {
  local path="$1"
  if [[ -f "$path" ]]; then
    sayf "ok   %-18s %s\n" "file" "$path"
  else
    sayf "miss %-18s %s\n" "file" "$path"
    add_recommendation "Reinstall or update the checkout: ./scripts/install.sh"
    fail=1
  fi
}

write_report() {
  [[ -z "$REPORT_PATH" ]] && return
  mkdir -p "$(dirname "$REPORT_PATH")"
  {
    echo "# Claude Code Workbench Doctor Report"
    echo
    if (( fail == 0 )); then
      echo "- Status: ready"
    else
      echo "- Status: needs attention"
    fi
    echo "- Generated: $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
    echo
    echo "## Raw Output"
    echo
    echo '```text'
    cat "$DOCTOR_LOG"
    echo '```'
  } >"$REPORT_PATH"
  say
  say "Doctor report written to: $REPORT_PATH"
}

say "Claude Code Workbench doctor"
say

check_command "tmux" "${TMUX_BIN:-tmux}" "Install tmux with Homebrew: brew install tmux"

if [[ -n "${CLAUDE_WORKBENCH_COMMAND:-}" ]]; then
  if command -v "$CLAUDE_WORKBENCH_COMMAND" >/dev/null 2>&1; then
    sayf "ok   %-18s %s\n" "claude command" "$(command -v "$CLAUDE_WORKBENCH_COMMAND")"
  else
    sayf "miss %-18s %s\n" "claude command" "$CLAUDE_WORKBENCH_COMMAND"
    add_recommendation "Set CLAUDE_WORKBENCH_COMMAND to a valid Claude Code CLI path, or put claude on PATH."
    fail=1
  fi
else
  check_command "claude" "claude" "Install Claude Code CLI or set CLAUDE_WORKBENCH_COMMAND to its full path."
fi

check_file "scripts/launch_claude_tmux.sh"
check_file "scripts/audit_public_safety.sh"
check_file "Tests/test_claude_workbench_config.sh"

say
if ./scripts/audit_public_safety.sh >/dev/null; then
  say "ok   public safety audit"
else
  say "fail public safety audit"
  fail=1
fi

say
if (( fail == 0 )); then
  say "Ready to launch:"
  say "  ./scripts/launch_claude_tmux.sh"
else
  say "Fix the missing items above, then run this doctor again."
  if (( ${#recommendations[@]} > 0 )); then
    say
    say "Suggested fixes:"
    for recommendation in "${recommendations[@]}"; do
      say "  - $recommendation"
    done
  fi
fi

write_report
exit "$fail"
