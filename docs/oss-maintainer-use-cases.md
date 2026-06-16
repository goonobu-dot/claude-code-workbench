# OSS Maintainer Use Cases

Claude Code Workbench is useful when a maintainer wants several independent Claude Code sessions working against the same local context.

## 1. Issue Triage

Open four panes and assign a different job to each:

- reproduce the issue from the report
- inspect related code paths
- draft a minimal fix plan
- identify missing tests and regression risk

Expected output:

```text
Idea/
  issue-summary.md
  reproduction-notes.md
  fix-plan.md
  test-plan.md
```

## 2. Pull Request Review

Use panes for independent review angles:

- behavior changes
- security/privacy risk
- test coverage
- documentation impact

This helps avoid over-trusting one agent's first answer.

## 3. Release Preparation

Use six panes:

- changelog draft
- breaking-change review
- README check
- release notes
- smoke-test checklist
- follow-up issues

## 4. Competing Fix Strategies

When a bug has several plausible causes, assign each pane a different hypothesis.

The useful pattern is not "nine agents agree." It is "several agents disagree clearly enough that the maintainer can make a better decision."

## 5. Documentation Refresh

Use panes to compare the repository from different reader perspectives:

- first-time user
- contributor
- maintainer
- security reviewer
- release manager

Ask each pane to write concrete diffs or issue suggestions instead of broad feedback.
