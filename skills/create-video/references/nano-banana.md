# Nano Banana

This guide covers both `Nano Banana 2` and `Nano Banana Pro`.

Google's primary prompt guidance is shared across both models, so the prompting system is mostly the same. The differences that matter to the `create-video` skill are mainly capability limits, context size, and aspect-ratio/resolution options.

## 1. Model fit

- Provider: Google
- Modality: Image generation and image editing
- Confidence: High
- Best for:
  - direct text-to-image prompting
  - conversational multi-turn editing
  - reference-driven composition
  - typography, diagrams, posters, and localized graphics
  - web-grounded image generation
- Use this family when the workflow needs:
  - clear prompt formulas
  - high-quality editing
  - good text rendering
  - reference-driven scene composition
  - real-world or time-sensitive visual content

## 2. Capability snapshot that matters to the skill

### Shared capabilities

- Both models accept text plus images.
- Both output text and images.
- Both support multi-turn image editing.
- Both support grounding with Google Search.
- Both support up to 14 reference images.
- Both support image generation and image editing.
- Both support common aspect ratios such as `1:1`, `3:2`, `2:3`, `3:4`, `4:3`, `4:5`, `5:4`, `9:16`, `16:9`, and `21:9`.
- Both support multilingual text rendering and localization workflows.

### Nano Banana 2 differences

- Higher input context window than Pro.
- Adds extra narrow and wide aspect ratios such as `1:4`, `4:1`, `1:8`, and `8:1`.
- Adds smaller `512px` generation in addition to higher resolutions.
- Google positions Nano Banana 2 as especially strong for web-grounded and time-sensitive visual generation.

### Nano Banana Pro differences

- Smaller context window than Nano Banana 2.
- Fewer supported aspect ratios than Nano Banana 2.
- Still follows the same core prompting system.

## 3. Prompting system from the source docs

Google's guide breaks the work into separate prompting frameworks. The skill should choose the framework based on the job instead of using one generic prompt shape for everything.

### A. Text-to-image without references

Use when the model is generating from scratch.

Source-backed formula:

`Subject + Action + Location or context + Composition + Style`

What this means operationally:

- Subject: who or what the image is about
- Action: what the subject is doing or how it is posed
- Location/context: where it is happening
- Composition: shot type, framing, or camera angle
- Style: photographic, editorial, artistic, lighting, finish

### B. Multimodal generation with references

Use when the user provides one or more reference images.

Source-backed formula:

`Reference images + Relationship instruction + New scenario`

What this means operationally:

- Tell the model what each reference contributes.
- State how the references should influence the output.
- Then describe the final scene or new composition.

This is important for:

- character consistency
- product placement into new environments
- design transfer from sketch or material sample
- combining multiple reference objects into one scene

### C. Conversational editing without new references

Use when the user wants to refine or alter an existing image.

Source-backed edit mindset:

- focus on what changes
- explicitly state what stays the same
- rely on semantic masking through text when editing a local region

The key operational rule:

- For edits, the prompt should not read like a full regeneration brief.
- It should read like a change request plus preservation instructions.

### D. Editing with new references

Use when the user wants:

- composition changes
- new objects inserted into the base image
- style transfer
- color transfer

The prompt should:

- identify the base image
- identify the new reference role
- explain the transformation
- preserve what must remain unchanged

### E. Web-grounded image generation

Use when the user needs current or location-specific information in the visual.

Source-backed formula:

`Source or search request + Analytical task + Visual translation`

Operationally:

- ask the model to retrieve current information
- specify how that information should change the scene
- then specify the visual output format

This is not a normal fictional-scene prompt. It is a retrieval-plus-visualization prompt.

### F. Text rendering and localization

Use when visible text matters.

Source-backed rules:

- quote the exact text
- specify the typography style or font character
- specify the target language when localizing
- for difficult text tasks, use a text-first workflow:
  - first generate the text concept conversationally
  - then ask for the image with that text

## 4. What the sources emphasize most

- Be specific about subject, lighting, and composition.
- Use positive framing whenever possible.
- Start with a strong verb that states the operation:
  - `Create`
  - `Generate`
  - `Edit`
  - `Transform`
  - `Remove`
- Use photographic or cinematic framing language like:
  - `low angle`
  - `aerial view`
  - `medium shot`
  - `center-framed`
- Iterate conversationally instead of trying to get everything perfect in one pass.
- For edits, explicitly preserve what must stay unchanged.
- For text rendering, quote the text and describe the type style.

## 5. Workflow-specific guidance for the skill

### When generating storyboard frames or stills

