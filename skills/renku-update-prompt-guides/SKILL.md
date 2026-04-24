---
name: renku-update-prompt-guides
description: Maintain Renku model-specific prompt guide references. Use when Codex needs to add a new model prompt guide, refresh Seedance/Kling/Veo/Wan/LTX/image model guidance from vendor docs, update source provenance, apply the prompt guide template, or keep renku-write-prompts references current as models and producer contracts change.
---

# Renku Update Prompt Guides

Maintain the model-specific prompt guides used by `renku-write-prompts`.

This skill is for upkeep, not normal prompt generation. Use `renku-write-prompts` when writing prompts for a user video; use this skill when adding, refreshing, or auditing the guide library itself.

## Workflow

1. Identify the model family, exact model variants, provider, and Renku producer workflows affected.
2. Read `references/prompt-guidance-sites.md` to check existing source coverage and known gaps.
3. Prefer official vendor docs and first-party prompt guides. Use secondary guides only to fill gaps or clarify practice.
4. Inspect current Renku producer contracts and mappings before writing capabilities into a guide.
5. Create or update the model guide in `../renku-write-prompts/references/` using `references/prompt-guide-template.md`.
6. Update `references/prompt-guidance-sites.md` with source provenance, confidence, and guide filename.
7. Run the quality checklist in `references/model-guide-quality-checklist.md`.

## Rules

- Separate vendor-supported capability from Renku-exposed workflow. If a vendor supports a feature but the current producer contract does not expose it, call that out.
- Mark inferred guidance clearly when it comes from examples, not vendor statements.
- Keep per-model guides practical for prompt writing; avoid marketing summaries.
- Preserve source links and last-refreshed dates.
- Do not remove an existing guide unless the model family is intentionally retired.

## References

- Read `references/prompt-guidance-sites.md` for the source map and guide inventory.
- Read `references/prompt-guide-template.md` before creating or restructuring a model guide.
- Read `references/model-guide-quality-checklist.md` before finishing an update.
