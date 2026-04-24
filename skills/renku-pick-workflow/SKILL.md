---
name: renku-pick-workflow
description: Pick the right Renku workflow, producers, providers, and model configurations for generation tasks. Use when choosing between text-to-video, image-to-video, start/end-frame, reference-to-video, multi-shot, talking-head, lipsync, image edit/compose, TTS, music, or composition workflows, especially for capability-rich models like Seedance, Kling, Veo, Wan, or LTX.
---

# Renku Pick Workflow

Choose the workflow first, then the producer contract, then the model.

## Decision Order

1. Identify the needed media and control mode: text, image anchor, start/end frames, references, multi-shot, native audio, TTS, talking head, composition, export.
2. Inspect catalog producer contracts and mappings. A model is usable only if the active producer exposes the needed inputs and maps to that model.
3. Read provider model files for exact model IDs and pricing. Never rely on memory.
4. Return concrete producer IDs and `models:` entries for the input template or build inputs.
5. Hand off to `renku-write-prompts` for model-workflow-specific prompt text.
6. Hand off to `renku-audit-conditions` if the selected workflow introduces optional branches.

## Critical Rule

Vendor capability is not enough. The current Renku producer contract must expose the needed capability. If a vendor supports video references but the chosen producer only exposes image references, do not write or plan video-reference prompts.

## Output Format

Return recommendations in this shape:

```yaml
models:
  - model: <exact-catalog-model-name>
    provider: <provider>
    producerId: <blueprint-producer-id>
```

Include any required model config explicitly. Do not invent defaults to keep going.

## References

- Read `references/producer-workflow-reference.md` when selecting concrete workflow shapes and producer contracts.
- Read `references/model-family-execution-patterns.md` when deciding whether a model family changes graph topology rather than only prompt text.
- Read `references/workflow-decision-tree.md` for producer/workflow selection.
- Read `references/model-contract-checklist.md` before committing a model choice.
- Read `references/seedance-workflows.md` for Seedance-specific workflow implications.
- Read `references/kling-workflows.md` for Kling-specific workflow implications.
