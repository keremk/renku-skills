# Producer Workflow Reference

Use this to choose a workflow shape before selecting exact models. Always confirm exact producer names, inputs, mappings, and model IDs from the current catalog before editing a blueprint or input template.

## Decision Order

1. Identify the desired control surface.
2. Pick the producer contract that exposes that control surface.
3. Pick a model that appears in that producer's `mappings`.
4. Add exact `models:` entries for the concrete blueprint producer IDs.
5. Hand prompt writing to `renku-write-prompts`.

Vendor capability is not enough. If the local Renku producer does not expose a capability, do not plan a workflow that depends on it.

## Video Workflow Choices

### Text-To-Video

Use when:

- no source image, reference image, or existing video is required,
- the model should create the full scene from text,
- the clip can be described as one scene or a prompt-structured multi-shot sequence supported by the chosen model/producer.

Typical inputs:

- `Prompt`
- `Duration`
- `Resolution` or `AspectRatio`
- optional native-audio controls when exposed

### Image-To-Video

Use when:

- a source image is the first frame or visual anchor,
- identity/layout/composition should start from a known image,
- a previous clip's `LastFrame` should continue into the next clip.

Prompt rule:

- describe motion, camera evolution, and sound;
- do not spend the whole prompt re-describing the source image.

### Start/End-Frame Video

Use when:

- both start and end images must be used,
- the desired output is a controlled A-to-B transition,
- every scheduled clip has both anchors available.

Graph rule:

- if anchors are conditionally generated, gate the video producer on both anchor availability conditions.

### Reference-To-Video

Use when:

- supplied reference images, videos, or audio clips define character identity, product identity, environment, style, motion, or sound,
- the references are not necessarily the first frame,
- consistency across clips matters more than exact first-frame matching.

Prompt rule:

- assign explicit roles to references only if the producer exposes those references.
- use modality labels such as `@Image1`, `@Video1`, and `@Audio1` only for media that is actually supplied by the graph.

Payload rule:

- provider payloads are projected from the producer mapping and the target model schema; do not reshape fan-in by hand.
- plain schema arrays such as `image_urls` receive arrays, so final order determines labels like `@Image1` and `@Image2`.
- nested Kling O3 paths such as `elements[].frontal_image_url` and `elements[].reference_image_urls` build one `elements[index]` object per fan-in group; `elements[0]` is `@Element1`.
- scalar fields such as `start_image_url` and `end_image_url` require scalar bindings or an explicit transform such as `firstOf`; never silently take the first fan-in item.

Graph rule:

- when a clip targets selected historical characters or other selected reference subjects, represent the selection with declared dimensions and explicit bindings;
- do not hardcode `[0]` as the selected subject;
- do not infer selection from producer names, canonical IDs, aliases, or string similarity.

### Multi-Shot Video

Use when:

- one generated clip should contain multiple shots or cuts,
- the model/producer supports shot labeling, multi-prompt fields, or structured shot controls,
- duration is long enough for the number of shots.

Prompt rule:

- label shots explicitly and keep one primary action per shot.

### Talking Head And Lipsync

Use separate TTS plus talking-head when:

- speech quality and voice control matter,
- the user wants to review/regenerate audio separately,
- the video producer takes an audio artifact.

Use text-to-talking-head when:

- the producer/model handles TTS internally,
- simpler workflow matters more than separate audio control.

Use video-lipsync when:

- an existing video should get new speech/lip movement.

## Image Workflow Choices

### Text-To-Image

Use for brand-new stills with no source image.

### Image Edit

Use for modifying one source image while preserving most of its content.

### Image Compose

Use for combining multiple source images into one generated image.

### Storyboard/Grid

Use when the model should create a multi-panel layout that Renku later splits into derived panel artifacts.

## Audio Workflow Choices

### TTS

Use for narration, dialogue, or any speech where clarity and voice consistency matter.

### Native Video Audio

Use when ambience, effects, simple speech, or integrated audiovisual timing is part of the video model's strength.

Do not enable native audio just because the model supports it. If no downstream audio is needed, leave it off.

### Music

Add music only when explicitly requested. Background music is not an implicit requirement.

## Model Selection Checklist

For each candidate:

1. Search current catalog producer mappings for the exact model.
2. Confirm provider and exact model ID in the provider model catalog.
3. Confirm required inputs exist and are wired.
4. Confirm duration, resolution, aspect ratio, audio, and reference constraints.
5. Confirm pricing if cost matters.
6. Add one `models:` entry per concrete blueprint producer ID.

## Output Example

```yaml
models:
  - model: bytedance/seedance-2.0/reference-to-video
    provider: fal-ai
    producerId: SeedanceReferenceClipProducer
```

The `producerId` is the blueprint import name, not the catalog producer's generic ID.
