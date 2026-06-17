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
check_contains scripts/doctor.sh 'python3'
check_contains scripts/doctor.sh 'git'
check_contains scripts/doctor.sh 'CLAUDE_WORKBENCH_COMMAND'
check_contains scripts/doctor.sh '--report'
check_contains scripts/doctor.sh 'Doctor report written to:'
check_contains scripts/check_docs_links.sh 'Documentation links passed'
check_contains scripts/check_docs_links.sh 'Broken documentation links'
check_contains scripts/install.sh 'Claude Code Workbench installer'
check_contains scripts/install.sh 'CLAUDE_WORKBENCH_INSTALL_DIR'
check_contains scripts/install.sh 'make demo'
check_contains scripts/install.sh 'make doctor-report'
check_contains scripts/install.sh './scripts/new_workflow.sh --list'
check_contains Makefile 'test:'
check_contains Makefile 'demo:'
check_contains Makefile 'Demo workflow ready'
check_contains Makefile 'doctor-report:'
check_contains Makefile 'doctor-report.md'
check_contains Makefile 'release-check:'
check_contains Makefile 'make test'
check_contains Makefile 'make install-smoke'
check_contains Makefile './Tests/test_claude_workbench_config.sh'
check_contains Makefile './scripts/audit_public_safety.sh'
check_contains Makefile './scripts/check_docs_links.sh'
check_contains scripts/new_workflow.sh 'issue-triage'
check_contains scripts/new_workflow.sh '--list'
check_contains scripts/new_workflow.sh 'list_workflows'
check_contains scripts/new_workflow.sh 'CLAUDE_WORKBENCH_IDEA_DIR'
check_contains scripts/new_workflow.sh 'generate_role_prompts'
check_contains scripts/new_workflow.sh 'prompts_dir / f"pane-{pane_number}.md"'
check_contains scripts/new_workflow.sh 'Paste the pull request link'
check_contains scripts/new_workflow.sh 'Paste the target version'
check_contains scripts/new_workflow.sh 'Paste the user problem'
check_contains scripts/create_workflow_from_url.sh 'Workflow from URL ready'
check_contains scripts/create_workflow_from_url.sh 'github.com'
check_contains scripts/create_workflow_from_url.sh 'issue-triage'
check_contains scripts/create_workflow_from_url.sh 'pr-review'
check_contains Makefile 'for workflow in issue-triage pr-review release-prep feature-discovery'
check_contains .github/workflows/ci.yml 'make test'
check_contains .github/workflows/ci.yml 'make install-smoke'
check_contains .github/ISSUE_TEMPLATE/usage_report.yml 'Usage report'
check_contains .github/ISSUE_TEMPLATE/usage_report.yml 'Which workflow did you run?'
check_contains .github/ISSUE_TEMPLATE/usage_report.yml 'What did the workbench help you decide or produce?'
check_contains .github/ISSUE_TEMPLATE/bug_report.yml './scripts/doctor.sh --report doctor-report.md'
check_contains .github/ISSUE_TEMPLATE/bug_report.yml 'Doctor report'
check_contains scripts/launch_claude_tmux.sh 'CLAUDE_WORKBENCH_USE_ROLE_PROMPTS'
check_contains scripts/launch_claude_tmux.sh 'ROLE_PROMPT_DIR'
check_contains scripts/close_workflow.sh 'Workflow Handoff Summary'
check_contains scripts/close_workflow.sh 'Empty Sections To Fill'
check_contains scripts/close_workflow.sh 'display_workflow_dir'
check_contains scripts/close_workflow.sh '<outside-current-directory>'
check_contains scripts/export_workflow.sh 'Workflow export ready'
check_contains scripts/export_workflow.sh 'workflow-manifest.json'
check_contains scripts/export_workflow.sh 'Potential private data found'
check_contains scripts/validate_workflow.sh 'Workflow validation passed'
check_contains scripts/validate_workflow.sh 'Missing required workflow file'
check_contains scripts/validate_workflow.sh 'Potential private data found'
check_contains scripts/import_workflow.sh 'Workflow import ready'
check_contains scripts/import_workflow.sh 'workflow-manifest.json'
check_contains scripts/import_workflow.sh 'Unsafe archive path'
check_contains README.md 'docs/oss-maintainer-use-cases.md'
check_contains README.md 'docs/showcase.md'
check_contains README.md 'docs/why.md'
check_contains README.md 'docs/one-minute-demo.md'
check_contains README.md 'docs/commands.md'
check_contains README.md 'docs/architecture.md'
check_contains README.md 'docs/workflow-templates.md'
check_contains README.md 'docs/workflow-sharing.md'
check_contains README.md 'docs/troubleshooting.md'
check_contains README.md 'docs/faq.md'
check_contains README.md 'docs/publication-checklist.md'
check_contains README.md 'docs/openai-codex-for-oss.md'
check_contains README.md 'docs/adoption-plan.md'
check_contains README.md 'docs/assets/workbench-preview.svg'
check_contains README.md './scripts/export_workflow.sh'
check_contains README.md './scripts/import_workflow.sh'
check_contains README.md './scripts/create_workflow_from_url.sh'
check_contains README.md 'make demo'
check_contains README.md 'https://github.com/owner/repo/issues/123'
check_contains README.md 'https://github.com/owner/repo/pull/123'
check_contains README.md 'Manual clone instead of the installer'
check_contains README.md 'https://github.com/goonobu-dot/claude-code-workbench.git'
check_not_contains README.md '<your-fork-url>'
check_contains README.md 'examples/issue-triage-demo'
check_contains README.md 'examples/release-prep-demo'
check_contains README.md 'examples/feature-discovery-demo'
check_contains README.md '.github/ISSUE_TEMPLATE/usage_report.yml'
check_contains README.md 'ROADMAP.md'
check_contains SECURITY.md 'Security Policy'
check_contains SECURITY.md 'Do not include secrets'
check_contains SECURITY.md './scripts/audit_public_safety.sh'
check_contains CONTRIBUTING.md 'make test'
check_contains CONTRIBUTING.md 'make release-check'
check_contains CONTRIBUTING.md 'make doctor-report'
check_contains CONTRIBUTING.md 'scripts/validate_workflow.sh'
check_not_contains CONTRIBUTING.md './Tests/test_claude_workbench_config.sh'
check_contains ROADMAP.md 'Generated workflow import/export'
check_not_contains ROADMAP.md 'Optional pane seeding'
check_contains ROADMAP.md 'Near-Term Improvements'
check_contains CHANGELOG.md 'v0.5.0'
check_contains docs/openai-codex-for-oss.md 'Relationship To Codex Work'
check_contains docs/adoption-plan.md 'Do not fake adoption'
check_contains docs/showcase.md 'scripts/export_workflow.sh'
check_contains docs/showcase.md 'docs/workflow-sharing.md'
check_contains docs/showcase.md 'scripts/create_workflow_from_url.sh'
check_contains docs/why.md 'Why This Exists'
check_contains docs/why.md 'single chat thread'
check_contains docs/why.md 'parallel maintainer thinking'
check_contains docs/showcase.md 'GitHub issue or pull request URL'
check_contains docs/one-minute-demo.md 'One-Minute Demo'
check_contains docs/one-minute-demo.md './scripts/create_workflow_from_url.sh https://github.com/owner/repo/issues/123'
check_contains docs/one-minute-demo.md 'make demo'
check_contains docs/one-minute-demo.md './scripts/close_workflow.sh'
check_contains docs/one-minute-demo.md 'usage report issue template'
check_contains docs/workflows.md 'make test'
check_contains docs/workflows.md './scripts/export_workflow.sh'
check_contains docs/workflows.md './scripts/import_workflow.sh'
check_not_contains docs/workflows.md './Tests/test_claude_workbench_config.sh'
check_contains docs/troubleshooting.md 'Run The Doctor'
check_contains docs/faq.md 'Does This Expose My Local Mac?'
check_contains docs/publication-checklist.md 'Publication Checklist'
check_contains docs/publication-checklist.md 'make release-check'
check_contains docs/publication-checklist.md 'OpenAI credit'
check_contains docs/commands.md 'Command Reference'
check_contains docs/architecture.md 'Architecture'
check_contains docs/architecture.md 'Shared workflow folder'
check_contains docs/architecture.md 'Local boundary'
check_contains docs/commands.md './scripts/new_workflow.sh --list'
check_contains docs/commands.md 'make doctor-report'
check_contains docs/commands.md './scripts/validate_workflow.sh'
check_contains docs/faq.md 'Do I Need API Keys?'
check_contains docs/faq.md 'What Does GitHub Make Public?'
check_contains docs/troubleshooting.md 'CLAUDE_WORKBENCH_COMMAND'
check_contains docs/troubleshooting.md 'CLAUDE_WORKBENCH_AUTO_SUBMIT=0'
check_contains docs/troubleshooting.md './scripts/doctor.sh --report doctor-report.md'
check_contains docs/troubleshooting.md 'make doctor-report'
check_contains docs/workflow-sharing.md 'Export A Workflow'
check_contains docs/workflow-sharing.md './scripts/validate_workflow.sh'
check_contains docs/workflow-sharing.md './scripts/export_workflow.sh'
check_contains docs/workflow-sharing.md './scripts/import_workflow.sh'
check_contains docs/workflow-sharing.md 'Path traversal'
check_contains docs/workflow-templates.md './scripts/create_workflow_from_url.sh'
check_contains docs/workflow-templates.md './scripts/new_workflow.sh --list'
check_contains examples/README.md 'issue-triage-demo'
check_contains examples/README.md 'docs/workflow-sharing.md'
check_contains examples/README.md 'pr-review-demo'
check_contains examples/README.md 'release-prep-demo'
check_contains examples/README.md 'feature-discovery-demo'
check_contains examples/issue-triage-demo/README.md 'Fictional demo'
check_contains examples/issue-triage-demo/final-triage.md 'Recommended Fix'
check_contains examples/issue-triage-demo/handoff-summary.md 'Workflow Handoff Summary'
check_contains examples/pr-review-demo/README.md 'Fictional demo'
check_contains docs/assets/workbench-preview.svg 'Claude Code Workbench tmux preview'
check_contains docs/assets/workbench-preview.svg 'Claude Code workbench'
check_contains examples/pr-review-demo/final-review.md 'Review Verdict'
check_contains examples/pr-review-demo/handoff-summary.md 'Workflow Handoff Summary'
check_contains examples/release-prep-demo/README.md 'Fictional demo'
check_contains examples/release-prep-demo/release-checklist.md 'Release Readiness'
check_contains examples/release-prep-demo/handoff-summary.md 'Workflow Handoff Summary'
check_contains examples/feature-discovery-demo/README.md 'Fictional demo'
check_contains examples/feature-discovery-demo/decision-memo.md 'Recommended Scope'
check_contains examples/feature-discovery-demo/handoff-summary.md 'Workflow Handoff Summary'

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

