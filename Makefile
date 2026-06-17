.PHONY: help doctor test syntax safety smoke install-smoke

help:
	@printf '%s\n' \
		'Targets:' \
		'  make doctor        Check local setup without launching panes' \
		'  make test          Run config, syntax, safety, and workflow smoke tests' \
		'  make syntax        Check shell script syntax' \
		'  make safety        Run public safety audit' \
		'  make smoke         Generate and close every workflow template' \
		'  make install-smoke Exercise the installer against this checkout'

doctor:
	./scripts/doctor.sh

test: syntax
	./Tests/test_claude_workbench_config.sh
	./scripts/audit_public_safety.sh
	$(MAKE) smoke

syntax:
	bash -n scripts/*.sh Tests/*.sh

safety:
	./scripts/audit_public_safety.sh

smoke:
	@set -e; \
	for workflow in issue-triage pr-review release-prep feature-discovery; do \
		tmpdir="$$(mktemp -d)"; \
		./scripts/new_workflow.sh "$$workflow" "$$tmpdir" >/dev/null; \
		test -f "$$tmpdir/question.md"; \
		test -f "$$tmpdir/pane-roles.md"; \
		test -f "$$tmpdir/prompts/pane-1.md"; \
		./scripts/close_workflow.sh "$$tmpdir" >/dev/null; \
		test -f "$$tmpdir/handoff-summary.md"; \
	done

install-smoke:
	@set -e; \
	tmpdir="$$(mktemp -d)"; \
	CLAUDE_WORKBENCH_REPO_URL="$(CURDIR)" \
	CLAUDE_WORKBENCH_INSTALL_DIR="$$tmpdir/claude-code-workbench" \
	CLAUDE_WORKBENCH_SKIP_APP=1 \
	./scripts/install.sh >/dev/null; \
	test -f "$$tmpdir/claude-code-workbench/scripts/launch_claude_tmux.sh"
