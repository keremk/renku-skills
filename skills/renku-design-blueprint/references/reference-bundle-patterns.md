# Reference Bundle Patterns

Reference bundles are useful only when a downstream workflow consumes them or the blueprint intentionally publishes them for external use.

## Before creating references

Ask what the reference controls:

- identity,
- style,
- product appearance,
- location/environment,
- start frame,
- end frame,
- talking-head portrait,
- image edit source.

Then identify the consumer producer and the exact input it accepts.

## Safe internal use

Wire consumers directly from the producer that creates the reference:

```yaml
- from: HistoricalPortraitProducer[character].GeneratedImage
  to: ReferenceClipProducer[segment][character].ReferenceImages
```

For Seedance reference workflows, the reference inputs may include any supplied mix of `ReferenceImages`, `ReferenceVideos`, and `ReferenceAudios`. Wire only the modalities the producer contract declares and the graph actually provides. Provider payloads are schema-driven: Seedance maps those fan-in inputs to plain arrays like `image_urls`, `video_urls`, and `audio_urls`; Kling O3 can map grouped references into nested paths such as `elements[].frontal_image_url` and `elements[].reference_image_urls`.

When multiple generated references should become one provider array, use explicit fan-in grouping instead of a synthetic fixed slot:

```yaml
- from: HistoricalPortraitProducer[historicalcharacter].GeneratedImage
  to: ReferenceClipProducer[segment].ReferenceImages
  groupBy: singleton
  orderBy: historicalcharacter
```

Publish the same reference separately if the user needs to inspect or reuse it:

```yaml
- from: HistoricalPortraitProducer[character].GeneratedImage
  to: HistoricalPortraits[character]
```

Do not route from `HistoricalPortraits[character]` back to an internal producer.

## Completeness check

A reference asset is complete when one of these is true:

- It is wired to a downstream producer that accepts that reference type.
- It is published as an asset-only output for a human or external tool.

If neither is true, the blueprint is likely generating unused assets.
