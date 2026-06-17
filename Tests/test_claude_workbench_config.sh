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

check_not_contains() {
  local file="$1"
  local unexpected="$2"
  if grep -Fq -- "$unexpected" "$file"; then
    echo "unexpected in $file: $unexpected"
    fail=1
  fi
}

private_home='/'"Users"'/admin'

check_contains scripts/launch_claude_tmux.sh 'PANE_COUNT="${CLAUDE_WORKBENCH_PANE_COUNT:-9}"'
check_contains scripts/launch_claude_tmux.sh 'SESSION_NAME="${CLAUDE_WORKBENCH_SESSION:-claude-code-9}"'
check_contains scripts/launch_claude_tmux.sh 'CLAUDE_COMMAND="${CLAUDE_WORKBENCH_COMMAND:-}"'
check_contains scripts/launch_claude_tmux.sh '$HOME/.local/bin/claude'
check_contains scripts/launch_claude_tmux.sh 'IDEA_DIR="${CLAUDE_WORKBENCH_IDEA_DIR:-$BASE_DIR/Idea}"'
check_contains scripts/launch_claude_tmux.sh 'workspace="$IDEA_DIR"'
check_contains scripts/launch_claude_tmux.sh 'CLAUDE_APPEND_SYSTEM_PROMPT="${CLAUDE_WORKBENCH_APPEND_SYSTEM_PROMPT:-'
check_contains scripts/launch_claude_tmux.sh '--append-system-prompt %q'
check_contains scripts/launch_claude_tmux.sh 'AUTO_SUBMIT="${CLAUDE_WORKBENCH_AUTO_SUBMIT:-1}"'
check_contains scripts/launch_claude_tmux.sh 'watch_claude_tmux_autosubmit.sh'
check_contains scripts/watch_claude_tmux_autosubmit.sh 'SESSION_NAME="${CLAUDE_WORKBENCH_SESSION:-claude-code-9}"'
check_contains scripts/watch_claude_tmux_autosubmit.sh 'AUTO_SUBMIT_DELAY="${CLAUDE_WORKBENCH_AUTO_SUBMIT_DELAY:-4}"'
check_contains scripts/build_claude_app.sh 'APP_BUNDLE="${CLAUDE_WORKBENCH_APP_BUNDLE:-$HOME/Applications/Claude Code Workbench.app}"'
check_contains scripts/build_claude_app.sh 'CLAUDE_WORKBENCH_REGENERATE_ICON'
check_contains scripts/build_claude_app.sh 'SCRIPT_PATH="$ROOT_DIR/scripts/launch_claude_tmux.applescript"'
check_contains scripts/build_claude_app.sh 'ICON_NAME="ClaudeCode9Panes"'
check_contains scripts/launch_claude_tmux.applescript 'system attribute "CLAUDE_WORKBENCH_SCRIPT"'
check_contains scripts/launch_claude_tmux.applescript 'Claude Code 9 tmux'
check_contains scripts/send_enter_to_claude_tmux.applescript 'claude-code-9'
check_contains scripts/create_app_icon.py 'ClaudeCode9Panes.iconset'
check_contains scripts/create_app_icon.py 'ClaudeCode9Panes.png'
check_contains scripts/create_app_icon.py '"9"'
check_contains scripts/doctor.sh 'Claude Code Workbench doctor'
check_contains scripts/doctor.sh 'Suggested fixes:'
check_contains scripts/doctor.sh 'brew install tmux'
check_contains scripts/doctor.sh 'CLAUDE_WORKBENCH_COMMAND'
check_contains scripts/install.sh 'Claude Code Workbench installer'
check_contains scripts/install.sh 'CLAUDE_WORKBENCH_INSTALL_DIR'
check_contains Makefile 'test:'
check_contains Makefile './Tests/test_claude_workbench_config.sh'
check_contains Makefile './scripts/audit_public_safety.sh'
check_contains scripts/new_workflow.sh 'issue-triage'
check_contains scripts/new_workflow.sh 'CLAUDE_WORKBENCH_IDEA_DIR'
check_contains scripts/new_workflow.sh 'generate_role_prompts'
check_contains scripts/new_workflow.sh 'prompts_dir / f"pane-{pane_number}.md"'
check_contains scripts/new_workflow.sh 'Paste the pull request link'
check_contains scripts/new_workflow.sh 'Paste the target version'
check_contains scripts/new_workflow.sh 'Paste the user problem'
check_contains Makefile 'for workflow in issue-triage pr-review release-prep feature-discovery'
check_contains .github/workflows/ci.yml 'make test'
check_contains .github/workflows/ci.yml 'make install-smoke'
check_contains scripts/launch_claude_tmux.sh 'CLAUDE_WORKBENCH_USE_ROLE_PROMPTS'
check_contains scripts/launch_claude_tmux.sh 'ROLE_PROMPT_DIR'
check_contains scripts/close_workflow.sh 'Workflow Handoff Summary'
check_contains scripts/close_workflow.sh 'Empty Sections To Fill'
check_contains scripts/close_workflow.sh 'display_workflow_dir'
check_contains scripts/close_workflow.sh '<outside-current-directory>'
check_contains scripts/export_workflow.sh 'Workflow export ready'
check_contains scripts/export_workflow.sh 'Potential private data found'
check_contains scripts/import_workflow.sh 'Workflow import ready'
check_contains scripts/import_workflow.sh 'Unsafe archive path'
check_contains README.md 'docs/oss-maintainer-use-cases.md'
check_contains README.md 'docs/showcase.md'
check_contains README.md 'docs/workflow-templates.md'
check_contains README.md 'docs/workflow-sharing.md'
check_contains README.md 'docs/troubleshooting.md'
check_contains README.md 'docs/openai-codex-for-oss.md'
check_contains README.md 'docs/adoption-plan.md'
check_contains README.md 'docs/assets/workbench-preview.svg'
check_contains README.md './scripts/export_workflow.sh'
check_contains README.md './scripts/import_workflow.sh'
check_contains README.md 'Manual clone instead of the installer'
check_contains README.md 'https://github.com/goonobu-dot/claude-code-workbench.git'
check_not_contains README.md '<your-fork-url>'
check_contains README.md 'examples/issue-triage-demo'
check_contains README.md 'ROADMAP.md'
check_contains CONTRIBUTING.md 'make test'
check_not_contains CONTRIBUTING.md './Tests/test_claude_workbench_config.sh'
check_contains ROADMAP.md 'Generated workflow import/export'
check_not_contains ROADMAP.md 'Optional pane seeding'
check_contains ROADMAP.md 'Near-Term Improvements'
check_contains CHANGELOG.md 'v0.5.0'
check_contains docs/openai-codex-for-oss.md 'Relationship To Codex Work'
check_contains docs/adoption-plan.md 'Do not fake adoption'
check_contains docs/showcase.md 'scripts/export_workflow.sh'
check_contains docs/showcase.md 'docs/workflow-sharing.md'
check_contains docs/workflows.md 'make test'
check_contains docs/workflows.md './scripts/export_workflow.sh'
check_contains docs/workflows.md './scripts/import_workflow.sh'
check_not_contains docs/workflows.md './Tests/test_claude_workbench_config.sh'
check_contains docs/troubleshooting.md 'Run The Doctor'
check_contains docs/troubleshooting.md 'CLAUDE_WORKBENCH_COMMAND'
check_contains docs/troubleshooting.md 'CLAUDE_WORKBENCH_AUTO_SUBMIT=0'
check_contains docs/workflow-sharing.md 'Export A Workflow'
check_contains docs/workflow-sharing.md './scripts/export_workflow.sh'
check_contains docs/workflow-sharing.md './scripts/import_workflow.sh'
check_contains docs/workflow-sharing.md 'Path traversal'
check_contains examples/README.md 'issue-triage-demo'
check_contains examples/README.md 'docs/workflow-sharing.md'
check_contains examples/README.md 'pr-review-demo'
check_contains examples/issue-triage-demo/README.md 'Fictional demo'
check_contains examples/issue-triage-demo/final-triage.md 'Recommended Fix'
check_contains examples/issue-triage-demo/handoff-summary.md 'Workflow Handoff Summary'
check_contains examples/pr-review-demo/README.md 'Fictional demo'
check_contains docs/assets/workbench-preview.svg 'Claude Code Workbench tmux preview'
check_contains docs/assets/workbench-preview.svg 'Claude Code workbench'
check_contains examples/pr-review-demo/final-review.md 'Review Verdict'
check_contains examples/pr-review-demo/handoff-summary.md 'Workflow Handoff Summary'

