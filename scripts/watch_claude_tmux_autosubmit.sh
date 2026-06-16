#!/usr/bin/env bash
set -euo pipefail

TMUX_BIN="${TMUX_BIN:-/opt/homebrew/bin/tmux}"
SESSION_NAME="${CLAUDE_WORKBENCH_SESSION:-claude-code-9}"
PANE_COUNT="${CLAUDE_WORKBENCH_PANE_COUNT:-9}"
AUTO_SUBMIT_DELAY="${CLAUDE_WORKBENCH_AUTO_SUBMIT_DELAY:-4}"
POLL_INTERVAL="${CLAUDE_WORKBENCH_AUTO_SUBMIT_POLL:-0.5}"

last_text=()
last_seen=()
submitted_text=()

current_prompt_text() {
  local target="$1"
  "$TMUX_BIN" capture-pane -t "$target" -p -S -8 2>/dev/null |
    awk '
      /❯/ { line=$0 }
      END {
        sub(/^.*❯[[:space:]]*/, "", line)
        sub(/[[:space:]]+$/, "", line)
        print line
      }
    '
}

while "$TMUX_BIN" has-session -t "$SESSION_NAME" 2>/dev/null; do
  now="$(date +%s)"
  for pane_index in $(seq 0 $((PANE_COUNT - 1))); do
    target="$SESSION_NAME:0.$pane_index"
    text="$(current_prompt_text "$target")"

    if [[ -z "$text" ]]; then
      last_text[$pane_index]=""
      last_seen[$pane_index]="$now"
      submitted_text[$pane_index]=""
      continue
    fi

    if [[ "${submitted_text[$pane_index]:-}" == "$text" ]]; then
      continue
    fi

    if [[ "${last_text[$pane_index]:-}" != "$text" ]]; then
      last_text[$pane_index]="$text"
      last_seen[$pane_index]="$now"
      continue
    fi

    if (( now - ${last_seen[$pane_index]:-$now} >= AUTO_SUBMIT_DELAY )); then
      "$TMUX_BIN" send-keys -t "$target" Enter
      submitted_text[$pane_index]="$text"
      last_text[$pane_index]=""
      last_seen[$pane_index]="$now"
    fi
  done
  sleep "$POLL_INTERVAL"
done
