#!/usr/bin/env bash
set -euo pipefail

WORKFLOW_DIR="${1:-${CLAUDE_WORKBENCH_IDEA_DIR:-$HOME/ClaudeCodeWorkbench/Idea}}"
OUTPUT_FILE="${2:-}"

usage() {
  cat <<'EOF'
Usage:
  ./scripts/export_workflow.sh [workflow-dir] [output-file.tar.gz]

Creates a portable archive from workflow markdown files.
The export refuses markdown that appears to contain local absolute paths,
API keys, access tokens, private keys, or local-only data references.
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

if [[ -z "$OUTPUT_FILE" ]]; then
  OUTPUT_FILE="$(pwd)/$(basename "$WORKFLOW_DIR")-workflow-export.tar.gz"
fi

mkdir -p "$(dirname "$OUTPUT_FILE")"

python3 - "$WORKFLOW_DIR" "$OUTPUT_FILE" <<'PY'
from __future__ import annotations

import re
import sys
import tarfile
import tempfile
import json
from pathlib import Path

workflow_dir = Path(sys.argv[1]).resolve()
output_file = Path(sys.argv[2]).resolve()
archive_root = workflow_dir.name

patterns = [
    re.compile("/" + r"Users/[A-Za-z0-9._-]+"),
    re.compile("ghp" + r"_[A-Za-z0-9_]+"),
    re.compile("github" + r"_pat_[A-Za-z0-9_]+"),
    re.compile("sk" + r"-[A-Za-z0-9_-]+"),
    re.compile("OPENAI" + r"_API_KEY|ANTHROPIC" + r"_API_KEY|X" + r"_API|TWITTER" + r"_[A-Z_]+"),
    re.compile("BEGIN " + r"(RSA|OPENSSH|EC) PRIVATE KEY"),
]

markdown_files = sorted(path for path in workflow_dir.rglob("*.md") if path.is_file())
if not markdown_files:
    print("No markdown files found to export.")
    raise SystemExit(1)

matches: list[str] = []
for path in markdown_files:
    rel = path.relative_to(workflow_dir)
    text = path.read_text(encoding="utf-8", errors="ignore")
    for line_number, line in enumerate(text.splitlines(), start=1):
        if any(pattern.search(line) for pattern in patterns):
            matches.append(f"{rel}:{line_number}:{line}")

if matches:
    print("Potential private data found. Review before exporting:")
    for match in matches:
        print(match)
    raise SystemExit(1)

with tempfile.NamedTemporaryFile(prefix="workflow-export-", suffix=".tar.gz", delete=False) as tmp:
    tmp_path = Path(tmp.name)

try:
    with tarfile.open(tmp_path, "w:gz") as archive:
        for path in markdown_files:
            rel = path.relative_to(workflow_dir)
            archive.add(path, arcname=str(Path(archive_root) / rel), recursive=False)
        manifest = {
            "format": "claude-code-workbench.workflow.v1",
            "workflow": archive_root,
            "files": [str(path.relative_to(workflow_dir)) for path in markdown_files],
        }
        manifest_bytes = json.dumps(manifest, indent=2, sort_keys=True).encode("utf-8")
        manifest_info = tarfile.TarInfo(str(Path(archive_root) / "workflow-manifest.json"))
        manifest_info.size = len(manifest_bytes)
        with tempfile.TemporaryFile() as manifest_file:
            manifest_file.write(manifest_bytes)
            manifest_file.seek(0)
            archive.addfile(manifest_info, manifest_file)
    tmp_path.replace(output_file)
finally:
    if tmp_path.exists():
        tmp_path.unlink()

print(f"Workflow export ready: {output_file}")
PY
