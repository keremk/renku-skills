# Seedance Workflows

Seedance should be treated as a workflow family.

Use text-to-video for text-only clips. Use image-to-video when a source image should anchor the frame. Use start/end only when both anchor frames are plain generated images or otherwise guaranteed available. Use reference-to-video when references define historical characters, brand identity, product identity, or style. Use multi-shot when one clip needs explicit shot structure.

Gotchas:

- Reference clips should use reference-specific prompts and reference-specific producers.
- StartEnd clips must be gated by both workflow and anchor availability.
- Native audio should be intentional; do not enable it just because the model can generate audio.
- If richer vendor multimodal references are not exposed by the Renku producer contract, do not plan prompts that depend on them.
