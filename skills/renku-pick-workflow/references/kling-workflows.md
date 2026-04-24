# Kling Workflows

Kling-style workflows are strongest when shot structure, character labels, and image anchors are explicit.

Use image-to-video for branded or character-consistent scenes anchored by an image. Use multi-shot when the model/producer exposes per-shot prompting. Use audio-enabled workflows only when the producer mapping exposes the required audio or voice controls.

Gotchas:

- Multi-shot support is producer-specific. Do not write multi-shot inputs for a plain text-to-video producer unless the prompt-only workflow is intentionally being used.
- Dialogue needs stable character labels and clear turn-taking.
- Image-to-video prompts should describe motion and camera evolution, not replace the source scene.
