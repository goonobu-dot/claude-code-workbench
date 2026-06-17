#!/usr/bin/env bash
set -euo pipefail

LOOPS_FILE="${1:-docs/continuous-improvement-loops.md}"
EXPECTED="${2:-50}"

if [[ ! -f "$LOOPS_FILE" ]]; then
  echo "Missing loop file: $LOOPS_FILE" >&2
  exit 1
fi

count="$(grep -Ec '^\| Loop [0-9]{2} \|' "$LOOPS_FILE")"
if [[ "$count" -ne "$EXPECTED" ]]; then
  echo "Expected $EXPECTED continuous improvement loops, found $count" >&2
  exit 1
fi

printf -v last_loop 'Loop %02d' "$EXPECTED"
grep -Fq 'Loop 01' "$LOOPS_FILE" || { echo "Missing Loop 01" >&2; exit 1; }
grep -Fq "$last_loop" "$LOOPS_FILE" || { echo "Missing $last_loop" >&2; exit 1; }

echo "Continuous improvement loop check passed: $count loops"
