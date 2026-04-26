# Seedance Workflows

Seedance should be treated as a workflow family.

Use text-to-video for text-only clips. Use image-to-video when a source image should anchor the frame. Use start/end only when both anchor frames are plain generated images or otherwise guaranteed available. Use reference-to-video when supplied references define historical characters, brand identity, product identity, style, motion, or audio character. Use multi-shot when one clip needs explicit shot structure.

Gotchas:

- Reference clips should use reference-specific prompts and reference-specific producers.
- Seedance reference clips can use optional `ReferenceImages`, `ReferenceVideos`, and `ReferenceAudios`; images are not mandatory for the reference workflow.
- Reference fan-in is projected into provider arrays from the model schema: `ReferenceImages` maps to `image_urls`, `ReferenceVideos` maps to `video_urls`, and `ReferenceAudios` maps to `audio_urls`.
- Reference prompts must mention only media labels that the graph actually supplies, such as `@Image1`, `@Video1`, or `@Audio1`; label numbers follow the final projected array order.
- Fal requires audio references to be paired with at least one image or video reference.
- StartEnd clips must be gated by both workflow and anchor availability.
- Native audio should be intentional; do not enable it just because the model can generate audio.
- If a reference modality is not exposed by the active Renku producer contract, do not plan prompts that depend on it.
