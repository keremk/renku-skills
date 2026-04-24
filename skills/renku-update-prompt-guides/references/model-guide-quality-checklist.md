# Model Guide Quality Checklist

Use this before finishing a new or refreshed guide in `../renku-write-prompts/references/`.

## Source Quality

- Official vendor docs or first-party prompt guide checked first.
- Secondary sources used only when official guidance is thin or unclear.
- Source links are listed in the guide and in `prompt-guidance-sites.md`.
- Confidence level reflects source quality.
- Last-refreshed date is updated in `prompt-guidance-sites.md` when sources are reviewed.

## Renku Contract Grounding

- Current catalog producer mappings were inspected.
- Exact provider/model IDs are not invented from memory.
- The guide distinguishes vendor capability from Renku-exposed capability.
- Unsupported producer-contract features are called out as unavailable for Renku workflows.

## Guide Structure

- Model fit / snapshot is clear.
- Supported workflows are listed.
- Prompt formula is concrete.
- Workflow-specific guidance covers the model's important modes.
- Failure modes include likely cause and rewrite fix.
- Reusable prompt patterns are included.
- The guide says what `renku-write-prompts` should ask the user.
- Sources and provenance are present.

## Practicality

- Advice is actionable, not marketing copy.
- Examples are short enough to adapt.
- Prompts reflect producer inputs actually available in Renku.
- Native audio, references, multi-shot, duration, and image anchoring are discussed when relevant.