check_not_contains scripts/launch_claude_tmux.sh "$private_home"
check_not_contains scripts/launch_claude_tmux.applescript "$private_home"
check_not_contains README.md "$private_home"
check_not_contains scripts/launch_claude_tmux.sh 'Idea-$pane_number'
check_not_contains scripts/build_claude_app.sh 'LEGACY_APP_BUNDLE'
check_not_contains scripts/build_claude_app.sh 'launch_12_claude_terminals.applescript'

tmp_home="$(mktemp -d)"
trap 'rm -rf "$tmp_home"' EXIT
workflow_dir="$tmp_home/Idea/test-workflow"
mkdir -p "$workflow_dir"
printf '# Note\n\n## Empty\n' >"$workflow_dir/note.md"
HOME="$tmp_home" ./scripts/close_workflow.sh "$workflow_dir" "$workflow_dir/handoff-summary.md" >/dev/null
check_contains "$workflow_dir/handoff-summary.md" 'Workflow directory: `~/Idea/test-workflow`'
check_not_contains "$workflow_dir/handoff-summary.md" "$tmp_home"

export_dir="$tmp_home/Idea/export-workflow"
mkdir -p "$export_dir/prompts"
printf '# Question\n\nReview this fictional issue.\n' >"$export_dir/question.md"
printf '# Roles\n\nPane 1: Review.\n' >"$export_dir/pane-roles.md"
printf '# Prompt\n' >"$export_dir/prompts/pane-1.md"
export_file="$tmp_home/export-workflow.tar.gz"
./scripts/export_workflow.sh "$export_dir" "$export_file" >/dev/null
test -f "$export_file" || { echo "missing export file: $export_file"; fail=1; }
tar -tzf "$export_file" | grep -Fq 'export-workflow/question.md' || { echo "missing question.md in export"; fail=1; }
import_dir="$tmp_home/imported"
./scripts/import_workflow.sh "$export_file" "$import_dir" >/dev/null
test -f "$import_dir/export-workflow/question.md" || { echo "missing imported question.md"; fail=1; }
private_export_path='/'"Users"'/admin/private'
printf '# Leak\n\n%s\n' "$private_export_path" >"$export_dir/leak.md"
if ./scripts/export_workflow.sh "$export_dir" "$tmp_home/leak.tar.gz" >/dev/null 2>&1; then
  echo "export should fail when markdown contains a local absolute path"
  fail=1
fi

malicious_archive="$tmp_home/malicious.tar.gz"
python3 - "$malicious_archive" <<'PY'
import io
import tarfile
import sys

with tarfile.open(sys.argv[1], "w:gz") as archive:
    data = b"# Bad\n"
    info = tarfile.TarInfo("../evil.md")
    info.size = len(data)
    archive.addfile(info, io.BytesIO(data))
PY
if ./scripts/import_workflow.sh "$malicious_archive" "$tmp_home/malicious-out" >/dev/null 2>&1; then
  echo "import should fail when archive contains unsafe paths"
  fail=1
fi

exit "$fail"
