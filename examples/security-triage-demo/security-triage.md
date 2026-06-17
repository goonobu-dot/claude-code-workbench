# Security Triage

## Report

A user reports that exported workflow archives may include local notes that were
not intended for publication.

## Impact

Potential exposure is limited to markdown files deliberately placed inside the
workflow folder before export. The tool does not read unrelated directories.

## Reproduction Status

Reproduced with a fictional workflow folder containing a local absolute path in
`notes.md`. The safety audit rejects the export before creating an archive.

## Recommended Maintainer Action

1. Keep the export failure behavior.
2. Add a documentation note explaining that generated archives should be
   inspected before publishing.
3. Ask the reporter whether any additional private-data pattern was missed.

## Disclosure Note

Treat this as a hardening issue unless the reporter provides evidence that files
outside the selected workflow folder can be included.
