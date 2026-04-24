# Blueprint Patterns

## Endpoint choices

- Asset-only: publish generated assets and planning metadata for another tool or human to compose later.
- Composition: produce a timeline/composition artifact, but not a final rendered video.
- Rendered video: continue through timeline composer and exporter.

Do not add later endpoints speculatively. The endpoint changes producer needs, costs, validation scope, and user expectations.

## Published outputs are endpoints

Producer outputs are internal graph values. Top-level blueprint outputs are publication endpoints.

Good:

```yaml
- from: SegmentPlainImageProducer[segment][image].GeneratedImage
  to: SegmentStillImages[segment][image]

- from: SegmentPlainImageProducer[segment][0].GeneratedImage
  to: SeedanceStartEndClipProducer[segment].StartImage
```

The first edge publishes an artifact. The second edge feeds an internal producer directly from the real source.

Bad:

```yaml
- from: SegmentStillImages[segment][0]
  to: SeedanceStartEndClipProducer[segment].StartImage
```

Do not route from a published output back into the graph. It hides the real dependency and makes conditions ambiguous.

## Reusable blueprint shape

- Inputs: user-facing controls only.
- Loops: derive from explicit count inputs.
- Imports: name concrete producer roles, not generic model names.
- Conditions: describe workflow routing in named conditions when reused.
- Outputs: publish only assets/metadata the user or downstream workflow needs.

## Prompt producer vs direct inputs

Use a director prompt producer when the blueprint must be reusable and expand high-level user intent into many structured fields.

Use direct prompt-bearing inputs when the task is a one-time video session and the agent/user will author prompts interactively.
