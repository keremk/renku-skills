---
name: renku-author-director
description: Author or repair Renku LLM director prompt producers. Use when creating or updating producer.yaml, prompts.toml, output-schema.json, director output schemas, prompt-producer variable bindings, or high-level prompt producers that generate downstream image/video/audio prompts for a blueprint.
---

# Renku Author Director

Author LLM prompt producers that generate structured plans and downstream prompts for Renku blueprints.

## File Contract

A prompt producer uses three files:

- `producer.yaml`: declares `meta`, `inputs`, `outputs`, and optional `loops`.
- `prompts.toml`: declares `variables`, `systemPrompt`, and `userPrompt`.
- `output-schema.json`: declares strict structured output.

`promptFile` and `outputSchema` belong under `meta` in `producer.yaml`. Do not use old top-level `type`, `artifacts`, `prompts`, or `output` sections.

## Authoring Workflow

1. Read the blueprint graph and downstream producer inputs.
2. Design the director output schema only for fields that are wired or intentionally published.
3. Use `renku-write-prompts` for model-specific prompt formulas inside the director instructions.
4. Keep conditional fields explicit: empty strings or empty arrays for inactive downstream fields, never `N/A` placeholders.
5. Match TOML variables exactly to YAML inputs.
6. Validate schema strictness and graph wiring with `renku-validate-run`.

## Director Prompt Must Cover

- User intent, style, audience, duration, and segment structure.
- Visual consistency anchors when recurring subjects or settings exist.
- Workflow-specific prompt fields: text, image anchor, start/end, reference, multi-shot, narration, native audio.
- Timing constraints for narration or dialogue.
- Conditional routing values that downstream graph conditions rely on.

## References

- Read `references/director-authoring-reference.md` when implementing or repairing actual prompt producer files.
- Read `references/prompt-producer-contract.md` for valid file shapes.
- Read `references/director-schema-design.md` for output schema rules.
- Read `references/director-to-graph-alignment.md` before adding or removing schema fields.
