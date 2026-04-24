---
name: renku-validate-run
description: Validate Renku blueprints and builds before calling work complete. Use when Codex needs to run blueprint validation, dry-run simulation, produced condition path inspection, costs-only checks, stage-by-stage --up or --up-to-layer validation, root build/test verification, or diagnose validation/runtime errors without invoking paid generation.
---

# Renku Validate Run

Validate before claiming a blueprint or build is ready. Dry-run evidence is part of the deliverable.

## Required Gates

For blueprint changes:

1. Run blueprint validation through the same surface the user will use.
2. Run a dry-run with realistic inputs.
3. Inspect dry-run validation coverage and produced condition paths when conditions are involved.
4. Run stage-by-stage checks when the user will use `--up` or `--up-to-layer`.
5. If source code changed, run the repository-required build and tests.

For one-time video inputs:

1. Validate the blueprint if it changed or if conditions/model configs changed.
2. Run dry-run with the edited inputs.
3. Run costs-only when the user is close to paid generation.
4. Do not run paid generation without explicit approval.

## Evidence To Report

- Exact command names, not vague statements.
- Whether validation had warnings.
- Dry-run job/layer summary.
- Condition coverage summary for branch-heavy graphs.
- Any residual risks or warnings.

## References

- Read `references/validation-runbook.md` before deciding a blueprint/build/source change is complete.
- Read `references/blueprint-warning-and-error-gotchas.md` when validation reports warnings or graph/runtime errors.
- Read `references/validation-checklist.md` for command sequence.
- Read `references/dry-run-feedback.md` for interpreting produced condition paths.
- Read `references/error-codes.md` for Renku error-code handling expectations.
