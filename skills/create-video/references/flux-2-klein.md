# FLUX.2 Klein

FLUX.2 Klein is not just “smaller FLUX.” Its first-party prompt guide changes the prompting stance significantly: prose matters more, lighting matters more, and prompt upsampling is absent. This guide should be used as its own operational reference.

## 1. Model fit

- Provider: Black Forest Labs
- Modality: Image generation and editing
- Confidence: High
- Best for:
  - prose-driven scene prompting
  - lighting-sensitive stills
  - controlled image editing
  - multi-reference composition
  - workflows where descriptive prompting is acceptable

## 2. Capability snapshot that matters to the skill

The key model-specific points are:

- it works best when prompted like scene prose, not a search query
- lighting has outsized influence on quality
- word order matters
- prompt upsampling is not available
- for edits, reference images provide the visual base and the prompt should describe the transformation

## 3. Prompting system from the source docs

### Primary structure

Source-backed formula:

`Subject -> Setting -> Details -> Lighting -> Atmosphere`

This is different from FLUX.2 Pro/Max and should be treated differently by the skill.

### Write like a novelist

The docs explicitly contrast:

- flowing prose
- versus keyword piles

Operational rule:

- write full descriptive sentences
- let the prompt establish relationships between subject, setting, and light

### Lighting is the highest-leverage element

The docs are unusually strong on this point.

What to describe:

- light source
- light quality
- light direction
- light temperature
- how the light interacts with surfaces

For Klein, the skill should not reduce lighting to a generic phrase like `nice lighting`.

### Word-order rule

Priority:

- main subject
- key action
- style
- context
- secondary details

### Prompt length

Source-backed bands:

- short for quick concepts
- medium for most production use
- long for complex editorial work

Operational rule:

- longer prompts are fine if they continue to add visual information

### Style and mood annotations

The docs explicitly support adding:

- `Style: ...`
- `Mood: ...`

at the end of the scene description for more consistent aesthetics.

## 4. Workflow-specific prompting guidance

### A. General scene generation

Use prose and the Klein structure:

`Subject -> Setting -> Details -> Lighting -> Atmosphere`

### B. Single-image editing

The docs frame editing around transformation patterns such as:

- style transfer
- object swap
- element replacement
- adding elements
- environmental changes

Operational rule:

- the base image supplies the visual details
- the prompt describes what changes

### C. Multi-reference editing

The docs explicitly say:

- specify the role of each reference
- keep the prompt about relationships and context
- let the references carry the detailed visual material

### D. Style consistency work

If the skill needs multiple results with similar aesthetic treatment:

- end the prompt with explicit style and mood annotations
- reuse those annotations consistently

## 5. What the sources emphasize most

- prose over keywords
- strong lighting detail
- front-loaded subject and action
- specific transformations for edits
- reference-role clarity in multi-reference workflows
- no prompt upsampling, so descriptiveness matters more

## 6. Parameters and model-level implications

The main prompt-level implications are:

- what you write is what you get
- no automatic prompt enhancement
- lighting detail is especially valuable
- transformations should be concrete and target-state-based

For the skill:

- spend more tokens on scene prose and lighting than you would for FLUX.2 Pro/Max
- do not assume shorthand prompts will be enhanced automatically

## 7. Failure modes and fixes

### Failure: output feels shallow or generic

Likely cause:

- prompt written as keywords instead of prose

Fix:

- rewrite as a flowing scene description

### Failure: lighting looks dull or wrong

Likely cause:

- lighting is underspecified

Fix:

- specify source, quality, direction, and temperature

### Failure: edit request produces weak transformation

Likely cause:

- prompt says “improve” or “make better”

Fix:

- state the exact transformation and target result

### Failure: multi-reference edit feels confused

Likely cause:

- no reference-role explanation

Fix:

- state what each image contributes and what the output should combine

## 8. Reusable templates for the skill

### Standard Klein prompt

```text
[Subject]. [Setting]. [Details]. [Lighting]. [Atmosphere].
```

Expanded:

```text
A [subject] in [setting], with [specific details]. [Detailed lighting description]. The atmosphere is [mood or tone].
```

### Style/mood variant

```text
[Scene description]. Style: [style]. Mood: [mood].
```

### Single-image edit

```text
Change [specific element] to [target result]. Keep the input image as the visual foundation.
```

### Multi-reference edit

```text
Use image 1 for [role] and image 2 for [role]. Create [target result]. Let the references provide the visual details while applying [transformation or combination].
```

## 9. What the skill should ask the user

Before writing a FLUX.2 Klein prompt, the skill should gather:

- main subject
- setting
- key details
- specific lighting plan
- atmosphere or mood
- whether this is generation or editing
- what exactly should change in an edit
- what each reference image is for

## 10. Sources and provenance

Primary:

- [FLUX.2 Klein prompting guide](https://docs.bfl.ai/guides/prompting_guide_flux2_klein)
- [FLUX.2 Klein training docs](https://docs.bfl.ai/flux_2/flux2_klein_training)
- [FLUX.2 overview](https://docs.bfl.ai/flux_2)

Notes on confidence:

- This guide is strongly grounded in Black Forest Labs' own prompt system for Klein and should be treated as high-confidence.
