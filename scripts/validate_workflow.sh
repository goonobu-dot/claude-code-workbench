#!/usr/bin/env bash
set -euo pipefail

WORKFLOW_DIR="${1:-${CLAUDE_WORKBENCH_IDEA_DIR:-$HOME/ClaudeCodeWorkbench/Idea}}"

usage() {
  cat <<'EOF'
Usage:
  ./scripts/validate_workflow.sh [workflow-dir]

Checks that a workflow folder has the expected markdown files and does not
appear to contain common private-data patterns.
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ ! -d "$WORKFLOW_DIR" ]]; then
  echo "Workflow directory not found: $WORKFLOW_DIR"
  exit 1
fi

python3 - "$WORKFLOW_DIR" <<'PY'
from __future__ import annotations

import re
import sys
from pathlib import Path

workflow_dir = Path(sys.argv[1]).resolve()
required_files = ["question.md", "pane-roles.md"]
patterns = [
    re.compile("/" + r"Users/[A-Za-z0-9._-]+"),
    re.compile("ghp" + r"_[A-Za-z0-9_]+"),
    re.compile("github" + r"_pat_[A-Za-z0-9_]+"),
    re.compile("sk" + r"-[A-Za-z0-9_-]+"),
    re.compile("OPENAI" + r"_API_KEY|ANTHROPIC" + r"_API_KEY|X" + r"_API|TWITTER" + r"_[A-Z_]+"),
    re.compile("BEGIN " + r"(RSA|OPENSSH|EC) PRIVATE KEY"),
]

errors: list[str] = []
for filename in required_files:
    if not (workflow_dir / filename).is_file():
        errors.append(f"Missing required workflow file: {filename}")

markdown_files = sorted(path for path in workflow_dir.rglob("*.md") if path.is_file())
if not markdown_files:
    errors.append("No markdown files found.")

matches: list[str] = []
for path in markdown_files:
    rel = path.relative_to(workflow_dir)
    text = path.read_text(encoding="utf-8", errors="ignore")
    for line_number, line in enumerate(text.splitlines(), start=1):
        if any(pattern.search(line) for pattern in patterns):
            matches.append(f"{rel}:{line_number}:{line}")

if matches:
    errors.append("Potential private data found:")
    errors.extend(matches)

if errors:
    for error in errors:
        print(error)
    raise SystemExit(1)

print(f"Workflow validation passed: {workflow_dir}")
PY
