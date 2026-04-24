# Required Input Coherence

A producer can run only when all of its required inputs are available under the same branch.

Unsafe:

```yaml
- from: ReferencePromptProducer[segment].Prompt
  to: ReferenceClipProducer[segment].Prompt
  if: referenceWorkflow

- from: SourceImageProducer[segment].GeneratedImage
  to: ReferenceClipProducer[segment].SourceImage
```

If `SourceImage` keeps the producer alive outside `referenceWorkflow`, the prompt can be condition-filtered away while the job still runs.

Safer:

```yaml
- from: ReferencePromptProducer[segment].Prompt
  to: ReferenceClipProducer[segment].Prompt
  if: referenceWorkflow

- from: SourceImageProducer[segment].GeneratedImage
  to: ReferenceClipProducer[segment].SourceImage
  if: referenceWorkflow
```

Audit rule:

- Identify every required input declared by the imported producer.
- Find every connection into that required input.
- Compute when the producer can run from all incoming connections.
- Ensure the producer's activation condition implies each required input's availability condition.

Do not infer missing required inputs from names. If a required input is not explicitly wired, the blueprint is invalid.
