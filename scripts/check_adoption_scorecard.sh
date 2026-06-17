#!/usr/bin/env bash
set -euo pipefail

SCORECARD="${1:-docs/adoption-scorecard.md}"
EXPECTED=50

if [[ ! -f "$SCORECARD" ]]; then
  echo "Missing adoption scorecard: $SCORECARD" >&2
  exit 1
fi

count="$(grep -Ec '^\| Loop [0-9]{2} \|' "$SCORECARD")"
if [[ "$count" -ne "$EXPECTED" ]]; then
  echo "Expected 50 adoption loops, found $count" >&2
  exit 1
fi

grep -Fq 'Loop 01' "$SCORECARD" || { echo "Missing Loop 01" >&2; exit 1; }
grep -Fq 'Loop 50' "$SCORECARD" || { echo "Missing Loop 50" >&2; exit 1; }

echo "Adoption scorecard passed: $count loops"
