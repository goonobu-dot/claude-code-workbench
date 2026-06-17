#!/usr/bin/env bash
set -euo pipefail

ARCHIVE_FILE="${1:-}"
DEST_DIR="${2:-${CLAUDE_WORKBENCH_IMPORT_DIR:-$HOME/ClaudeCodeWorkbench/Imported}}"

usage() {
  cat <<'EOF'
Usage:
  ./scripts/import_workflow.sh <workflow-export.tar.gz> [destination-dir]

Safely imports a workflow archive created by export_workflow.sh.
The importer refuses absolute paths, parent-directory traversal,
non-markdown files, symlinks, hard links, and special files.
EOF
}

if [[ -z "$ARCHIVE_FILE" || "$ARCHIVE_FILE" == "-h" || "$ARCHIVE_FILE" == "--help" ]]; then
  usage
  exit 0
fi

if [[ ! -f "$ARCHIVE_FILE" ]]; then
  echo "Archive not found: $ARCHIVE_FILE"
  exit 1
fi

mkdir -p "$DEST_DIR"

python3 - "$ARCHIVE_FILE" "$DEST_DIR" <<'PY'
from __future__ import annotations

import sys
import tarfile
from pathlib import Path, PurePosixPath

archive_file = Path(sys.argv[1]).resolve()
dest_dir = Path(sys.argv[2]).resolve()

def fail(message: str) -> None:
    print(message)
    raise SystemExit(1)

try:
    with tarfile.open(archive_file, "r:gz") as archive:
        members = archive.getmembers()
        if not members:
            fail("Archive is empty.")

        for member in members:
            raw_name = member.name
            rel = PurePosixPath(raw_name)
            if rel.is_absolute() or any(part in ("", ".", "..") for part in rel.parts):
                fail(f"Unsafe archive path: {raw_name}")
            if not member.isfile():
                fail(f"Unsafe archive member type: {raw_name}")
            if rel.suffix != ".md":
                fail(f"Only markdown files can be imported: {raw_name}")

            target = (dest_dir / Path(*rel.parts)).resolve()
            try:
                target.relative_to(dest_dir)
            except ValueError:
                fail(f"Unsafe archive path: {raw_name}")

        archive.extractall(dest_dir, members=members)
except tarfile.TarError as exc:
    fail(f"Invalid workflow archive: {exc}")

print(f"Workflow import ready: {dest_dir}")
PY