- Use the text-to-image or multimodal formula.
- Keep the story beat visually explicit.
- Put composition and lighting in the prompt because those matter downstream when segment prompts need continuity.

### When generating character references

- Use reference images when available.
- Repeat the same identity description across related prompts.
- Use the multimodal reference formula instead of rewriting every visual detail from scratch.

### When editing a frame between versions

- Write only the change and the preservation rules.
- If the user wants a local edit, describe the affected region semantically.

### When generating posters, diagrams, or overlays

- Use the text-rendering rules.
- Keep text short when possible.
- Always quote exact visible copy.
- Specify placement and font character.

### When current information matters

- Use the web-grounded workflow instead of pretending the scene is static knowledge.

## 6. Parameters and constraints to remember

- Nano Banana 2:
  - max input tokens: `131,072`
  - output tokens: `32,768`
  - extra aspect ratios: `1:4`, `4:1`, `1:8`, `8:1`
- Nano Banana Pro:
  - max input tokens: `65,536`
  - output tokens: `32,768`
- Both:
  - up to 14 images per prompt
  - standard image MIME types
  - search grounding support
  - text and image output

For the skill, the practical rule is:

- use the same prompt system for both models
- branch only when the user needs Nano Banana 2-specific aspect ratios, smaller output sizes, or the larger context window

## 7. Failure modes and fixes

### Failure: generic or weak image

Likely cause:

- The prompt is too vague or too style-heavy.

Fix:

- Rewrite with the full text-to-image formula:
  - subject
  - action
  - context
  - composition
  - style

### Failure: edit changes too much

Likely cause:

- The prompt states the requested change but not what must remain fixed.

Fix:

- Add explicit preservation language for pose, framing, lighting, identity, and layout.

### Failure: references are used inconsistently

Likely cause:

- The prompt does not assign roles to the references.

Fix:

- State what each reference is for:
  - structure
  - texture
  - character
  - product
  - style

### Failure: text inside image is unreliable

Likely cause:

- The words were not quoted
- type style was not described
- the prompt tried to do too much at once

Fix:

- quote the text
- specify the font character and placement
- if needed, use the text-first workflow

### Failure: grounded visual feels fabricated

Likely cause:

- The prompt did not state the retrieval step and the translation step separately.

Fix:

- explicitly request the search or source lookup
- explain how to map the retrieved data into the image

## 8. Reusable templates for the skill

### Text-to-image

```text
Create an image of [subject], [action or pose], in [location or setting]. Compose it as a [shot type / framing / angle]. Render it in [style], with [lighting and finish].
```

### Reference-driven generation

```text
Using the attached references, use [reference 1] for [role], [reference 2] for [role], and [reference 3] for [role]. Create [new scenario or scene]. Keep [identity / product / structure / texture] consistent while adapting it to [new context].
```

### Editing

```text
Edit the image by [specific change]. Keep [subject / face / pose / composition / background / lighting / product details] exactly the same.
```

### Text rendering

```text
Create a [poster / ad / diagram / graphic] showing [scene or object]. Render the exact text "[text]" in [typography style]. Place it [position]. Keep the text sharp and legible.
```

### Web-grounded visualization

```text
Search for [current data or real-world information]. Use that information to determine [visual condition]. Then create [visual output concept] in [style].
```

## 9. What the skill should ask the user

Before writing a Nano Banana prompt, the skill should gather:

- whether this is:
  - generation from scratch
  - generation from references
  - editing
  - text rendering
  - web-grounded visualization
- subject
- action or pose
- location or context
- framing or aspect ratio
- style and lighting
- exact visible text, if any
- what must remain unchanged during edits
- what each reference image is for, if multiple references exist

## 10. Sources and provenance

Primary:

- [Ultimate prompting guide for Nano Banana](https://cloud.google.com/blog/products/ai-machine-learning/ultimate-prompting-guide-for-nano-banana)
- [Gemini 3.1 Flash Image docs](https://docs.cloud.google.com/vertex-ai/generative-ai/docs/models/gemini/3-1-flash-image)
- [Gemini 3 Pro Image docs](https://docs.cloud.google.com/vertex-ai/generative-ai/docs/models/gemini/3-pro-image)

Supplemental:

- [Build with Nano Banana 2](https://blog.google/technology/developers/build-with-nano-banana-2/)

Notes on confidence:

- The prompt formulas, edit guidance, text rendering rules, and web-grounding workflow are directly grounded in Google's official prompt guide.
- The Nano Banana 2 vs Pro capability differences come from the official model docs.
