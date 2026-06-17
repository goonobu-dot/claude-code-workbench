# Adoption Scorecard

This scorecard records 50 small improvement/test loops focused on helping a
GitHub visitor understand, install, evaluate, troubleshoot, and safely share
Claude Code Workbench.

| Loop | Friction Found | Improvement Or Check | Verification |
| --- | --- | --- | --- |
| Loop 01 | Reader needs a fast install path. | README has `Install In 60 Seconds`. | Config test checks README. |
| Loop 02 | Cautious reader wants to inspect before install. | README has `Try Without Installing`. | Config test checks README. |
| Loop 03 | Reader wants to see output before running commands. | `docs/demo-transcript.md` exists. | `make demo-transcript`. |
| Loop 04 | First command should summarize setup health. | `make first-run` runs doctor. | Config test runs `make first-run`. |
| Loop 05 | Missing CLI should not block a demo preview. | `first-run` continues after doctor failure. | CI runs `make test`. |
| Loop 06 | User needs a safe removal path. | `scripts/uninstall.sh` dry-runs by default. | Config test checks no removal without confirmation. |
| Loop 07 | User may want app removal too. | `CLAUDE_WORKBENCH_REMOVE_APP=1`. | Config test removes fixture app. |
| Loop 08 | User may want idea folder removal too. | `CLAUDE_WORKBENCH_REMOVE_IDEA=1`. | Config test removes fixture idea folder. |
| Loop 09 | User needs command discovery. | `make help` lists primary targets. | Makefile target list is tested. |
| Loop 10 | User may not know which workflow to use. | `scripts/recommend_workflow.sh`. | Config test checks issue/security recommendations. |
| Loop 11 | Issue triage needs direct command guidance. | Recommender points to `issue-triage`. | Config test greps output. |
| Loop 12 | PR review needs direct command guidance. | Recommender points to `pr-review`. | Script case branch covered by syntax/test. |
| Loop 13 | Release prep needs direct command guidance. | Recommender points to `release-prep`. | Script case branch covered by syntax/test. |
| Loop 14 | Feature discovery needs direct command guidance. | Recommender points to `feature-discovery`. | Script case branch covered by syntax/test. |
| Loop 15 | Security triage has no first-class template. | Recommender links `examples/security-triage-demo`. | Config test checks security recommendation. |
| Loop 16 | Docs improvement has no first-class template. | Recommender links `examples/docs-improvement-demo`. | Script syntax and README link checks. |
| Loop 17 | Dependency update has no first-class template. | Recommender links `examples/dependency-update-demo`. | Script syntax and README link checks. |
| Loop 18 | User needs public issue/PR context. | URL helper records canonical GitHub URL. | Config test checks question.md. |
| Loop 19 | User benefits from GitHub title/state/author. | URL helper can add metadata via `gh`. | Fixture test checks metadata. |
| Loop 20 | Offline tests should not need network. | Metadata fixture env var exists. | Config test uses local JSON. |
| Loop 21 | Workflow export must avoid private paths. | `validate_workflow.sh` rejects local path leak. | Config test injects leak. |
| Loop 22 | Workflow archive import must avoid traversal. | `import_workflow.sh` rejects unsafe paths. | Config test builds malicious archive. |
| Loop 23 | Shared workflows need manifest context. | Export includes `workflow-manifest.json`. | Config test checks archive. |
| Loop 24 | User needs support path. | `SUPPORT.md` exists. | Config test checks support doc. |
| Loop 25 | Bug reports need diagnostics. | `make doctor-report`. | Config test checks generated report. |
| Loop 26 | Doctor output should be actionable. | Doctor report has `Suggested Fixes`. | Config test checks report. |
| Loop 27 | Documentation links should not rot. | `check_docs_links.sh`. | `make test` runs link checker. |
| Loop 28 | Public release should avoid secrets. | `audit_public_safety.sh`. | `make test` runs safety audit. |
| Loop 29 | Contributor needs one validation command. | `make release-check`. | CI and local release check. |
| Loop 30 | User needs architecture boundary. | `docs/architecture.md`. | Config test checks document. |
| Loop 31 | User needs local security boundary. | `docs/faq.md`. | Config test checks FAQ. |
| Loop 32 | User needs adoption honesty. | `docs/adoption-plan.md`. | Config test checks adoption doc. |
| Loop 33 | User needs OpenAI OSS context. | `docs/openai-codex-for-oss.md`. | Config test checks document. |
| Loop 34 | User needs practical use cases. | `docs/oss-maintainer-use-cases.md`. | README link checked. |
| Loop 35 | User needs a showcase summary. | `docs/showcase.md`. | Config test checks showcase. |
| Loop 36 | User needs one-minute path. | `docs/one-minute-demo.md`. | Config test checks commands. |
| Loop 37 | User needs five-minute evaluation. | `docs/evaluation-guide.md`. | Config test checks guide. |
| Loop 38 | User needs install details. | `docs/install.md`. | Config test checks install guide. |
| Loop 39 | User needs command reference. | `docs/commands.md`. | Config test checks commands. |
| Loop 40 | User needs workflow sharing safety. | `docs/workflow-sharing.md`. | Config test checks safety notes. |
| Loop 41 | User needs template overview. | `docs/workflow-templates.md`. | Config test checks template docs. |
| Loop 42 | User needs troubleshooting. | `docs/troubleshooting.md`. | Config test checks troubleshooting. |
| Loop 43 | User needs examples index. | `examples/README.md`. | Config test checks all examples. |
| Loop 44 | Issue example should show final output. | `examples/issue-triage-demo/final-triage.md`. | Config test checks final triage. |
| Loop 45 | PR example should show final verdict. | `examples/pr-review-demo/final-review.md`. | Config test checks final review. |
| Loop 46 | Release example should show readiness. | `examples/release-prep-demo/release-checklist.md`. | Config test checks release checklist. |
| Loop 47 | Feature example should show scope decision. | `examples/feature-discovery-demo/decision-memo.md`. | Config test checks decision memo. |
| Loop 48 | Security example should show impact reasoning. | `examples/security-triage-demo/security-triage.md`. | Config test checks security triage. |
| Loop 49 | Docs example should show edit plan. | `examples/docs-improvement-demo/docs-plan.md`. | Config test checks docs plan. |
| Loop 50 | Dependency example should show merge risk. | `examples/dependency-update-demo/update-review.md`. | Config test checks update review. |

Run:

```bash
./scripts/check_adoption_scorecard.sh
```
