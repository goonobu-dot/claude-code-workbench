# Workflow Sharing

Use this guide when you want to share a generated workflow folder with another maintainer, archive a review, or attach a fictional demo to a pull request.

## Export A Workflow

Create a workflow folder:

```bash
./scripts/new_workflow.sh pr-review "$HOME/ClaudeCodeWorkbench/Idea/pr-review-demo"
```

After panes write their markdown notes, generate the handoff:

```bash
./scripts/close_workflow.sh "$HOME/ClaudeCodeWorkbench/Idea/pr-review-demo"
```

Validate the workflow before sharing it:

```bash
./scripts/validate_workflow.sh "$HOME/ClaudeCodeWorkbench/Idea/pr-review-demo"
```

Then export only markdown files:

```bash
./scripts/export_workflow.sh "$HOME/ClaudeCodeWorkbench/Idea/pr-review-demo" ./pr-review-demo.tar.gz
```

The exporter refuses obvious private data, including local absolute paths, API keys, access tokens, private keys, and local-only data references.

## Import A Shared Workflow

Import a shared archive into the default imported-workflow area:

```bash
./scripts/import_workflow.sh ./pr-review-demo.tar.gz
```

Or choose a destination:

```bash
./scripts/import_workflow.sh ./pr-review-demo.tar.gz "$HOME/ClaudeCodeWorkbench/Imported"
```

## Safety Boundaries

The importer refuses:

- Absolute paths
- Path traversal such as `../notes.md`
- Non-markdown files
- Symlinks and hard links
- Special files

Still review imported markdown before using it as source material. These scripts reduce common mistakes; they do not prove that a workflow is factually correct or publication-ready.
