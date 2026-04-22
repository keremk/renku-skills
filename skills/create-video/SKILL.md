---
name: create-video
description: Create or edit videos from existing Renku blueprints by turning a vague idea into a blueprint-compatible plan, script, segment breakdown, model selection, and populated inputs.yaml. Use when users say "build a video", "edit a video", "make a documentary", "create an ad video", or want conversational help generating prompts and inputs for an existing video blueprint or build.
allowed-tools: Read, Grep, Glob, Bash, Write, Edit, AskUserQuestion
---

# Video Creation Skill

Create and edit videos from existing Renku blueprints.

This skill is the conversational planning layer that turns a rough user idea into:

- a blueprint-compatible scenario or creative brief
- a story arc or informational arc
- a script plan, if the blueprint supports narration or spoken audio
- a segment breakdown
- prompt inputs for asset producers
- model selections in `inputs.yaml`

This skill is mainly intended as a more flexible, conversational replacement for rigid prompt producers. However, some blueprints will still include prompt producers. In those cases, this skill should support them rather than fight them.

## Critical Rules

1. **Never run `renku generate` without `--dry-run`.** Full runs cost money and require explicit user approval.
2. **Do not force a story into the wrong blueprint.** If the requested experience cannot be implemented by the selected blueprint, recommend switching to a different blueprint rather than improvising around the mismatch.
3. **Inspect the blueprint deeply before planning.** Read the blueprint YAML, the input template, and the referenced producer definitions as needed. Do not assume what the blueprint supports.
4. **Only generate what the blueprint can consume.** If the blueprint has no path for narration, dialogue, talking head, music, subtitles, or text overlays, do not invent those outputs.
5. **Duration is mandatory.** `NumOfSegments` may be provided by the user or derived from blueprint and model constraints.
6. **Editing means targeted revision, not a rewrite.** When working on an existing build, preserve the current structure and only change the arc, script, prompts, or model choices that the user asked to change.
7. **Models live in the `models:` section of the input file, not the blueprint.** Respect user-specified models first. If the user says "you pick", choose suitable models based on the blueprint and the requested outcome.
8. **System inputs are special.** `Duration`, `NumOfSegments`, and `SegmentDuration` are system inputs. They are provided in `inputs.yaml` but are not declared in the blueprint `inputs:` section.
9. **Use model-specific prompt guidance when available.** For every chosen model, load the matching guide file in `references/` before writing or revising any prompt-bearing field. If no concrete guide exists yet, fall back to [prompt-guidance-sites.md](./references/prompt-guidance-sites.md) plus relevant model-picker references.
10. **Prompt-producer blueprints are supported, but handled differently.** If the blueprint still relies on a prompt producer, this skill should usually help shape and edit the high-level inputs that feed it. Do not redundantly recreate all downstream prompts unless the blueprint expects direct prompt fields or the user explicitly wants manual control.
11. **Do not make up missing story-critical information.** Ask focused follow-up questions when the missing details would materially change the script, segmentation, or generated assets.

## What This Skill Produces

Depending on the blueprint, this skill may produce some or all of the following:

- `Duration` and `NumOfSegments`
- a scenario, concept, or inquiry prompt
- recurring character or environment anchors
- a story arc or informational arc
- narration text
- spoken dialogue or voice-acting lines
- visual prompts for image or video producers
- music direction
- subtitle or overlay text inputs
- model selections in the `models:` section

The final artifact of the skill is an updated `inputs.yaml` for a build, plus any conversational planning needed to get there.

## Prerequisites

1. Check whether `~/.config/renku/cli-config.json` exists.
2. If it does not exist, ask the user to initialize Renku before continuing.
3. Read the config to find the workspace and catalog locations.
4. Determine the target blueprint:
   - If the user named a blueprint, locate it.
   - If not, ask for the blueprint name.
   - If no blueprint is found, exit with a message telling the user to create or choose a blueprint first.

## Workflow

### Step 0: Determine the Operating Mode

There are two top-level cases:

1. **New build**
2. **Edit existing build**

If the user is creating a new build:

```bash
renku new:video --blueprint <blueprint-name>
```

This creates a build folder and an `inputs.yaml` file that the rest of the workflow will populate.

If the user is editing an existing build:

- locate the build by movie ID or build folder
- read the existing `inputs.yaml`
- treat the current build as the source of truth for the existing arc, script, segment plan, and models

If the user's request does not clearly indicate whether they are creating or editing, ask.

### Step 1: Inspect the Blueprint Before Asking Creative Questions

Before generating any story, script, or prompts, inspect the blueprint and understand what it can actually do.

Read as much of the following as needed:

- the blueprint YAML
- the build's `inputs.yaml` or the blueprint `input-template.yaml`
- referenced producer YAML files
- prompt producer files, if the blueprint includes them

Build a capability map covering:

- whether the blueprint generates images, videos, audio, music, subtitles, or talking head assets
- whether it supports narration, spoken in-video dialogue, both, or neither
- whether it expects per-segment prompts, high-level inquiry inputs, or prompt-producer outputs
- whether it uses continuity patterns such as last-frame chaining, image-to-video, or multi-shot cut scenes
- whether it has segment-level loops, image-per-segment loops, or clip-level loops
- what producer inputs must ultimately be filled in the `inputs.yaml`

