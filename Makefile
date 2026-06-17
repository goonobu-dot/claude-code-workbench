.PHONY: help doctor doctor-report first-run demo demo-transcript recommend test syntax safety smoke install-smoke release-check

help:
	@printf '%s\n' \
		'Targets:' \
		'  make doctor        Check local setup without launching panes' \
		'  make doctor-report Write doctor-report.md for bug reports' \
		'  make first-run     Run doctor, demo, and workflow discovery' \
		'  make demo          Generate, validate, and close a temporary demo workflow' \
		'  make demo-transcript Write docs/demo-transcript.md for GitHub readers' \
		'  make recommend     Recommend a workflow for TASK=issue|pr|release|feature|security|docs|dependency' \
		'  make test          Run config, syntax, safety, and workflow smoke tests' \
		'  make syntax        Check shell script syntax' \
		'  make safety        Run public safety audit' \
		'  make smoke         Generate and close every workflow template' \
		'  make install-smoke Exercise the installer against this checkout' \
		'  make release-check Run pre-release validation'

doctor:
	./scripts/doctor.sh

doctor-report:
	-./scripts/doctor.sh --report doctor-report.md
	@printf 'Doctor report ready: doctor-report.md\n'

first-run:
	-./scripts/doctor.sh
	$(MAKE) demo
	./scripts/new_workflow.sh --list --verbose
	@printf 'First-run check complete\n'

demo:
	@set -e; \
	tmpdir="$$(mktemp -d)"; \
	./scripts/create_workflow_from_url.sh https://github.com/owner/repo/issues/123 "$$tmpdir" >/dev/null; \
	./scripts/validate_workflow.sh "$$tmpdir" >/dev/null; \
	./scripts/close_workflow.sh "$$tmpdir" >/dev/null; \
	printf 'Demo workflow ready: %s\n' "$$tmpdir"

demo-transcript:
	./scripts/write_demo_transcript.sh docs/demo-transcript.md

recommend:
	./scripts/recommend_workflow.sh "$${TASK:-issue}"

test: syntax
	./Tests/test_claude_workbench_config.sh
	./scripts/check_docs_links.sh
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

release-check:
	make test
	make install-smoke
