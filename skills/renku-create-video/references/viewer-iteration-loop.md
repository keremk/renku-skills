# Viewer Iteration Loop

Use the viewer and agent together:

1. Preflight the selected stage scope before running it.
2. Generate planning/reference assets first when the blueprint supports staged execution.
3. Inspect generated artifacts visually in the viewer.
4. Pin artifacts the user likes.
5. Regenerate weak artifacts with targeted prompt/model changes.
6. Continue to later stages only after upstream anchors are good enough.
7. Preserve pinned artifacts across edits unless the user asks to replace them.

For condition-heavy blueprints, stage-by-stage generation is normal. Do not treat unscheduled later stages as errors.