**Goal:** understand what story forms are implementable with this blueprint.

Examples:

- If the blueprint has TTS producers but no talking-head or native-audio video path, the skill should produce narration but not in-video dialogue.
- If the blueprint only supports image generation plus Ken Burns motion, the skill should write image prompts and narration, not true video-scene action prompts.
- If the blueprint still has a prompt producer, the skill should determine whether it is better to guide the user through high-level inputs rather than manually author every downstream prompt.

If the user's desired outcome does not fit the blueprint, recommend switching to a different blueprint.

### Step 2: Choose the Interaction Strategy

After inspecting the blueprint, decide which of these modes applies.

#### Mode A: Conversational-director mode

Use this when:

- the blueprint expects direct prompt-like inputs for asset producers, or
- the user wants hands-on conversational control over the prompts and script, or
- the prompt producer is absent, minimal, or not the preferred workflow

In this mode, this skill does the high-level planning itself and writes the downstream prompt-bearing inputs.

#### Mode B: Prompt-producer-assisted mode

Use this when:

- the blueprint still relies on a prompt producer, and
- the prompt producer already handles the downstream per-segment prompt expansion well

In this mode, this skill focuses on:

- helping the user define the scenario, arc, and script inputs
- improving the high-level fields that feed the prompt producer
- making limited edits instead of duplicating the prompt producer's work

This skill is primarily optimized for Mode A, but it must support Mode B.

### Step 3: Gather the Right Inputs From the User

Extract whatever is already present in the user request, then ask only for missing details that matter.

Always capture:

- `Duration`
- the topic, concept, or intended outcome

Usually capture:

- audience
- tone
- visual style
- language
- aspect ratio or target platform
- user-provided references or assets
- preferred models or providers

Only capture if the blueprint supports them:

- narration style or narrator tone
- spoken dialogue or voice acting
- background music direction
- subtitles or text overlays
- character descriptions
- product descriptions
- number of images per segment
- cut scenes per segment

Do **not** assume that every video needs characters. Some documentaries, explainers, or product videos may use only narration plus visuals.

### Step 4: Build a Blueprint-Compatible Story Package

Turn the user's vague idea into a planning package that the blueprint can actually realize.

This package may include:

- the scenario or premise
- the purpose of the video
- recurring environment anchors
- recurring character anchors, if characters exist
- the story arc or informational arc
- tone and pacing
- script strategy:
  - narration only
  - spoken dialogue only
  - both narration and spoken dialogue
  - visual-only beat outline when no audio path exists

The story package must be **implementable with the blueprint**.

Examples:

- If the blueprint supports narration but not voice acting, write a narration-led structure.
- If the blueprint supports character-led video with audio, produce dialogue or spoken lines where appropriate.
- If the blueprint has no audio path at all, still create an internal beat-by-beat visual plan, but do not invent spoken text fields that the blueprint cannot consume.

For edits:

- infer the existing story package from the current `inputs.yaml`
- keep the current structure unless the user asked for a broader change
- treat edits as revisions, not as a full re-plan

### Step 5: Determine Segment Count and Segment Roles

Duration drives the plan. Segment count may come from the user or be derived.

If the user already gave `NumOfSegments`, use it if it is compatible with the blueprint and likely model limits.

If not, derive it from:

- total duration
- the clip length limits of the likely video model or producer
- the blueprint structure
- pacing needs

Remember that current video models commonly generate clips in the rough range of 4 to 15 seconds. This matters when deciding whether a story should be broken into more or fewer segments.

For each segment, define:

- segment purpose in the arc
- duration
- segment type
  - image narration
  - video narration
  - talking head
  - product shot
  - transition segment
  - other blueprint-specific types
- required assets
- continuity requirements
- script or spoken lines for that segment, if applicable

Do not segment blindly. Segment boundaries should match both the story flow and the blueprint's production structure.

### Step 6: Pick or Confirm Models

Model selection happens after the blueprint and segment plan are understood.

Rules:

1. If the user specified a model or provider, respect it if the blueprint can support it.
2. If the user said "you pick", choose models based on:
   - whether native audio is needed
   - whether image or video generation is needed
   - duration requirements
   - reference consistency requirements
   - multi-shot or cut-scene needs
   - cost versus quality
3. Update the `models:` section in the `inputs.yaml`.

Before writing prompts for a chosen model:

- read the exact matching prompt guide in this skill's `references/` folder
- otherwise use [prompt-guidance-sites.md](./references/prompt-guidance-sites.md) to find the best source
- supplement with `model-picker` references when needed
- read the guide sections in this order:
  1. `Model fit`
  2. `Capability snapshot that matters to the skill`
  3. `Prompting system from the source docs`
  4. `Workflow-specific prompting guidance`
  5. `Failure modes and fixes`
  6. `Reusable templates for the skill`
  7. `What the skill should ask the user`

