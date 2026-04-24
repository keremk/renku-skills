# Prompt Guide Template

Use this template when creating a per-model prompt guide for `renku-write-prompts`.

This is not a runtime prompt guide. It is the maintenance template for building one guide per model in a consistent format.

## Contents

- [Why this template exists](#why-this-template-exists)
- [Template design rules](#template-design-rules)
- [Shared structure vs. model-specific variance](#shared-structure-vs-model-specific-variance)
- [What the skill needs from each guide](#what-the-skill-needs-from-each-guide)
- [Recommended authoring format](#recommended-authoring-format)
- [Image model add-on sections](#image-model-add-on-sections)
- [Video model add-on sections](#video-model-add-on-sections)
- [Authoring guidance for consistency](#authoring-guidance-for-consistency)
- [Recommended file naming](#recommended-file-naming)
- [Decision: do we need different templates for image and video?](#decision-do-we-need-different-templates-for-image-and-video)

## Why this template exists

- The skill needs model-specific prompting advice, not generic prompt-writing tips.
- The later per-model files should be easy for Codex to scan quickly while generating prompts.
- Different models have different strengths, controls, and failure modes, so each guide needs consistent structure plus room for model-specific nuance.

## Template design rules

- Keep each per-model guide practical. Prefer direct recommendations over long background.
- Separate sourced facts from inferences. If a recommendation is inferred from examples or testing rather than stated by the vendor, label it clearly.
- Prefer official vendor guidance first. Use secondary sources only to fill gaps or add clearer examples.
- Include only sections that will help the skill generate better prompts.
- Use the same heading order across models so the skill can find the right section quickly.

## Shared structure vs. model-specific variance

We should use one shared template, with a few required differences between image and video models.

### Shared sections for all models

These should appear in every per-model guide:

- `Model snapshot`
- `When to use this model`
- `Supported workflows`
- `Prompt formula`
- `Best practices`
- `Common failure modes`
- `Prompt patterns`
- `Skill extraction notes`
- `Sources`

### Image-only sections

Add these only for image models:

- `Composition and framing guidance`
- `Reference image usage`
- `Editing and inpainting guidance`
- `Text rendering and typography`
- `Aspect ratio and resolution notes`
- `Negative prompt guidance`, but only if the model actually benefits from negative prompts

### Video-only sections

Add these only for video models:

- `Motion and action guidance`
- `Camera direction`
- `Temporal consistency`
- `Shot structure`
- `Audio, dialogue, and sound`, if the model supports native audio or voice
- `Duration and pacing`
- `Image-to-video or reference-video guidance`, if supported

## What the skill needs from each guide

Each per-model guide should help the skill answer these questions fast:

- What prompt structure works best for this model?
- What details matter most for quality?
- What details should be avoided because they confuse the model?
- Does the model want short prompts, long prompts, or structured prompts?
- Does it respond well to cinematic language, photography language, dialogue, shot lists, or reference images?
- What input modes are supported: text-to-image, image edit, text-to-video, image-to-video, multi-shot, audio, reference character, and so on?
- What should the skill ask the user for before writing the final prompt?
- What are one or two reliable prompt patterns the skill can reuse?

## Recommended authoring format

Use this exact structure when creating a model guide.

```md
# {{ Model Name }}

## Model snapshot

- Model: `{{ exact model name }}`
- Provider: `{{ provider }}`
- Modality: `image` | `video`
- Best for: `{{ short summary }}`
- Weak at: `{{ short summary }}`
- Prompt style: `short` | `medium-detail` | `highly structured`
- Confidence: `high` | `medium` | `low`
  - Use `high` only when strong vendor guidance exists.

## When to use this model

- Use it when: `{{ strongest use cases }}`
- Avoid it when: `{{ weak use cases or unsupported cases }}`
- Prefer another model when: `{{ cases where another model family is better }}`

## Supported workflows

- `{{ workflow 1 }}`
- `{{ workflow 2 }}`
- `{{ workflow 3 }}`

If relevant, call out:

- Text-to-image
- Image editing
- Style transfer
- Text-to-video
- Image-to-video
- Multi-shot generation
- Reference character / subject consistency
- Native audio / dialogue

## Prompt formula

### Canonical formula

`{{ simplest reliable prompt formula for this model }}`

### Expanded formula

`{{ richer version of the formula when more control is needed }}`

### Prompt length guidance

- Best prompt length: `{{ short / medium / long }}`.
- Structure preference: `{{ prose / labeled sections / shot list / keyword-plus-sentence hybrid }}`.
- Notes: `{{ how literal or flexible the model is }}`.

## Best practices

- `{{ best practice 1 }}`
- `{{ best practice 2 }}`
- `{{ best practice 3 }}`
- `{{ best practice 4 }}`
- `{{ optional best practice 5 }}`

For each point, prefer concrete advice like:

- name the subject before style
- describe motion explicitly
- quote exact text for typography
- specify what must remain unchanged during edits
- keep one shot per sentence

## Common failure modes

- Failure: `{{ common problem }}`
  - Likely cause: `{{ why it happens }}`
  - Fix: `{{ how to rewrite the prompt }}`
- Failure: `{{ another problem }}`
  - Likely cause: `{{ why it happens }}`
  - Fix: `{{ how to rewrite the prompt }}`

## Prompt patterns

### Fast pattern

Use when the user gives limited detail and the skill needs a strong default.

```text
{{ short reusable prompt pattern }}
```

### Controlled pattern

Use when the user wants more precision.

```text
{{ structured reusable prompt pattern }}
```

### Example prompts

#### Example 1: `{{ common use case }}`

```text
{{ example prompt }}
```

Why it works:

- `{{ reason 1 }}`
- `{{ reason 2 }}`

#### Example 2: `{{ another use case }}`

```text
{{ example prompt }}
```

Why it works:

- `{{ reason 1 }}`
- `{{ reason 2 }}`

## Skill extraction notes

This section is specifically for `renku-write-prompts`.

- Ask the user for: `{{ highest-value missing inputs }}`
- Safe defaults:
  - `{{ default 1 }}`
  - `{{ default 2 }}`
- Avoid assuming:
  - `{{ detail 1 }}`
  - `{{ detail 2 }}`
- If the user is vague, prioritize:
  - `{{ priority 1 }}`
  - `{{ priority 2 }}`
- Prompt assembly order:
  1. `{{ first ingredient }}`
  2. `{{ second ingredient }}`
  3. `{{ third ingredient }}`
  4. `{{ fourth ingredient }}`

## Sources

### Primary

- `{{ official source 1 }}`
- `{{ official source 2 }}`

### Supplemental

- `{{ secondary source 1 }}`
- `{{ secondary source 2 }}`

### Notes on confidence

- `{{ what is directly stated by sources }}`
- `{{ what is inferred from examples or ecosystem guidance }}`
```

## Image model add-on sections

Add the following sections after `Common failure modes` for image models.

```md
## Composition and framing guidance

- `{{ how this model responds to framing language }}`
- `{{ whether photography terms help }}`
- `{{ whether composition should be explicit or implied }}`

## Reference image usage

- `{{ whether multiple references are supported }}`
- `{{ how to describe relationship between references and output }}`
- `{{ what should stay fixed versus change }}`

## Editing and inpainting guidance

- `{{ whether edits should be phrased as direct commands }}`
- `{{ whether preservation language is important }}`
- `{{ whether semantic masking or region-specific instructions work }}`

## Text rendering and typography

- `{{ whether exact quoted text improves reliability }}`
- `{{ whether font/style descriptions help }}`
- `{{ any multilingual or layout strengths }}`

## Aspect ratio and resolution notes

- `{{ preferred or supported aspect ratios }}`
- `{{ when to choose portrait, landscape, square }}`
- `{{ any known sharpness or layout tradeoffs }}`

## Negative prompt guidance

- Use negative prompts: `yes` | `no` | `sometimes`
- Guidance:
  - `{{ whether negative prompts help this model }}`
  - `{{ if not, say to use positive framing instead }}`
```

## Video model add-on sections

Add the following sections after `Common failure modes` for video models.

```md
## Motion and action guidance

- `{{ how explicitly motion should be described }}`
- `{{ whether verbs, speed, and physical action matter }}`
- `{{ whether background motion should be specified }}`

## Camera direction

- `{{ whether the model follows cinematic camera language well }}`
- `{{ useful terms: push-in, dolly, handheld, overhead, fixed camera, etc. }}`
- `{{ whether one camera move per shot is safer than many }}`

## Temporal consistency

- `{{ how to preserve subject appearance and scene continuity }}`
- `{{ whether to repeat anchor details across shots }}`
- `{{ how the model handles transitions or shot changes }}`

## Shot structure

- Use shot list prompting: `yes` | `no` | `sometimes`
- Guidance:
  - `{{ whether numbered shots help }}`
  - `{{ whether timestamps help }}`
  - `{{ whether multi-shot prompting is native or simulated }}`

## Audio, dialogue, and sound

- Native audio support: `yes` | `no`
- Dialogue support: `yes` | `no`
- Guidance:
  - `{{ how to write spoken lines, tone, accent, or ambience }}`
  - `{{ whether quoted dialogue works best }}`
  - `{{ how much sound detail is worth including }}`

## Duration and pacing

- Typical clip duration: `{{ supported range }}`
- Best pacing advice:
  - `{{ avoid too many events in short clips }}`
  - `{{ align action count with duration }}`

## Image-to-video or reference-video guidance

- Supported modes: `{{ I2V / start frame / end frame / character reference / element reference }}`.
- Guidance:
  - `{{ what motion to describe versus what the image already defines }}`
  - `{{ how to keep the camera and subject stable }}`
```

## Authoring guidance for consistency

When we create the actual per-model guides, keep these rules:

- Start with what the model is best at, not a generic overview.
- Turn vague source material into direct rules the skill can apply.
- Include at least two reusable prompt patterns per model.
- Include at least two failure modes with rewrites.
- Keep the `Skill extraction notes` section concise and operational.
- If a model lacks solid official guidance, say so directly and lower confidence.
- Do not force sections that are irrelevant. Mark them `Not applicable` when needed.

## Recommended file naming

Use stable, kebab-case filenames such as:

- `nano-banana-2.md`
- `veo-3-1.md`
- `kling-3.md`
- `wan-2-7.md`

## Decision: do we need different templates for image and video?

Not separate files.

We should keep one shared template because:

- the skill benefits from consistent section order across all models
- most core sections are shared
- we only need a small number of modality-specific sections

We do need modality-specific variance inside the template because:

- image models care more about composition, reference images, editing preservation, typography, and negative prompting behavior
- video models care more about motion verbs, camera language, shot structure, pacing, continuity, and audio support

So the right approach is:

- one `prompt-guide-template.md`
- one common base structure
- one image add-on block
- one video add-on block
