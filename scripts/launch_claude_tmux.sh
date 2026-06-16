#!/usr/bin/env bash
set -euo pipefail

PANE_COUNT="${CLAUDE_WORKBENCH_PANE_COUNT:-9}"
SESSION_NAME="${CLAUDE_WORKBENCH_SESSION:-claude-code-9}"
LEGACY_SESSION_NAME="${CLAUDE_WORKBENCH_LEGACY_SESSION:-claude-code-6}"
CLAUDE_COMMAND="${CLAUDE_WORKBENCH_COMMAND:-}"
CLAUDE_MODEL="${CLAUDE_WORKBENCH_MODEL:-sonnet}"
CLAUDE_EFFORT="${CLAUDE_WORKBENCH_EFFORT:-low}"
CLAUDE_PERMISSION_MODE="${CLAUDE_WORKBENCH_PERMISSION_MODE:-auto}"
CLAUDE_APPEND_SYSTEM_PROMPT="${CLAUDE_WORKBENCH_APPEND_SYSTEM_PROMPT:-Fast interactive mode: keep responses concise unless the user asks for detail. Do not invoke deep-research automatically. For current news or web-backed requests, use one focused web search first and only run additional searches if the first result is clearly insufficient.}"
AUTO_SUBMIT="${CLAUDE_WORKBENCH_AUTO_SUBMIT:-1}"
TMUX_BIN="${TMUX_BIN:-/opt/homebrew/bin/tmux}"
BASE_DIR="${CLAUDE_WORKBENCH_BASE:-$HOME/ClaudeCodeWorkbench}"
IDEA_DIR="${CLAUDE_WORKBENCH_IDEA_DIR:-$BASE_DIR/Idea}"
ATTACH="${CLAUDE_WORKBENCH_ATTACH:-1}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ ! "$PANE_COUNT" =~ ^[0-9]+$ ]] || (( PANE_COUNT < 1 || PANE_COUNT > 12 )); then
  echo "CLAUDE_WORKBENCH_PANE_COUNT must be between 1 and 12."
  exit 1
fi

if [[ ! -x "$TMUX_BIN" ]]; then
  echo "tmux is not installed at $TMUX_BIN"
  echo "Install it with: brew install tmux"
  exit 1
fi

if [[ -z "$CLAUDE_COMMAND" ]]; then
  for candidate in \
    "$HOME/.local/bin/claude" \
    /opt/homebrew/bin/claude \
    /usr/local/bin/claude \
    claude; do
    if command -v "$candidate" >/dev/null 2>&1; then
      CLAUDE_COMMAND="$(command -v "$candidate")"
      break
    fi
  done
fi

if [[ -z "$CLAUDE_COMMAND" ]] || ! command -v "$CLAUDE_COMMAND" >/dev/null 2>&1; then
  echo "Claude Code CLI was not found. Set CLAUDE_WORKBENCH_COMMAND or install claude on PATH."
  exit 1
fi

mkdir -p "$BASE_DIR" "$IDEA_DIR"

if "$TMUX_BIN" has-session -t "$SESSION_NAME" 2>/dev/null; then
  "$TMUX_BIN" kill-session -t "$SESSION_NAME"
fi

if [[ "$LEGACY_SESSION_NAME" != "$SESSION_NAME" ]] && "$TMUX_BIN" has-session -t "$LEGACY_SESSION_NAME" 2>/dev/null; then
  "$TMUX_BIN" kill-session -t "$LEGACY_SESSION_NAME"
fi

pane_command() {
  local pane_number="$1"
  local pane_name="Claude Code $pane_number"
  printf 'clear; printf "\\033]0;%s\\007"; echo "%s (%s/%s/%s)"; exec %q --model %q --effort %q --permission-mode %q --append-system-prompt %q --name %q' \
    "$pane_name" \
    "$pane_name" \
    "$CLAUDE_MODEL" \
    "$CLAUDE_EFFORT" \
    "$CLAUDE_PERMISSION_MODE" \
    "$CLAUDE_COMMAND" \
    "$CLAUDE_MODEL" \
    "$CLAUDE_EFFORT" \
    "$CLAUDE_PERMISSION_MODE" \
    "$CLAUDE_APPEND_SYSTEM_PROMPT" \
    "$pane_name"
}

for pane_number in $(seq 1 "$PANE_COUNT"); do
  workspace="$IDEA_DIR"
  mkdir -p "$workspace"
  if [[ "$pane_number" == "1" ]]; then
    "$TMUX_BIN" new-session -d -s "$SESSION_NAME" -n "Claude $PANE_COUNT" -c "$workspace" "/bin/zsh" "-lc" "$(pane_command "$pane_number")"
  else
    "$TMUX_BIN" split-window -t "$SESSION_NAME:0" -c "$workspace" "/bin/zsh" "-lc" "$(pane_command "$pane_number")"
    "$TMUX_BIN" select-layout -t "$SESSION_NAME:0" tiled >/dev/null
  fi
done

"$TMUX_BIN" select-layout -t "$SESSION_NAME:0" tiled >/dev/null
"$TMUX_BIN" set-option -t "$SESSION_NAME" mouse on >/dev/null
"$TMUX_BIN" set-option -t "$SESSION_NAME" status on >/dev/null
"$TMUX_BIN" set-option -t "$SESSION_NAME" remain-on-exit on >/dev/null

if [[ "$AUTO_SUBMIT" == "1" ]]; then
  CLAUDE_WORKBENCH_SESSION="$SESSION_NAME" \
    CLAUDE_WORKBENCH_PANE_COUNT="$PANE_COUNT" \
    TMUX_BIN="$TMUX_BIN" \
    "$SCRIPT_DIR/watch_claude_tmux_autosubmit.sh" >/dev/null 2>&1 &
fi

if [[ "$ATTACH" == "1" ]]; then
  "$TMUX_BIN" attach-session -t "$SESSION_NAME"
else
  "$TMUX_BIN" list-panes -t "$SESSION_NAME:0"
fi
