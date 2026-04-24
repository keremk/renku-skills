# Common Errors In Advanced Blueprints

## Published output used internally

Bad:

```yaml
- from: PublishedStills[segment][0]
  to: StartEndClipProducer[segment].StartImage
```

Fix by connecting from the producer that created the still.

## Required input disappears

Bad:

```yaml
- from: PromptProducer.Prompt
  to: ClipProducer.Prompt
  if: referenceWorkflow

- from: SourceImageProducer.GeneratedImage
  to: ClipProducer.SourceImage
```

Fix by aligning conditions for every required input that can make the producer run.

## Generic prompt producer runs in unused branch

If a Reference branch uses a reference-specific prompt, do not also run a generic prompt producer for that branch unless the output is consumed.

## Stage-limited false alarm

When using `--up` or `--up-to-layer`, later-layer artifacts are intentionally absent. Validate and dry-run the selected scope, then continue stage by stage.
