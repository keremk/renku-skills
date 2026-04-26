# Kling Workflows

Kling-style workflows are strongest when shot structure, character labels, and image anchors are explicit.

Use image-to-video for branded or character-consistent scenes anchored by an image. Use multi-shot when the model/producer exposes per-shot prompting. Use reference-to-video when the producer exposes reference fields for identities, products, or reusable visual elements. Use audio-enabled workflows only when the producer mapping exposes the required audio or voice controls.

For Kling O3 reference-to-video, Renku projects references from the model schema. Top-level `image_urls` become `@Image1`, `@Image2`, and so on. Grouped `elements[]` entries become `@Element1`, `@Element2`, and so on, with fields such as `frontal_image_url`, `reference_image_urls`, and optional `video_url` merged by group order.

Gotchas:

- Multi-shot support is producer-specific. Do not write multi-shot inputs for a plain text-to-video producer unless the prompt-only workflow is intentionally being used.
- Dialogue needs stable character labels and clear turn-taking.
- Image-to-video prompts should describe motion and camera evolution, not replace the source scene.
