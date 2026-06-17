#!/usr/bin/env bash
set -euo pipefail

SOURCE_URL="${1:-}"
DEST_DIR="${2:-}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<'EOF'
Usage:
  ./scripts/create_workflow_from_url.sh <github-issue-or-pr-url> [destination]

Creates an issue-triage workflow for GitHub issue URLs and a pr-review
workflow for GitHub pull request URLs. This script does not call the GitHub API;
it records the public URL in question.md so panes have a shared starting point.
EOF
}

if [[ -z "$SOURCE_URL" || "$SOURCE_URL" == "-h" || "$SOURCE_URL" == "--help" ]]; then
  usage
  exit 0
fi

parsed_file="$(mktemp)"
trap 'rm -f "$parsed_file"' EXIT

python3 - "$SOURCE_URL" "$DEST_DIR" "${CLAUDE_WORKBENCH_BASE:-$HOME/ClaudeCodeWorkbench}" >"$parsed_file" <<'PY'
from __future__ import annotations

import re
import sys
from pathlib import Path

url = sys.argv[1].strip()
dest_arg = sys.argv[2].strip()
base_dir = Path(sys.argv[3]).expanduser()

match = re.match(r"^https://github\.com/([^/\s]+)/([^/\s]+)/(issues|pull)/([0-9]+)(?:[/?#].*)?$", url)
if not match:
    print("Expected a GitHub issue or pull request URL, for example:", file=sys.stderr)
    print("  https://github.com/owner/repo/issues/123", file=sys.stderr)
    print("  https://github.com/owner/repo/pull/123", file=sys.stderr)
    raise SystemExit(1)

owner, repo, kind, number = match.groups()
workflow = "issue-triage" if kind == "issues" else "pr-review"
slug = f"{owner}-{repo}-{'issue' if kind == 'issues' else 'pr'}-{number}"
dest = Path(dest_arg).expanduser() if dest_arg else base_dir / "Idea" / slug
canonical_url = f"https://github.com/{owner}/{repo}/{kind}/{number}"

for value in (workflow, str(dest), owner, repo, kind, number, canonical_url):
    print(value)
PY

WORKFLOW="$(sed -n '1p' "$parsed_file")"
DEST_DIR="$(sed -n '2p' "$parsed_file")"
OWNER="$(sed -n '3p' "$parsed_file")"
REPO="$(sed -n '4p' "$parsed_file")"
KIND="$(sed -n '5p' "$parsed_file")"
NUMBER="$(sed -n '6p' "$parsed_file")"
CANONICAL_URL="$(sed -n '7p' "$parsed_file")"

"$SCRIPT_DIR/new_workflow.sh" "$WORKFLOW" "$DEST_DIR" >/dev/null

if [[ "$KIND" == "issues" ]]; then
  TITLE="Issue Triage"
  ITEM_LABEL="Issue"
else
  TITLE="PR Review"
  ITEM_LABEL="Pull Request"
fi

cat >"$DEST_DIR/question.md" <<EOF
# $TITLE

Source URL: $SOURCE_URL
Canonical URL: $CANONICAL_URL

Repository: $OWNER/$REPO
$ITEM_LABEL: #$NUMBER

## Context To Paste

Paste the issue or pull request summary, relevant comments, logs, failing checks, and maintainer goal here.

## Review Goal

Use the generated pane roles to produce concrete markdown notes and a final maintainer-facing summary.
EOF

echo "Workflow from URL ready:"
echo "  $DEST_DIR"
echo
echo "Launch panes with:"
echo "  CLAUDE_WORKBENCH_IDEA_DIR=\"$DEST_DIR\" CLAUDE_WORKBENCH_USE_ROLE_PROMPTS=1 ./scripts/launch_claude_tmux.sh"