doctor_report="$tmp_home/doctor-report.md"
./scripts/doctor.sh --report "$doctor_report" >/dev/null || true
test -f "$doctor_report" || { echo "missing doctor report"; fail=1; }
check_contains "$doctor_report" '# Claude Code Workbench Doctor Report'
check_contains "$doctor_report" '## Raw Output'
check_contains "$doctor_report" '```text'

./scripts/new_workflow.sh --list | grep -Fq 'issue-triage' || { echo "workflow list missing issue-triage"; fail=1; }
./scripts/new_workflow.sh --list | grep -Fq 'feature-discovery' || { echo "workflow list missing feature-discovery"; fail=1; }
make demo >/dev/null
make doctor-report >/dev/null || true
test -f doctor-report.md || { echo "missing doctor-report.md"; fail=1; }
rm -f doctor-report.md
./scripts/check_docs_links.sh >/dev/null
make -n release-check >/dev/null

export_dir="$tmp_home/Idea/export-workflow"
mkdir -p "$export_dir/prompts"
printf '# Question\n\nReview this fictional issue.\n' >"$export_dir/question.md"
printf '# Roles\n\nPane 1: Review.\n' >"$export_dir/pane-roles.md"
printf '# Prompt\n' >"$export_dir/prompts/pane-1.md"
./scripts/validate_workflow.sh "$export_dir" >/dev/null
export_file="$tmp_home/export-workflow.tar.gz"
./scripts/export_workflow.sh "$export_dir" "$export_file" >/dev/null
test -f "$export_file" || { echo "missing export file: $export_file"; fail=1; }
tar -tzf "$export_file" | grep -Fq 'export-workflow/question.md' || { echo "missing question.md in export"; fail=1; }
tar -tzf "$export_file" | grep -Fq 'export-workflow/workflow-manifest.json' || { echo "missing workflow manifest in export"; fail=1; }
import_dir="$tmp_home/imported"
./scripts/import_workflow.sh "$export_file" "$import_dir" >/dev/null
test -f "$import_dir/export-workflow/question.md" || { echo "missing imported question.md"; fail=1; }
test -f "$import_dir/export-workflow/workflow-manifest.json" || { echo "missing imported workflow manifest"; fail=1; }
private_export_path='/'"Users"'/admin/private'
printf '# Leak\n\n%s\n' "$private_export_path" >"$export_dir/leak.md"
if ./scripts/validate_workflow.sh "$export_dir" >/dev/null 2>&1; then
  echo "workflow validation should fail when markdown contains a local absolute path"
  fail=1
fi
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

url_workflow_dir="$tmp_home/from-url"
./scripts/create_workflow_from_url.sh "https://github.com/example/project/issues/42" "$url_workflow_dir" >/dev/null
test -f "$url_workflow_dir/final-triage.md" || { echo "missing issue triage output from URL workflow"; fail=1; }
check_contains "$url_workflow_dir/question.md" 'https://github.com/example/project/issues/42'
check_contains "$url_workflow_dir/question.md" 'Source URL'
pr_workflow_dir="$tmp_home/from-pr-url"
./scripts/create_workflow_from_url.sh "https://github.com/example/project/pull/7" "$pr_workflow_dir" >/dev/null
test -f "$pr_workflow_dir/final-review.md" || { echo "missing PR review output from URL workflow"; fail=1; }
check_contains "$pr_workflow_dir/question.md" 'https://github.com/example/project/pull/7'

exit "$fail"
