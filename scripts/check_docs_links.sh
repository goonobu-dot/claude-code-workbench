#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

python3 - <<'PY'
from __future__ import annotations

import re
from pathlib import Path
from urllib.parse import unquote

root = Path.cwd()
markdown_files = sorted(path for path in root.rglob("*.md") if ".git" not in path.parts)
link_pattern = re.compile(r"!?\[[^\]]*\]\(([^)]+)\)")

broken: list[str] = []
for markdown_file in markdown_files:
    text = markdown_file.read_text(encoding="utf-8", errors="ignore")
    for line_number, line in enumerate(text.splitlines(), start=1):
        for match in link_pattern.finditer(line):
            target = match.group(1).strip()
            if not target or target.startswith(("#", "http://", "https://", "mailto:")):
                continue
            target = target.split("#", 1)[0]
            if not target:
                continue
            if target.startswith("<") and target.endswith(">"):
                target = target[1:-1]
            candidate = (markdown_file.parent / unquote(target)).resolve()
            try:
                candidate.relative_to(root)
            except ValueError:
                broken.append(f"{markdown_file.relative_to(root)}:{line_number}: outside repo: {target}")
                continue
            if not candidate.exists():
                broken.append(f"{markdown_file.relative_to(root)}:{line_number}: missing: {target}")

if broken:
    print("Broken documentation links:")
    for item in broken:
        print(item)
    raise SystemExit(1)

print("Documentation links passed.")
PY
