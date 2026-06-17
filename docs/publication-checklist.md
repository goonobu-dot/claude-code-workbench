# Publication Checklist

Use this checklist before publishing examples, announcing a release, or referencing the project in an OpenAI credit application.

## Repository Checks

- [ ] Run `make release-check`.
- [ ] Confirm GitHub Actions is green on `main`.
- [ ] Confirm the latest GitHub Release points at the intended commit.
- [ ] Review `README.md`, `docs/commands.md`, and `docs/one-minute-demo.md`.
- [ ] Confirm `SECURITY.md` and `docs/faq.md` still match the current behavior.

## Safety Checks

- [ ] Run `./scripts/audit_public_safety.sh`.
- [ ] Run `./scripts/validate_workflow.sh <workflow-dir>` before sharing generated workflow output.
- [ ] Do not publish local logs, `.env` files, shell history, private prompt histories, or app bundles.
- [ ] Keep demos fictional unless the source project is explicitly public and safe to cite.

## Utility Checks

- [ ] `make demo` creates a temporary workflow and handoff summary.
- [ ] `./scripts/new_workflow.sh --list` shows the available templates.
- [ ] At least one example demonstrates the workflow type being discussed.
- [ ] The command reference includes the shortest path for a new user.

## OpenAI Credit Application Notes

For an OpenAI credit application, do not claim adoption that has not happened. Instead, point to concrete public proof:

- tested local CLI workflows
- CI history
- releases
- safety audit
- fictional examples
- docs explaining how API credits would help future OSS maintenance experiments
