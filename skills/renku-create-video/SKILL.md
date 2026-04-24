---
name: renku-create-video
description: Create or iterate a one-time Renku video/build with an agent and the viewer. Use when the user wants to make or edit a specific video from an existing blueprint, populate inputs.yaml, generate session-time prompts instead of reusable prompt producers, run stage-by-stage, inspect viewer artifacts, pin good outputs, regenerate weak artifacts, or steer models/prompts interactively.
---

# Renku Create Video

Help the user create or edit a specific video/build using Renku, the agent, and the viewer together.

## Operating Modes

- New build: inspect the chosen blueprint, create/populate inputs, validate, dry-run, then run only with explicit approval.
- Existing build: read current inputs and build state, preserve what is working, and make targeted changes.
- Visual iteration: use the viewer to inspect artifacts, pin good outputs, regenerate weak outputs, and continue stage by stage.

## Workflow

1. Inspect the blueprint before writing creative content. Build a capability map of supported media, loops, branches, and prompt inputs.
2. Gather only missing user details that materially affect the video.
3. Use `renku-pick-workflow` when model or workflow selection is open.
4. Use `renku-write-prompts` before writing prompt-bearing inputs.
5. Populate or edit `inputs.yaml` without changing fields unrelated to the requested edit.
6. Use `renku-validate-run` for validation, dry-run, costs-only, and stage checks.
7. For real generation, proceed stage by stage when useful: generate early planning/reference assets, inspect in viewer, pin/regen, then continue.

## Viewer-Aware Rules

- Treat the viewer as the visual QA surface, not an afterthought.
- Prefer targeted regeneration over broad rewrites.
- Preserve pinned artifacts unless the user explicitly asks to replace them.
- If a model swap changes prompt requirements, revise prompts before rerunning.
- If the blueprint cannot support the requested creative direction, recommend a blueprint change instead of inventing unsupported inputs.

## References

- Read `references/session-video-workflow.md` when running a real one-time video/build session with the viewer.
- Read `references/viewer-iteration-loop.md` for stage-by-stage agent + viewer workflow.
- Read `references/inputs-yaml-authoring.md` before editing build inputs.
- Read `references/artifact-pinning-regeneration.md` before changing existing builds.
