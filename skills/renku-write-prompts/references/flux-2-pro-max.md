# FLUX.2 Pro / Max

FLUX.2 Pro and Max have one of the clearest first-party prompting systems in this set. These guides should be treated as high-authority operational references for the skill.

## 1. Model fit

- Provider: Black Forest Labs
- Modality: Image generation and image editing
- Confidence: High
- Best for:
  - structured natural-language prompting
  - typography and design work
  - color-critical brand work
  - camera-aware photorealism
  - multi-reference compositing
  - automation-friendly prompting via JSON

## 2. Capability snapshot that matters to the skill

The docs emphasize these strengths:

- strong prompt adherence through explicit prompt structure
- good typography and layout rendering
- precise hex color control
- good photorealistic style simulation through camera, lens, and film references
- multi-reference editing for fashion, interiors, products, and character consistency
- optional prompt upsampling
- structured JSON prompting for complex scenes and automation

## 3. Prompting system from the source docs

### Primary formula

Source-backed formula:

`Subject + Action + Style + Context`

Meaning:

- Subject: main focus
- Action: what it is doing or how it appears
- Style: visual approach, medium, era, or aesthetic
- Context: setting, lighting, time, mood, atmosphere

### Word-order rule

The docs are explicit:

- what comes first matters more
- front-load the most important subject and action

Priority order:

- main subject
- key action
- critical style
- essential context
- secondary details

### Prompt length guidance

Source-backed bands:

- short: quick concepting
- medium: usually ideal for most production work
- long: for complex scenes where every detail contributes

Operational rule:

- longer is fine only if every sentence adds visual information

## 4. Workflow-specific prompting guidance

### A. General image generation

Use the core formula and natural language.

Do not prompt this like an old diffusion model with keyword piles.

### B. Photorealism

The docs strongly support:

- camera references
- lens references
- film-stock references
- era references

Examples of useful prompt elements:

- named camera bodies
- focal lengths
- aperture cues
- film stocks
- style eras like `2000s digicam`, `80s vintage`, or analog film

### C. Typography and graphic design

The docs explicitly cover:

- typography
- magazine layouts
- product advertisements
- white papers
- posters

Operational rules:

- quote the text
- specify placement
- specify type style
- specify text hierarchy
- specify text color when important

### D. Hex color control

This is a distinctive FLUX feature.

Operational rules:

- assign the hex code to a specific object
- do not just say “use red #FF0000 somewhere”
- gradient prompts are supported by defining start and end colors

### E. JSON structured prompting

Use JSON when:

- the workflow is automated
- many elements must stay structured
- multiple subjects and relationships must be kept separate
- you want to iterate on one part without rewriting the whole prompt

Use natural language when:

- the scene is simple
- a straightforward single image is enough

### F. Multi-reference image editing

The docs emphasize:

- describe the role of each reference image
- use it for outfits, interiors, product composites, and consistency

Operational rule:

- the prompt should explain how references combine
- the images provide the visual material
- the prompt explains composition and relationship

### G. Prompt upsampling

FLUX.2 Pro/Max can auto-enhance prompts via prompt upsampling.

Use it when:

- rapid iterations matter
- the prompt is still rough
- you want richer detail without manually writing it all

Do not rely on it when you already need tightly controlled, explicit structure.

## 5. What the sources emphasize most

- No negative prompts: describe what you want.
- Use explicit object-linked colors.
- For brand work, hex values matter.
- For photorealism, specific camera and film cues improve authenticity.
- For text, quote it and place it deliberately.
- For automation, JSON is a first-class prompt mode.

## 6. Parameters and controls that affect prompting

From the docs:

- no negative prompt support
- prompt upsampling available
- different aspect ratios for different use cases:
  - square for social and product
  - widescreen for cinematic images
  - portrait for mobile and posters
  - ultrawide for panoramas

For the skill, the practical implications are:

- never generate a negative prompt field for FLUX.2 Pro/Max
- use JSON for complex structured scenes
- attach colors to objects
- use camera/film references when photorealism matters

## 7. Failure modes and fixes

### Failure: prompt behaves like a loose mood board

Likely cause:

- no subject-action core

Fix:

- rewrite with the full `Subject + Action + Style + Context` structure

### Failure: brand colors drift

Likely cause:

- hex values were not attached to specific objects

Fix:

- specify `the logo text is color #...` or `the wall is #...`

### Failure: text is weak or misplaced

Likely cause:

- the prompt did not quote text or specify placement

Fix:

- quote the text
- specify placement
- specify typography and hierarchy

### Failure: multi-reference scene is incoherent

Likely cause:

- the prompt does not define each reference role

Fix:

- tell the model exactly which reference supplies what

### Failure: over-constrained prompt becomes muddy

Likely cause:

- too many details with no hierarchy

Fix:

- move the most important content earlier
- demote secondary details

## 8. Reusable templates for the skill

### Standard FLUX prompt

```text
[Subject], [Action], [Style], [Context].
```

Expanded:

```text
Create an image of [subject] [doing or appearing as ...], in [style], within [setting, lighting, mood, and atmosphere].
```

### Photorealistic prompt

```text
Create an image of [subject] [action or pose], shot on [camera / lens / film reference], in [setting]. Use [lighting and atmosphere].
```

### Typography prompt

```text
Create a [poster / cover / ad] with the exact text "[text]" placed [location]. Use [typography style], [color], and [layout description].
```

### Multi-reference prompt

```text
Use reference 1 for [role], reference 2 for [role], and reference 3 for [role]. Create [final scene]. Preserve [identity / material / product shape] while combining them into one coherent image.
```

### JSON recommendation

Use JSON when the skill needs deterministic structure across many objects or placements.

## 9. What the skill should ask the user

Before writing a FLUX.2 Pro/Max prompt, the skill should gather:

- subject
- action or pose
- style or era
- context and lighting
- whether text must appear
- whether brand colors must match exactly
- whether camera/film realism matters
- whether references are being used
- whether the prompt should be structured for automation

## 10. Sources and provenance

Primary:

- [FLUX.2 prompting guide](https://docs.bfl.ai/guides/prompting_guide_flux2)
- [FLUX.2 overview](https://docs.bfl.ai/flux_2)
- [FLUX.2 text-to-image](https://docs.bfl.ai/flux_2/flux2_text_to_image)
- [FLUX.2 image editing](https://docs.bfl.ai/flux_2/flux2_image_editing)

Notes on confidence:

- This guide is strongly grounded in Black Forest Labs' own docs and should be treated as a high-confidence operational reference.
