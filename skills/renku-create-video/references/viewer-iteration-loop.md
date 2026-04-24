# Viewer Iteration Loop

Use the viewer and agent together:

1. Generate planning/reference assets first when the blueprint supports staged execution.
2. Inspect generated artifacts visually in the viewer.
3. Pin artifacts the user likes.
4. Regenerate weak artifacts with targeted prompt/model changes.
5. Continue to later stages only after upstream anchors are good enough.
6. Preserve pinned artifacts across edits unless the user asks to replace them.

For condition-heavy blueprints, stage-by-stage generation is normal. Do not treat unscheduled later stages as errors.
