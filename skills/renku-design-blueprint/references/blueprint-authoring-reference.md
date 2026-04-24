# Renku Blueprint Authoring Reference

Use this when actually implementing a reusable blueprint. Keep `SKILL.md` as the workflow guide; this file carries the detailed mechanics.

## Current Authored Blueprint Shape

```yaml
meta:
  name: Human readable name
  description: What this workflow produces
  id: PascalCaseBlueprintId
  kind: blueprint
  version: 0.1.0

inputs:
  - name: InquiryPrompt
    type: string
    required: true

outputs:
  - name: SegmentVideos
    type: array
    itemType: video
    countInput: NumOfSegments

loops:
  - name: segment
    countInput: NumOfSegments

imports:
  - name: PlanDirector
    path: ./planning/director/producer.yaml
  - name: VideoProducer
    producer: video/text-to-video
    loop: segment

conditions:
  motionIsText:
    when: PlanDirector.AssetPlan.Segments[segment].MotionPlan.Workflow
    is: Text

connections:
  - from: InquiryPrompt
    to: PlanDirector.InquiryPrompt
  - from: PlanDirector.AssetPlan.Segments[segment].VideoPrompt
    to: VideoProducer[segment].Prompt
    if: motionIsText
  - from: VideoProducer[segment].GeneratedVideo
    to: SegmentVideos[segment]
    if: motionIsText
```

Use `outputs:` for top-level published artifacts. Do not add legacy `artifacts:` or `collectors:` blocks to authored blueprints.

## Project Setup And Catalog Use

For new user/workspace blueprints, scaffold instead of manually copying catalog files:

```bash
renku new:blueprint <project-name>
```

If the user explicitly asks to start from a catalog blueprint, use the CLI copy path:

```bash
renku new:blueprint <project-name> --using <catalog-blueprint-name>
```

Treat the catalog as reference material unless the task is explicitly to edit catalog content. For project blueprints, put local prompt producers under the project folder:

```text
my-project/
  my-project.yaml
  input-template.yaml
  planning/my-director/
    producer.yaml
    prompts.toml
    output-schema.json
```

Use kebab-case project folders and PascalCase `meta.id` values.

Before designing from scratch, inspect existing workspace/catalog patterns for comparable graphs, but do not copy their structure blindly.

## Requirement Analysis Before YAML

Before writing the graph, identify:

- endpoint: asset-only, composition/timeline, or rendered video;
- media types actually requested: images, video clips, narration, native audio, music, subtitles, talking head, lipsync;
- user-provided assets and their roles;
- segment/scene/image/character/reference counts;
- model/provider preferences;
- whether the user wants a reusable blueprint or a one-time session workflow.

Do not add optional media tracks speculatively. Narration/TTS, music, subtitles, and timeline/export are explicit design choices, not defaults.

Usually include user-facing creative controls such as `Style` and, when tone/content changes with audience, `Audience`.

## Inputs

Top-level inputs should be user-facing controls:

- `Duration` and `NumOfSegments` when the user controls video timing.
- `NumOfImagesPerSegment`, `NumOfCharacters`, `NumOfExperts`, etc. when loops depend on them.
- Creative controls such as `InquiryPrompt`, `Style`, `Audience`, `LanguageCode`, `Resolution`.
- User-provided media such as `ReferenceImages` or `ProductImages`.

Do not expose derived/runtime values as user inputs:

- `SegmentDuration`
- `MovieId`
- `StorageRoot`
- `StorageBasePath`

These may still be referenced in `connections:` when the system provides them.

## Outputs

Declare every artifact the user, viewer, or downstream tool needs:

- Asset-only blueprint: publish media assets plus any JSON/markdown plan outputs.
- Composition blueprint: publish the timeline/composition artifact.
- Rendered blueprint: publish the final video artifact.

Array outputs must match the loop shape:

```yaml
outputs:
  - name: SegmentNarrationAudio
    type: array
    itemType: audio
    countInput: NumOfSegments
  - name: SegmentReferenceStillImages
    type: multiDimArray
    itemType: image
```

Every declared output needs a connection from a producer output or imported child blueprint output.

## Loops

Loops create dimensions. Use lowercase names and explicit count inputs:

```yaml
loops:
  - name: segment
    countInput: NumOfSegments
  - name: image
    countInput: NumOfImagesPerSegment
    parent: segment
```

Assign producers to loop dimensions:

```yaml
imports:
  - name: SegmentImageProducer
    producer: image/text-to-image
    loop: segment.image
```

Then wire values with matching dimensions:

```yaml
- from: PlanDirector.AssetPlan.Segments[segment].ImagePlans[image].Prompt
  to: SegmentImageProducer[segment][image].Prompt
```

Avoid guessing dimension alignment from names. If dimensions do not line up, fix the graph explicitly.

## Imports

Use `producer:` for catalog producers:

```yaml
imports:
  - name: NarrationAudioProducer
    producer: audio/text-to-speech
    loop: segment
```

Use `path:` for local/custom producers, especially director prompt producers:

```yaml
imports:
  - name: PlanDirector
    path: ./planning/documentary-plan-director/producer.yaml
```

The import `name` becomes the blueprint-local producer ID used in connections and model config.

## Connections

Common patterns:

```yaml
# Scalar broadcast
- from: Style
  to: PlanDirector.Style

# Looped producer input
- from: PlanDirector.AssetPlan.Segments[segment].Narration
  to: NarrationAudioProducer[segment].TextInput

# Fixed slot in an input collection
- from: HistoricalPortraitProducer[historicalcharacter].GeneratedImage
  to: ReferenceClipProducer[segment][historicalcharacter].ReferenceImages[0]

# Published output
- from: NarrationAudioProducer[segment].GeneratedAudio
  to: SegmentNarrationAudio[segment]
```

Keep source and target dimensions compatible. Do not rely on string similarity or alias-like names.

### Constant-Index Subfield Caution

Fixed item references are useful for condition paths and input slots, but hardcoded item access into director output arrays can be fragile when followed by subfields.

Prefer schema shapes that expose important first/last/special values as explicit scalar fields when they need special wiring:

```yaml
# Prefer this shape when a value is special and scalar.
- from: PlanDirector.AssetPlan.OpeningImagePrompt
  to: OpeningImageProducer.Prompt
```

If you need fixed indexes such as `ImagePlans[0]` and `ImagePlans[1]` in conditions, validate through the prepared/viewer path and dry-run condition coverage.

## Collection Broadcast

When every looped producer should receive the whole collection, wire the whole collection:

```yaml
- from: StyleReferenceImages
  to: CharacterImageProducer[character].SourceImages
```

Do not create a second loop just to push collection elements unless the producer instance needs one specific element.

When each producer instance needs one element, index by the producer loop:

```yaml
- from: CharacterReferenceImages[character]
  to: CharacterImageProducer[character].SourceImages[0]
```

## Fan-In

Fan-in is connection-driven. Do not add `collectors:`.

If a producer input is declared with `fanIn: true`, Renku infers grouped upstream artifacts from connections:

```yaml
- from: SegmentVideoProducer[segment].GeneratedVideo
  to: TimelineComposer.VideoClips
```

The producer contract determines whether `TimelineComposer.VideoClips` is fan-in capable. If fan-in grouping is ambiguous, use explicit `groupBy` or adjust dimensions.

## Conditions

Use named conditions for reused branch logic:

```yaml
conditions:
  motionIsReference:
    when: PlanDirector.AssetPlan.Segments[segment].MotionPlan.Workflow
    is: Reference
```

Groups are supported:

```yaml
conditions:
  motionIsStartEndWithPlainAnchors:
    all:
      - when: PlanDirector.AssetPlan.Segments[segment].MotionPlan.Workflow
        is: StartEnd
      - when: PlanDirector.AssetPlan.Segments[segment].ImagePlans[0].UseHistoricalReference
        is: false
      - when: PlanDirector.AssetPlan.Segments[segment].ImagePlans[1].UseHistoricalReference
        is: false
```

If the condition grammar cannot express the exact branch union cleanly, split the producer imports by branch instead of broadening conditions.

## Timing And Media Duration

Video and audio producers must have a required `Duration` input, and blueprints must wire it explicitly:

```yaml
- from: SegmentDuration
  to: SeedanceTextClipProducer[segment].Duration
```

Do not rely on defaults or implicit SDK behavior for duration.

## Audio, Timeline, And Transcription Routing

Only add a timeline composer or exporter when the endpoint requires composition or final rendering.

If audio is used only to drive a talking-head or lipsync video, do not also route that original audio as a separate timeline track unless the user wants it heard separately.

For transcription of lipsync/talking-head video, prefer the final video producer's derived `AudioTrack` when available, because it reflects the actual rendered speech timing.

Add transcription/karaoke only when requested. It requires timeline-aware audio routing, transcription producer config, and exporter subtitle config.

## Prompt Producer Placement

Reusable blueprints usually need a director prompt producer when high-level user intent expands into many downstream prompt fields.

One-time video sessions may skip reusable prompt producers and put prompt-bearing fields directly in `inputs.yaml`; use `renku-create-video` for that mode.

## Implementation Checklist

1. Confirm requirements and endpoint.
2. Define user-facing inputs and loop counts.
3. Pick workflow/producers with `renku-pick-workflow`.
4. Add local director prompt producer if needed with `renku-author-director`.
5. Wire every producer input explicitly.
6. Declare and wire every published output.
7. Review warnings: unused inputs/outputs/producers usually indicate a missed connection or unnecessary declaration.
8. Audit optional branches with `renku-audit-conditions`.
9. Validate and dry-run with `renku-validate-run`.
