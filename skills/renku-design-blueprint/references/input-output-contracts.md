# Input And Output Contracts

## Inputs

- Declare `Duration` and `NumOfSegments` when users provide them and the blueprint depends on them.
- Do not expose derived runtime values as user inputs.
- Voice IDs and other model-specific controls usually belong in model config, not reusable blueprint inputs.

## Outputs

- Every declared output must be wired.
- Arrays need the correct `countInput`.
- Multi-dimensional outputs should mirror the loops that produce them.
- Asset-only outputs should include planning JSON/markdown if downstream tools need it.

## Director outputs

A director schema field should exist only if it is wired to downstream producers, used by conditions, or intentionally published.
