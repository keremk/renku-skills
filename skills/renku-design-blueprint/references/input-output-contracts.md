# Input And Output Contracts

## Inputs

- Declare `Duration` and `NumOfSegments` when users provide them and the blueprint depends on them.
- Do not expose derived runtime values as user inputs.
- Voice IDs and other model-specific controls usually belong in model config, not reusable blueprint inputs.
- Use `text`, not `string`, for prompt-like or long creative inputs so the viewer gives users a text editor. Good `text` candidates include prompts, inquiry briefs, style descriptions, character/product descriptions, narration, dialogue, and director instructions.
- Use `string` for short scalar fields such as labels, compact names, language codes, and enum-like values.
- For arrays of prompt-like values, use `type: array` with `itemType: text`.

## Outputs

- Every declared output must be wired.
- Arrays need the correct `countInput`.
- Multi-dimensional outputs should mirror the loops that produce them.
- Asset-only outputs should include planning JSON/markdown if downstream tools need it.

## Director outputs

A director schema field should exist only if it is wired to downstream producers, used by conditions, or intentionally published.
