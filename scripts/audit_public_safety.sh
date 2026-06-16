#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

python3 - <<'PY'
from __future__ import annotations

import re
import sys
from pathlib import Path

root = Path.cwd()
skip_dirs = {".git", "Assets"}
skip_suffixes = {".icns", ".png"}
local_only_names = {".env"}
local_only_suffixes = {".log", ".sqlite", ".sqlite3", ".db"}

patterns = [
    re.compile("/" + r"Users/[A-Za-z0-9._-]+"),
    re.compile("ghp" + r"_[A-Za-z0-9_]+"),
    re.compile("github" + r"_pat_[A-Za-z0-9_]+"),
    re.compile("sk" + r"-[A-Za-z0-9_-]+"),
    re.compile("OPENAI" + r"_API_KEY|ANTHROPIC" + r"_API_KEY|X" + r"_API|TWITTER" + r"_[A-Z_]+"),
    re.compile("BEGIN " + r"(RSA|OPENSSH|EC) PRIVATE KEY"),
]

matches: list[str] = []
local_files: list[str] = []

for path in sorted(root.rglob("*")):
    rel = path.relative_to(root)
    if any(part in skip_dirs for part in rel.parts):
        continue
    if path.is_dir():
        continue

    if path.name in local_only_names or path.suffix in local_only_suffixes or path.name.startswith(".env."):
        local_files.append(str(rel))
        continue

    if path.suffix in skip_suffixes:
        continue

    try:
        text = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        continue

    for line_number, line in enumerate(text.splitlines(), start=1):
        if any(pattern.search(line) for pattern in patterns):
            matches.append(f"{rel}:{line_number}:{line}")

if local_files:
    print("Local-only files were found. Remove them before publishing:")
    for rel in local_files:
        print(rel)

if matches:
    print("Potential private data found. Review the matches below before publishing:")
    for match in matches:
        print(match)

if local_files or matches:
    sys.exit(1)

print("Public safety audit passed.")
PY
