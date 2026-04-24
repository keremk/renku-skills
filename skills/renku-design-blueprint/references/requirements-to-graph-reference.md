# Requirements To Graph Reference

Use this to translate user requests into blueprint structure before selecting producers or writing YAML.

## Core Questions

Ask or infer only when the answer is clear:

- Is the endpoint asset-only, composition/timeline, or rendered final video?
- Which media are actually required?
- Are there user-provided references or assets? What should each reference control?
- How many segments, images per segment, characters, products, experts, or historical subjects are needed?
- Should the blueprint be reusable, or is this a one-time video session better handled by `renku-create-video`?
- Are there required models/providers or cost/quality constraints?

## Common Requirement Shapes

### Asset-Only Documentary

Use when another tool or human will assemble the final video.

Likely outputs:

- `AssetPlan` JSON or markdown plan,
- narration audio,
- still images,
- reference-composed images,
- generated motion clips,
- maps or diagrams,
- character/expert/reference assets.

Do not add timeline composer or exporter.

### Image-Based Documentary

Likely structure:

- director prompt producer creates segment plans, image prompts, narration text, optional overlays;
- image producer runs `segment.image`;
- TTS runs `segment` if narration is requested;
- optional music only if requested;
- optional timeline/export only if final video is requested.

### Continuous Flow Video

Likely structure:

- initial image or first text-to-video clip,
- subsequent image-to-video clips chained from prior `LastFrame`,
- narration/music only if requested,
- careful prompt design so each segment naturally continues.

Gotcha: derived `LastFrame` availability depends on video producer output and ffmpeg extraction behavior. Validate and dry-run the chaining.

### Talking Head Or Lipsync

Likely structure:

- character/portrait image generation or supplied character image,
- TTS or supplied audio,
- talking-head/lipsync video producer,
- use derived `AudioTrack` for transcription timing when subtitles are needed.

Voice IDs are model-specific. Put them in model config or model-specific inputs, not reusable top-level blueprint inputs unless the producer contract truly requires a user-facing value.

### Product/Ad Video

Likely structure:

- product image or supplied product references,
- character/spokesperson image if needed,
- per-clip video prompts,
- native audio or separate TTS depending on model/workflow,
- music only if requested,
- final CTA/brand outputs if the blueprint publishes planning metadata.

### Cut-Scene/Multi-Shot Clips

Use one producer invocation per segment with structured shot prompts when the model supports it. Do not create nested video producer groups unless the workflow truly needs independent clips.

For prompt-only multi-shot models, use explicit shot labels. For producer-level multi-shot controls, use the exact fields exposed by the producer contract.

## Implicit But Not Speculative Inputs

Usually include:

- `Style` or `VisualStyle`,
- `Audience` when it affects tone/depth,
- `Duration` and `NumOfSegments` when video/audio structure depends on them,
- count inputs for declared loops.

Do not add:

- music just because videos often have music,
- subtitles just because narration exists,
- timeline/export when the endpoint is asset-only,
- voice IDs as portable top-level inputs.

## Requirement Smell Tests

- If a requested feature has no producer path, stop and change the blueprint rather than inventing unsupported inputs.
- If a director schema field does not route to a connection, condition, or published output, keep it in prompt instructions instead of schema.
- If the graph branches by workflow, audit conditions before writing the final YAML.
