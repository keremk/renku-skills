# Model Family Execution Patterns

For advanced video models, model choice can change the graph topology.

Do not treat Seedance, Kling, Veo, Wan, and LTX as interchangeable strings if their workflows need different inputs.

## Pick in this order

1. Execution family.
2. Workflow mode.
3. Producer contract.
4. Exact model.

## Topology-changing capabilities

These usually affect blueprint shape:

- text-to-video,
- image-to-video,
- start/end-frame video,
- reference-to-video,
- multi-shot or shot-structured video,
- talking-head or lipsync,
- native audio generation.

If the needed control is not an exposed producer input, do not hide it in the prompt. Choose another producer or design a local producer contract.

## Prompt portability

Prompts are portable only when the workflow contract is portable.

A reference-to-video prompt that assumes identity references should not be reused for a text-only producer. A StartEnd prompt that assumes explicit anchor frames should not be used when the model only receives one source image.
