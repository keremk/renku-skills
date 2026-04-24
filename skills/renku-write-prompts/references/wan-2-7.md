# Wan 2.7

Wan 2.7 is one of the most explicitly formula-driven video models in this library. The Alibaba docs are clear that the prompt shape should change depending on whether the workflow is text-to-video, image-to-video, sound generation, reference video, or multi-shot narrative. The skill should treat this as a mode-specific prompting family, not a single prompt style.

## 1. Model fit

- Provider: Alibaba
- Modality: Video generation and reference-driven video workflows
- Confidence: High
- Best for:
  - formula-based prompting
  - text-to-video and image-to-video
  - audio-aware scenes
  - reference-based generation
  - multi-shot narrative clips

## 2. Capability snapshot that matters to the skill

The official guide explicitly covers:

- text-to-video
- image-to-video
- first-and-last-frame image-to-video
- reference-to-video
- sound generation
- multi-shot prompting
- automatic prompt extension via `prompt_extend`

The core implication:

- the skill should choose a Wan prompt formula based on the actual generation mode

## 3. Prompting system from the source docs

### A. Basic text-to-video formula

Official formula:

`Entity + Scene + Motion`

Use this for:

- simple generation
- creative exploration
- faster concepting

### B. Advanced text-to-video formula

Official formula:

`Entity (description) + Scene (description) + Motion (description) + Aesthetic control + Stylization`

Use this for:

- higher fidelity
- better narrative quality
- more precise camera control
- more specific visual identity

### C. Image-to-video formula

Official formula:

`Motion + Camera movement`

This is a critical source-backed rule:

- the source image already defines entity, scene, and style
- the prompt should describe motion and camera, not restate the whole frame

### D. Multi-shot formula

Official formula:

`Overall description + Shot number + Timestamp + Shot content`

Use this for:

- narrative sequences
- clearly segmented internal shots
- precise camera and timing structure

### E. Sound generation

The official guide covers:

- human voice
- ambient sound
- sound effects
- background music

Operational rule:

- if sound matters, say what the viewer hears, not just what they see

## 4. Workflow-specific prompting guidance

### A. Text-to-video

Use the basic or advanced formula depending on how much control is needed.

For simple work:

- entity
- scene
- motion

For production work:

- detailed entity
- detailed scene
- motion amplitude and speed
- camera terms
- style terms

### B. Image-to-video

This is one of the clearest source-backed rules in the whole library:

- focus on what starts moving
- focus on how the camera moves
- avoid re-describing the static contents already visible in the source image

### C. Reference-to-video

Use references when identity or style continuity matters.

Operational rule:

- references provide the anchor
- prompt describes what happens in the resulting video

### D. Multi-shot narrative

The official guide is explicit:

- summarize the overall story first
- then number the shots
- then give timestamps
- then describe shot content

### E. Sound-rich scenes

If the clip needs:

- spoken lines
- ambience
- ASMR-like textures
- beat-synced music

the prompt should state those elements directly

## 5. What the sources emphasize most

- structured formulas materially improve output
- detailed motion descriptions help
- camera language belongs in `Aesthetic control`
- prompt extension can help short prompts
- multi-shot work needs explicit shot structure
- sound should be prompted deliberately

## 6. Parameters and model-level implications

From the official docs:

- `prompt_extend` can automatically optimize short prompts

For the skill:

- if the user gives a short vague idea and wants fast help, Wan can tolerate shorter prompts with prompt extension
- if the user wants precision, the skill should manually write the full formula instead of relying on extension

## 7. Failure modes and fixes

### Failure: prompt is too generic

Likely cause:

- using only a minimal prompt when the scene needs advanced control

Fix:

- switch from the basic formula to the advanced formula

### Failure: image-to-video drifts

Likely cause:

- prompt re-describes the static image instead of the motion

Fix:

- use only motion + camera movement

### Failure: multi-shot clip feels disconnected

Likely cause:

- no overall description or no timestamps

Fix:

- use the full multi-shot structure

### Failure: audio feels absent or generic

Likely cause:

- prompt does not specify sound

Fix:

- add dialogue, ambient sound, or music directly in the prompt

## 8. Reusable templates for the skill

### Basic text-to-video

```text
[Entity] in [scene], [motion].
```

### Advanced text-to-video

```text
[Entity description] in [scene description], [motion description], [aesthetic control], [stylization].
```

### Image-to-video

```text
[Motion]. The camera [movement].
```

### Multi-shot

```text
Overall description: [summary].
Shot 1 [time range]: [shot content].
Shot 2 [time range]: [shot content].
Shot 3 [time range]: [shot content].
```

### Sound-rich scene

```text
[Visual prompt]. Ambient audio: [ambience]. [Dialogue or sound effect if relevant].
```

## 9. What the skill should ask the user

Before writing a Wan 2.7 prompt, the skill should gather:

- which mode is being used:
  - text-to-video
  - image-to-video
  - reference-to-video
  - multi-shot
- entity or main subject
- scene
- motion
- camera behavior
- sound needs
- overall narrative summary if multi-shot

## 10. Sources and provenance

Primary:

- [Alibaba Cloud text-to-video / image-to-video prompt guide](https://www.alibabacloud.com/help/en/model-studio/text-to-video-prompt)
- [Wan general video editing guide](https://www.alibabacloud.com/help/en/model-studio/wan-vace-guide)

Supplemental:

- [Wan 2.7 prompt guide](https://wan27ai.com/prompt-guide)
- [WaveSpeed model page](https://wavespeed.ai/models/alibaba/wan-2.7/video-edit)

Notes on confidence:

- The core formulas and mode-specific rules are directly grounded in Alibaba's official guide and should be treated as high-confidence.
