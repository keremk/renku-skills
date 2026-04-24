# Asset-Only Blueprint Patterns

Asset-only blueprints are valid first-class workflows. They produce reusable images, audio, plans, prompts, reference bundles, or metadata for another tool or human to compose later.

## Endpoint rule

Top-level `outputs` publish artifacts out of the blueprint. They are not internal routing nodes.

Use this pattern:

```yaml
- from: CharacterPortraitProducer[character].GeneratedImage
  to: CharacterPortraits[character]

- from: CharacterPortraitProducer[character].GeneratedImage
  to: ReferenceBundleProducer[character].Portrait
```

Do not use this pattern:

```yaml
- from: CharacterPortraits[character]
  to: ReferenceBundleProducer[character].Portrait
```

The downstream producer should depend on the producer that actually creates the artifact.

## Reference asset usefulness

If the blueprint creates portraits, character sheets, start/end frames, style references, or reference bundles, identify the consumer.

- If the asset is only for humans or another external tool, publish it as an output and stop.
- If another producer inside the blueprint needs it, wire that producer directly from the producing producer.
- If no internal or external consumer exists, the asset is likely unnecessary.

## Asset-only smell tests

- Do not add timeline/export producers just to make the graph feel complete.
- Do not publish every intermediate artifact by default.
- Do publish artifacts the viewer or downstream composition tool needs to inspect, pin, regenerate, or reuse.
- Do keep conditions on internal consumers aligned with the producers that create their required inputs.
