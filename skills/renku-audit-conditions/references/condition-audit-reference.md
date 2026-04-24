# Condition Audit Reference

Use this for blueprints where branches control whether producers run, whether outputs are published, or which workflow path a model uses.

## Core Invariant

For every edge from a producer output to a consumer input:

```text
consumer condition must imply source producer condition
```

In plain words: a consumer must never be active in a branch where the source artifact was not produced.

## Producer Activation

A producer becomes scheduled when its required inputs are satisfied in a branch. In condition-heavy graphs, inspect the incoming edges that provide required inputs.

For a producer output:

1. Identify the producer instance.
2. Identify all incoming edges that activate the producer.
3. Combine their conditions into the branch where the producer can run.
4. Compare that to every outgoing consumer edge.

If an outgoing consumer condition is broader, the graph can produce missing-input runtime failures.

## Unused Active Producers

For each producer:

1. Identify all branches where it can run.
2. Identify all outgoing edges from its outputs.
3. Confirm at least one outgoing edge is active in each branch, unless the output is intentionally published.

If a producer can run in a branch where no downstream edge consumes its outputs, the graph wastes a model invocation.

## Branch-Specific Prompt Producers

Prompt producers are often cheap-looking but can be expensive and logically wrong when shared too broadly.

Use separate prompt producer imports when:

- Text, StartEnd, MultiShot, and Reference workflows need different prompt fields;
- one workflow needs additional anchor availability conditions;
- reference workflows use reference-specific prompt language;
- the condition grammar cannot express the exact safe union clearly.

Good pattern:

```yaml
imports:
  - name: TextMotionPromptProducer
    path: ./motion/motion-prompt/producer.yaml
    loop: segment
  - name: StartEndMotionPromptProducer
    path: ./motion/motion-prompt/producer.yaml
    loop: segment
  - name: MultiShotMotionPromptProducer
    path: ./motion/motion-prompt/producer.yaml
    loop: segment
```

Each import gets inputs gated exactly like the downstream clip producer it feeds.

## Start/End Anchor Safety

Bad condition:

```yaml
motionIsStartEnd:
  when: PlanDirector.AssetPlan.Segments[segment].MotionPlan.Workflow
  is: StartEnd
```

This is not enough if `StartImage` or `EndImage` comes from optional generated stills.

Good condition:

```yaml
motionIsStartEndWithPlainAnchors:
  all:
    - when: PlanDirector.AssetPlan.Segments[segment].MotionPlan.Workflow
      is: StartEnd
    - when: PlanDirector.AssetPlan.Segments[segment].ImagePlans[0].UseHistoricalReference
      is: false
    - when: PlanDirector.AssetPlan.Segments[segment].ImagePlans[1].UseHistoricalReference
      is: false
```

Use the stricter condition for:

- prompt producer inputs,
- prompt-to-clip edge,
- start image edge,
- end image edge,
- duration/resolution/audio config edges,
- clip output,
- published output.

## Reference Workflow Safety

Reference workflows should not trigger generic text/start-end/multishot prompt producers unless those outputs are actually consumed.

Reference branch should usually have:

- reference-specific prompt producer,
- reference image inputs,
- reference clip producer,
- reference output.

## Dry-Run Evidence

After fixes, dry-run should prove:

- no missing scheduled artifact inputs,
- no unused active prompt producer warnings,
- condition fields are produced,
- fixed-index paths used by conditions appear in produced condition paths,
- producer breakdown matches expected branches.

Do not accept “the prompt asks the model not to do this” as a graph safety guarantee. Structural guards belong in the blueprint.
