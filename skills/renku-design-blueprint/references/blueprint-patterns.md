# Blueprint Patterns

## Endpoint choices

- Asset-only: publish generated assets and planning metadata for another tool or human to compose later.
- Composition: produce a timeline/composition artifact, but not a final rendered video.
- Rendered video: continue through timeline composer and exporter.

Do not add later endpoints speculatively. The endpoint changes producer needs, costs, validation scope, and user expectations.

## Reusable blueprint shape

- Inputs: user-facing controls only.
- Loops: derive from explicit count inputs.
- Imports: name concrete producer roles, not generic model names.
- Conditions: describe workflow routing in named conditions when reused.
- Outputs: publish only assets/metadata the user or downstream workflow needs.

## Prompt producer vs direct inputs

Use a director prompt producer when the blueprint must be reusable and expand high-level user intent into many structured fields.

Use direct prompt-bearing inputs when the task is a one-time video session and the agent/user will author prompts interactively.
