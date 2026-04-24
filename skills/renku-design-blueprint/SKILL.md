---
name: renku-design-blueprint
description: Design reusable Renku blueprints for asset-only pipelines, compositing workflows, and full video generation workflows. Use when Codex needs to create or substantially restructure a Renku workflow, choose graph shape, define loops/outputs/imports/connections, decide whether to use prompt producers or direct inputs, or turn user requirements into a reusable blueprint.
---

# Renku Design Blueprint

Design reusable Renku blueprints that are safe to validate, dry-run, and iterate in the viewer.

## Core Workflow

1. Clarify the endpoint before designing: asset-only outputs, composition/timeline output, or fully rendered final video.
2. Map the workflow shape before picking models: segments, images per segment, reference assets, audio paths, timeline/export needs, and optional branches.
3. Use `renku-pick-workflow` before choosing producer/model combinations.
4. Use `renku-author-director` when the blueprint needs an LLM prompt producer that expands high-level inputs into structured prompts.
5. Use `renku-audit-conditions` before and after writing any condition-heavy graph.
6. Use `renku-validate-run` before calling the blueprint done.

## Non-Negotiables

- Treat asset-only blueprints as first-class. Do not add timeline composers or exporters unless the user explicitly wants composition or final render.
- Treat producer outputs as internal graph values and top-level blueprint outputs as publication endpoints. Never route from a published output back into an internal producer.
- Author YAML against declared producer contracts. Never infer bindings from names or canonical IDs.
- Keep top-level inputs user-facing. Do not expose derived runtime values such as `SegmentDuration`, `MovieId`, `StorageRoot`, or `StorageBasePath` as user inputs.
- All video and audio producers must have an explicit `Duration` input declared by the producer and wired by the blueprint.
- Models belong in the input template or build inputs, not in the blueprint graph.
- Director output schemas should contain only fields that are wired or intentionally published. Do not add unused reasoning metadata.

## Blueprint Design Checklist

- Define loops from user-configurable counts: `segment`, `image`, `character`, `expert`, etc.
- Declare outputs for every artifact the user or downstream tool needs.
- Wire every declared output.
- Keep reusable workflow concerns in the blueprint; keep one-time creative content in `renku-create-video` inputs.
- Split branch-specific producers when branch conditions differ and the condition grammar cannot express the exact union safely.

## References

- Read `references/blueprint-authoring-reference.md` when implementing actual blueprint YAML.
- Read `references/requirements-to-graph-reference.md` when turning user requirements into a graph shape.
- Read `references/blueprint-patterns.md` for graph patterns and endpoints.
- Read `references/asset-only-blueprint-patterns.md` when the blueprint publishes reusable assets instead of a final render.
- Read `references/reference-bundle-patterns.md` when creating portraits, character sheets, style references, or other reusable visual anchors.
- Read `references/timeline-and-transcription-reference.md` when adding timeline composition, export, subtitles, or karaoke.
- Read `references/condition-heavy-design.md` before adding optional or conditional branches.
- Read `references/input-output-contracts.md` when defining inputs, outputs, loops, and prompt producer schemas.
