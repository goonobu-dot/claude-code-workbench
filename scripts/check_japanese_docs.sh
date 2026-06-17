#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

fail=0

check_contains() {
  local file="$1"
  local expected="$2"
  if ! grep -Fq -- "$expected" "$file"; then
    echo "missing in $file: $expected"
    fail=1
  fi
}

check_contains README.md 'README.ja.md'
check_contains README.ja.md 'Claude Code Workbench 日本語ガイド'
check_contains README.ja.md 'docs/ja/install.md'
check_contains README.ja.md 'docs/ja/share.md'
check_contains docs/ja/README.md '日本語ドキュメント'
check_contains docs/ja/install.md '60秒で導入'
check_contains docs/ja/install.md '試してから導入'
check_contains docs/ja/install.md './scripts/uninstall.sh'
check_contains docs/ja/quickstart.md '最初のワークフロー'
check_contains docs/ja/faq.md 'ローカルのMac'
check_contains docs/ja/use-cases.md 'OSSメンテナンス'
check_contains docs/ja/share.md 'X投稿例'
check_contains docs/ja/openai-credit-note.md 'OSSクレジット応募'

if [[ "$fail" -eq 0 ]]; then
  echo "Japanese documentation passed"
fi

exit "$fail"
