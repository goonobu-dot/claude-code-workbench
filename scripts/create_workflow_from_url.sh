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
workflow for GitHub pull request URLs. If GitHub CLI is available, it also
tries to add public issue or pull request metadata to question.md. Tests can
inject a fixture with AGENT_WORKBENCH_GITHUB_METADATA_FILE.
EOF
}

if [[ -z "$SOURCE_URL" || "$SOURCE_URL" == "-h" || "$SOURCE_URL" == "--help" ]]; then
  usage
  exit 0
fi

parsed_file="$(mktemp)"
metadata_json_file="$(mktemp)"
trap 'rm -f "$parsed_file" "$metadata_json_file"' EXIT

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

METADATA_BLOCK=""
if [[ -n "${AGENT_WORKBENCH_GITHUB_METADATA_FILE:-}" && -f "${AGENT_WORKBENCH_GITHUB_METADATA_FILE:-}" ]]; then
  cp "$AGENT_WORKBENCH_GITHUB_METADATA_FILE" "$metadata_json_file"
elif command -v gh >/dev/null 2>&1; then
  gh api "repos/$OWNER/$REPO/issues/$NUMBER" >"$metadata_json_file" 2>/dev/null || true
fi

if [[ -s "$metadata_json_file" ]]; then
  METADATA_BLOCK="$(python3 - "$metadata_json_file" <<'PY' || true
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

try:
    data = json.loads(Path(sys.argv[1]).read_text())
except Exception:
    raise SystemExit(0)

title = str(data.get("title") or "").strip()
state = str(data.get("state") or "").strip()
user = data.get("user") if isinstance(data.get("user"), dict) else {}
author = str(user.get("login") or "").strip()
body = str(data.get("body") or "").strip()
body = re.sub(r"\s+", " ", body)
if len(body) > 500:
    body = body[:497].rstrip() + "..."

lines = ["## GitHub Metadata"]
if title:
    lines.append(f"Title: {title}")
if state:
    lines.append(f"State: {state}")
if author:
    lines.append(f"Author: {author}")
if body:
    lines.append(f"Body Excerpt: {body}")

if len(lines) > 1:
    print("\n".join(lines))
PY
)"
fi

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

$METADATA_BLOCK

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
