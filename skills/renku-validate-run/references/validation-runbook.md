# Validation Runbook

Use this before telling the user a blueprint, build input file, or workflow change is done.

## Validation Surfaces

Renku has multiple surfaces that can catch different failures:

- static blueprint validation,
- prepared/viewer-style blueprint validation,
- dry-run planning and simulation,
- stage-limited dry-run or generation planning,
- source build/tests when core/CLI/viewer/provider code changed.

Do not rely on only one surface when the change affects conditions, loops, producer inputs, or model configs.

## Blueprint-Only Change

Run:

```bash
pnpm --filter @gorenku/cli exec tsx src/cli.tsx blueprints:validate <blueprint.yaml>
```

Expected evidence:

- valid blueprint,
- no unexpected warnings,
- node and edge counts reported,
- any warnings explained or fixed.

If the viewer `RUN` button is the user-facing path, this validation must match that prepared-graph path closely enough to catch prepared condition-reference errors.

## Blueprint + Inputs Dry Run

Run:

```bash
pnpm --filter @gorenku/cli exec tsx src/cli.tsx generate --blueprint=<blueprint.yaml> --inputs=<inputs.yaml> --dry-run
```

Expected evidence:

- dry-run status succeeded,
- layer count and job count make sense,
- no failed jobs,
- skipped jobs match conditional branches,
- producer breakdown matches expected workflows,
- no old/shared producer remains scheduled when it was removed.

For example, after splitting generic motion prompt producers, the dry-run should show branch-specific prompt producer names and should not show the removed generic producer.

## Condition-Heavy Dry Run

Inspect dry-run validation coverage:

- condition fields list,
- variation/dual-outcome coverage,
- produced condition paths,
- concrete fixed-index paths such as `ImagePlans[0]` and `ImagePlans[1]`.

If a branch depends on a condition but dry-run has no produced path for that condition, the dry-run did not prove the branch.

## Stage-By-Stage Workflows

Users commonly run early layers first, inspect outputs in the viewer, then continue.

When the change affects runtime plan safety or graph dependencies, test stage-limited planning:

```bash
pnpm --filter @gorenku/cli exec tsx src/cli.tsx generate --blueprint=<blueprint.yaml> --inputs=<inputs.yaml> --dry-run --up-to-layer=0
```

Adjust layer number to the workflow being tested.

Required behavior:

- scheduled jobs in the selected layer validate,
- later-layer unscheduled dependencies do not fail the run,
- missing dependencies in scheduled jobs still fail fast.

## Costs Only

Before paid generation, when useful:

```bash
pnpm --filter @gorenku/cli exec tsx src/cli.tsx generate --blueprint=<blueprint.yaml> --inputs=<inputs.yaml> --costs-only
```

Never run paid generation without explicit user approval.

## Source Code Changes

If Renku source changed, final verification must include:

```bash
pnpm build
pnpm test
```

Focused tests are useful during development but are not enough as the final gate.

## Error-Code Discipline

When adding validation/runtime failures:

- use the numbered Renku error code mechanism,
- add tests asserting the specific code,
- do not add ad-hoc unnumbered exceptions,
- do not add fallbacks to keep execution going.

## Reporting Back

Report:

- commands run,
- validation warnings,
- dry-run layer/job summary,
- condition coverage summary when relevant,
- final build/test status if source changed,
- residual risks.
