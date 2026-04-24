---
name: renku-audit-conditions
description: Audit and design condition-heavy Renku blueprint graphs. Use when a blueprint has optional branches, workflow routing, sparse fan-in, reference-vs-plain asset paths, StartEnd/image anchor logic, model-specific branches, or when Codex must prevent producers from running without available inputs or running in branches where their outputs are unused.
---

# Renku Audit Conditions

Audit conditional blueprint routing so scheduled jobs match available artifacts and useful downstream consumers.

## Audit Workflow

1. List every named and inline condition used by connections.
2. For each conditional producer output, list every downstream consumer.
3. Verify consumer conditions imply the source producer condition.
4. Verify each producer that can run has at least one output consumed in that same branch, unless the output is intentionally published.
5. Check sparse fan-in branches and root outputs separately.
6. Run static validation and full dry-run through `renku-validate-run`.
7. Inspect produced condition paths to confirm dry-run cases covered the condition fields being used.

## High-Risk Patterns

- Start/end video clips whose start or end frame comes from optional image producers.
- Reference workflow branches that should use a reference-specific prompt producer, not a generic prompt producer.
- A single prompt producer feeding Text, StartEnd, MultiShot, and Reference branches with different conditions.
- Condition paths using fixed indexes such as `[0]` and `[1]` beside schema-derived paths using `[image]`.
- Stage-by-stage execution with `--up` or `--up-to-layer`; do not fail because a later layer is intentionally not scheduled yet.

## Required Fix Pattern

When conditions differ, prefer separate producer imports over broad shared producers.

Example: use separate prompt producers for Text, StartEnd-with-plain-anchors, MultiShot, and Reference if those branches have different activation rules.

## References

- Read `references/condition-audit-reference.md` when auditing actual conditional graph wiring.
- Read `references/condition-routing-gotchas.md` for concrete bad/good branch examples.
- Read `references/dry-run-condition-coverage.md` for what dry-run evidence should prove.
- Read `references/stage-by-stage-execution.md` before changing runtime plan safety or `--up` behavior.
