#!/usr/bin/env bash
set -euo pipefail

TASK="${1:-issue}"

print_issue() {
  cat <<'EOF'
# Recommended Workflow

Task: issue
Workflow: issue-triage

Create the workflow:

```bash
./scripts/new_workflow.sh issue-triage
CLAUDE_WORKBENCH_IDEA_DIR="$HOME/ClaudeCodeWorkbench/Idea" CLAUDE_WORKBENCH_USE_ROLE_PROMPTS=1 ./scripts/launch_claude_tmux.sh
```

Example output: examples/issue-triage-demo
EOF
}

print_pr() {
  cat <<'EOF'
# Recommended Workflow

Task: pr
Workflow: pr-review

Create the workflow:

```bash
./scripts/new_workflow.sh pr-review
CLAUDE_WORKBENCH_IDEA_DIR="$HOME/ClaudeCodeWorkbench/Idea" CLAUDE_WORKBENCH_USE_ROLE_PROMPTS=1 ./scripts/launch_claude_tmux.sh
```

Example output: examples/pr-review-demo
EOF
}

print_release() {
  cat <<'EOF'
# Recommended Workflow

Task: release
Workflow: release-prep

Create the workflow:

```bash
./scripts/new_workflow.sh release-prep
CLAUDE_WORKBENCH_IDEA_DIR="$HOME/ClaudeCodeWorkbench/Idea" CLAUDE_WORKBENCH_USE_ROLE_PROMPTS=1 ./scripts/launch_claude_tmux.sh
```

Example output: examples/release-prep-demo
EOF
}

print_feature() {
  cat <<'EOF'
# Recommended Workflow

Task: feature
Workflow: feature-discovery

Create the workflow:

```bash
./scripts/new_workflow.sh feature-discovery
CLAUDE_WORKBENCH_IDEA_DIR="$HOME/ClaudeCodeWorkbench/Idea" CLAUDE_WORKBENCH_USE_ROLE_PROMPTS=1 ./scripts/launch_claude_tmux.sh
```

Example output: examples/feature-discovery-demo
EOF
}

print_example_only() {
  local task="$1"
  local example="$2"
  cat <<EOF
# Recommended Workflow

Task: $task
Workflow: start from the closest built-in workflow, then compare with $example.

Start with:

\`\`\`bash
./scripts/new_workflow.sh issue-triage
CLAUDE_WORKBENCH_IDEA_DIR="\$HOME/ClaudeCodeWorkbench/Idea" CLAUDE_WORKBENCH_USE_ROLE_PROMPTS=1 ./scripts/launch_claude_tmux.sh
\`\`\`

Example output: $example
EOF
}

case "$TASK" in
  issue|bug|triage) print_issue ;;
  pr|pull|pull-request|review) print_pr ;;
  release|ship) print_release ;;
  feature|idea|discovery) print_feature ;;
  security|sec) print_example_only "security" "examples/security-triage-demo" ;;
  docs|documentation) print_example_only "docs" "examples/docs-improvement-demo" ;;
  dependency|deps|update) print_example_only "dependency" "examples/dependency-update-demo" ;;
  *)
    echo "Unknown task: $TASK" >&2
    echo "Use one of: issue, pr, release, feature, security, docs, dependency" >&2
    exit 1
    ;;
esac