Current guide mapping:

- Nano Banana 2 / Nano Banana Pro -> [nano-banana.md](./references/nano-banana.md)
- Seedream 5.0 Lite -> [seedream-5-lite.md](./references/seedream-5-lite.md)
- FLUX.2 Pro / Max -> [flux-2-pro-max.md](./references/flux-2-pro-max.md)
- FLUX.2 Klein -> [flux-2-klein.md](./references/flux-2-klein.md)
- Grok Imagine Image -> [grok-imagine-image.md](./references/grok-imagine-image.md)
- Qwen-Image-2512 -> [qwen-image-2512.md](./references/qwen-image-2512.md)
- Seedance 1.5 Pro -> [seedance-1-5.md](./references/seedance-1-5.md)
- Veo 3.1 -> [veo-3-1.md](./references/veo-3-1.md)
- Grok Imagine Video -> [grok-imagine-video.md](./references/grok-imagine-video.md)
- Kling VIDEO 3.0 -> [kling-3.md](./references/kling-3.md)
- LTX-2.3 -> [ltx-2-3.md](./references/ltx-2-3.md)
- Wan 2.7 -> [wan-2-7.md](./references/wan-2-7.md)

If the user specified a close model variant that belongs to one of these families, use the nearest family guide unless a more exact guide exists.

### Step 7: Generate the Script and Prompt Inputs

Now generate the content that the blueprint actually needs.

Depending on the blueprint, this may include:

- per-segment image prompts
- per-segment video prompts
- reference-image instructions
- narration text
- spoken dialogue or voice-acting lines
- music direction
- subtitle or overlay text

Rules for this step:

- Generate only the fields the blueprint can consume.
- Keep prompts aligned with the chosen model's best practices.
- Before writing each prompt-bearing field, check the matching model guide and follow:
  - the source-backed prompt formula for that model
  - the workflow-specific rules for the active mode such as text-to-image, editing, text-to-video, image-to-video, multi-shot, typography, or audio-aware generation
  - the listed failure-mode fixes when a prompt needs revision
  - the reusable template only after you have matched it to the right workflow
- Keep recurring anchors consistent across segments.
- If narration or spoken text is used, make it fit the segment duration.
- If the blueprint still uses a prompt producer, generate only its upstream inputs unless the user explicitly wants manual downstream prompt control.

When generating text for spoken audio:

- narration should match the segment purpose and available duration
- spoken dialogue should feel natural for in-video delivery
- do not write audio content if the blueprint has no path for it

### Step 8: Write `inputs.yaml`

Populate the build's `inputs.yaml` with:

- system inputs such as `Duration` and `NumOfSegments`
- user-facing input values required by the blueprint
- any per-segment arrays or grouped values
- the `models:` section

Important details:

- Keep arrays aligned with blueprint loop structure.
- Preserve existing user content when editing.
- Do not rewrite unaffected segments in an edit unless the requested change has cascading effects.
- If the blueprint expects grouped arrays or count inputs, keep them synchronized.

### Step 9: Validate and Preview Safely

After updating the inputs:

1. Validate the blueprint if needed:

```bash
renku blueprints:validate <path-to-blueprint.yaml>
```

2. Test the run structure without invoking paid model calls:

```bash
renku generate --blueprint=<path> --inputs=<path> --dry-run
```

3. If useful, estimate cost:

```bash
renku generate --blueprint=<path> --inputs=<path> --costs-only
```

Do not run a full paid generation without explicit user approval.

## Editing Existing Builds

When the user is editing an existing build:

1. Read the current `inputs.yaml`.
2. Infer the current concept, arc, segment plan, and model choices from it.
3. Ask what should change.
4. Preserve everything outside the requested scope.

Typical edit scopes:

- tweak the story angle
- rewrite narration
- change one segment's visuals
- swap models
- adjust duration or segment count
- change tone, style, or audience

Default editing behavior:

- keep the existing structure
- make targeted revisions
- avoid drastic changes unless explicitly requested

## How to Think About Story Planning

This skill should not jump directly from "user idea" to "asset prompts."

The planning order is:

1. blueprint inspection
2. capability-aware story package
3. segment breakdown
4. model selection
5. prompt and script generation
6. `inputs.yaml` update

That ordering matters because the blueprint determines what kinds of story and prompts are valid.

## Reference Documents

- [Prompt Guidance Sites](./references/prompt-guidance-sites.md) — model prompt source map
- [Nano Banana](./references/nano-banana.md) — example per-model prompt guide
- [Prompt Guide Template](./references/prompt-guide-template.md) — template for future model guides
- [Create Blueprint Skill](../create-blueprint/SKILL.md) — blueprint design workflow and terminology
- [Comprehensive Blueprint Guide](../create-blueprint/references/comprehensive-blueprint-guide.md) — blueprint structure, loops, inputs, and connections
- [Requirement Examples](../create-blueprint/references/requirement-examples.md) — example blueprint-to-story mappings
- [Common Errors Guide](../create-blueprint/references/common-errors-guide.md) — validation issues and fixes
