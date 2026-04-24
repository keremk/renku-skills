# Director Prompt Producer Authoring Reference

Use this when creating or repairing a Renku director prompt producer.

## Purpose

A director prompt producer is an LLM producer that turns high-level user intent into structured data for the blueprint:

- segment plans,
- image prompts,
- video prompts,
- narration or dialogue text,
- branch routing fields,
- reference-use booleans,
- published planning metadata.

The director is part of the graph contract. Its output schema must match what downstream connections and conditions consume.

## File Layout

Recommended local layout:

```text
planning/my-director/
  producer.yaml
  prompts.toml
  output-schema.json
```

## Valid `producer.yaml`

```yaml
meta:
  name: Documentary Plan Director
  description: Generates the asset plan and downstream prompt fields.
  id: DocumentaryPlanDirector
  kind: producer
  version: 0.1.0
  promptFile: ./prompts.toml
  outputSchema: ./output-schema.json

inputs:
  - name: InquiryPrompt
    type: string
    required: true
  - name: Duration
    type: int
    required: true
  - name: NumOfSegments
    type: int
    required: true
  - name: Style
    type: string
    required: true

outputs:
  - name: AssetPlan
    type: json
```

Do not use old top-level `type`, `artifacts`, `prompts`, or `output` sections.

## Valid `prompts.toml`

```toml
variables = ["InquiryPrompt", "Duration", "NumOfSegments", "Style"]

systemPrompt = """
You are an expert director...
Return only valid JSON matching the schema.
"""

userPrompt = """
Topic: {{InquiryPrompt}}
Duration: {{Duration}} seconds
Segments: {{NumOfSegments}}
Style: {{Style}}
"""
```

Every TOML variable must exactly match a YAML input. Do not rely on aliases or casing guesses.

## Output Schema Design

The schema should be strict:

```json
{
  "name": "AssetPlan",
  "strict": true,
  "schema": {
    "type": "object",
    "additionalProperties": false,
    "properties": {
      "Segments": {
        "type": "array",
        "items": {
          "type": "object",
          "additionalProperties": false,
          "properties": {
            "Narration": { "type": "string" },
            "MotionPlan": {
              "type": "object",
              "additionalProperties": false,
              "properties": {
                "Workflow": {
                  "type": "string",
                  "enum": ["None", "Text", "Reference", "StartEnd", "MultiShot"]
                }
              },
              "required": ["Workflow"]
            }
          },
          "required": ["Narration", "MotionPlan"]
        }
      }
    },
    "required": ["Segments"]
  }
}
```

## Schema-To-Graph Alignment

Before finalizing:

- Every condition path must correspond to a produced schema field.
- Every downstream connection from the director must point to a schema field.
- Every schema field must be either wired, used in a condition, or intentionally published.
- Loop arrays must match blueprint loop counts.
- Fixed-index condition paths such as `ImagePlans[0]` and `ImagePlans[1]` must be produced in every segment where the condition may be evaluated.

## Conditional Fields

For inactive branches:

- use `""` for inactive prompt text fields,
- use `false` for inactive booleans,
- use `[]` for inactive collections,
- never use `"N/A"` for fields that might reach an SDK prompt.

If a condition controls graph routing, tell the director exactly how to set it.

## Director Prompt Content

Include:

- the workflow vocabulary the blueprint supports,
- narrative or informational arc,
- visual consistency anchors,
- model-workflow prompt rules from `renku-write-prompts`,
- duration and word-count constraints,
- branch-routing rules,
- examples for complex branches.

Do not put hidden reasoning fields into the output schema. Put reasoning guidance in the system prompt.

## Timing Rules

For narration or dialogue, keep a hard budget:

- about two spoken words per second for safe TTS pacing,
- less for dramatic pauses or dense technical material.

The director should be instructed to self-check text length against `SegmentDuration`.

## Final Checks

1. Validate TOML variables against YAML inputs.
2. Validate schema strictness and required fields.
3. Validate blueprint connection paths.
4. Dry-run and inspect condition paths when routing depends on director output.
