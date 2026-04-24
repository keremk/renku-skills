# Session Video Workflow

Use this when the user wants to create or iterate a specific video/build rather than design a reusable blueprint.

## Operating Model

The agent and viewer work together:

1. The agent inspects the blueprint and prepares inputs.
2. Renku generates assets or stages.
3. The viewer provides visual review.
4. The user decides what is good enough.
5. The agent pins good artifacts and regenerates weak ones.
6. The workflow continues stage by stage.

The goal is not to regenerate everything every time. The goal is controlled iteration.

## Blueprint Inspection First

Before writing prompts or scripts, inspect:

- blueprint inputs,
- input template,
- imports/producers,
- loops and counts,
- prompt producer usage,
- model configs,
- condition branches,
- outputs the viewer/downstream user will inspect.

Build a capability map:

- What media can this blueprint produce?
- Does it use direct prompt inputs or director-generated prompts?
- Does it support narration, dialogue, native audio, music, subtitles?
- Does it support references, start/end frames, multi-shot, talking head?
- Which stages should be reviewed visually before continuing?

If the user's desired video cannot be represented by the blueprint, recommend changing the blueprint instead of inventing unsupported inputs.

## Choosing Content Strategy

Use direct session-authored prompts when:

- the blueprint exposes prompt-bearing inputs,
- the user wants hands-on creative control,
- this is a one-time video and not a reusable workflow.

Use director-assisted inputs when:

- the blueprint has a strong prompt producer,
- high-level inputs are the intended control surface,
- manually filling every downstream field would duplicate the director.

## Inputs Editing

When editing `inputs.yaml`:

- preserve unrelated fields,
- preserve model configs unless changing models is intentional,
- keep arrays aligned with count inputs,
- update count inputs when adding/removing segments,
- do not add fields the blueprint cannot consume,
- use exact producer IDs in `models:`.

For prompt-bearing fields, use `renku-write-prompts` after confirming the active model/workflow.

## Stage-By-Stage Iteration

A common high-quality workflow:

1. Run only planning/reference stages.
2. Inspect generated plans, stills, references, portraits, or audio in the viewer.
3. Pin good anchors.
4. Regenerate weak anchors with targeted prompt edits.
5. Continue to motion/video stages.
6. Inspect clips.
7. Regenerate only bad clips.
8. Continue to composition/export if the blueprint includes it.

Stage-limited execution is normal. Do not treat unscheduled later layers as missing dependencies.

## Prompt Revision Loop

When an artifact is weak:

1. Identify whether the issue is prompt, model, source reference, duration, or graph mismatch.
2. Keep the successful parts of the prompt.
3. Make the smallest revision likely to fix the issue.
4. If changing model family or workflow, rewrite the prompt to that model's guidance.
5. Rerun the smallest useful scope.

Examples:

- If a reference image is ignored, clarify the reference role.
- If image-to-video drifts, anchor the source image and describe only motion/camera.
- If multi-shot compresses, reduce shot count or increase duration.
- If narration is too fast, shorten text or increase duration.

## Pinning And Regeneration

Before broad experiments:

- pin good upstream artifacts,
- note which prompts/models produced them,
- preserve them through later edits.

When regenerating:

- target the artifact or layer the user actually wants changed,
- avoid cascading rewrites unless continuity requires it,
- explain which downstream artifacts may become dirty.

## Safe Execution

Dry-run before paid generation.

Use costs-only before expensive runs.

Ask for explicit approval before invoking real model calls.

Report exactly what will run: stages, producers, models, likely cost if known, and what will be preserved.
