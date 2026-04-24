# Kling VIDEO 3.0

Kling 3 is one of the clearest examples of a model where prompt structure changes substantially depending on whether the scene is single-shot, multi-shot, image-to-video, or audio-driven dialogue. The richer guides make that explicit, and the skill should follow that logic.

## 1. Model fit

- Provider: Kling AI / Kuaishou
- Modality: Video generation with strong structured-shot support
- Confidence: Medium-high
- Best for:
  - multi-shot cinematic prompting
  - multi-character dialogue scenes
  - identity consistency across shots
  - image-to-video anchored by a source image
  - longer short-form sequences up to about 15 seconds

## 2. Capability snapshot that matters to the skill

The sources emphasize:

- strong support for cinematic language
- clear multi-shot prompting
- consistent characters, objects, and environments once established
- native audio output
- multilingual dialogue and tone control
- image-to-video with strong identity and layout preservation
- longer-duration clips that can contain more than a single beat

## 3. Prompting system from the references

Kling is not best handled with one generic prompt formula.

### A. Single-shot structure

Use:

`Scene + Key action + Camera behavior + Audio layer + Style`

### B. Multi-shot structure

The fal guide is explicit:

- clearly label each shot
- describe framing, subject, and motion for each shot

Operational structure:

`Overall scene or master prompt + Shot 1 + Shot 2 + Shot 3`

### C. Dialogue structure

The sources give explicit dialogue labeling rules.

Operational rules:

- use stable character labels
- tie dialogue to visible character action
- include tone descriptors
- use clear turn-switching words such as `immediately`

### D. Image-to-video structure

The source image is the anchor.

Operational rules:

- focus on how the scene evolves
- preserve identity, layout, signage, and core details from the image
- describe motion and camera behavior rather than re-describing static content

## 4. Workflow-specific prompting guidance

### A. Multi-character dialogue

This is a major Kling strength in the sources.

Rules:

- introduce the characters early
- keep names or labels consistent
- describe the physical action before the line when needed
- assign voice tone and emotion specifically

### B. Explicit motion

The sources stress that Kling responds especially well to:

- camera tracking
- following
- freezing
- panning
- movement synchronized to subject motion

### C. Longer durations

Because Kling 3 supports longer short-form clips, prompts can include:

- progression over time
- multiple beats inside one generation

But the source guidance still implies:

- progression must be structured
- scene evolution should be explicit

### D. Image-to-video

The sources explicitly say:

- lock the image first
- then describe motion

This makes Kling especially useful for:

- branded content
- advertising
- scene extension
- character continuity from a known frame

## 5. What the sources emphasize most

- shot labeling matters
- character naming matters
- visual anchoring matters
- native audio should be used intentionally
- image-to-video should focus on change over time, not static scene description

## 6. Parameters and model-level implications

From the prompt guides:

- longer durations are useful when the prompt includes progression
- native audio should be enabled only when the prompt clearly specifies speakers and sound

For the skill:

- if the segment is dialogue-heavy, choose stable character labels and tone descriptors
- if the segment is image-to-video, do not waste tokens re-describing what the anchor image already establishes
- if the segment is multi-shot, structure it explicitly by shot

## 7. Failure modes and fixes

### Failure: dialogue attribution is muddled

Likely cause:

- weak or inconsistent character labels

Fix:

- use unique stable character labels and keep them consistent

### Failure: shots feel disconnected

Likely cause:

- no overall structure or continuity anchors

Fix:

- add a master scene description and reuse identity anchors across shots

### Failure: image-to-video drifts from source image

Likely cause:

- prompt over-describes a new scene instead of evolving the current one

Fix:

- describe motion and camera changes, not a replacement scene

### Failure: audio feels generic or mismatched

Likely cause:

- no clear speaker or sound timing

Fix:

- identify speaker, tone, and turn-taking explicitly

## 8. Reusable templates for the skill

### Single-shot prompt

```text
[Scene]. [Subject action]. The camera [movement]. [Audio layer]. [Style and lighting].
```

### Multi-shot prompt

```text
Overall scene: [summary].
Shot 1: [framing, subject, motion].
Shot 2: [framing, subject, motion].
Shot 3: [framing, subject, motion].
```

### Dialogue prompt

```text
[Scene and sound bed].
[Character A: role, voice tone]: "[line]"
Immediately, [Character B: role, voice tone]: "[line]"
[Camera and motion description].
```

### Image-to-video prompt

```text
Using the source image as the anchor, animate [specific motion]. The camera [movement]. Preserve the original identity, layout, and visible details while introducing [new action or atmosphere].
```

## 9. What the skill should ask the user

Before writing a Kling 3 prompt, the skill should gather:

- whether the segment is:
  - single-shot
  - multi-shot
  - image-to-video
  - dialogue-driven
- recurring character labels
- visible action per shot
- camera behavior per shot
- dialogue lines and tones if audio is enabled

## 10. Sources and provenance

Primary:

- [Kling VIDEO 3.0 model user guide](https://app.klingai.com/cn/quickstart/klingai-video-3-model-user-guide)

Supplemental:

- [Kling 3.0 prompting guide](https://blog.fal.ai/kling-3-0-prompting-guide/)
- [Kling style emulation guide](https://kling.ai/blog/kling-ai-video-style-emulation-guide)

Notes on confidence:

- The most detailed operational guidance comes from fal's Kling prompt guide.
- The key themes are structured shot prompting, stable character labeling, and intentional use of native audio.
