# LTX-2.3

LTX-2.3's official materials are unusually direct about what actually improves results: flowing paragraph prompts, explicit camera movement, explicit audio, present-tense action, and duration-aware detail density. This guide should be treated as a high-confidence operational reference.

## 1. Model fit

- Provider: Lightricks / LTX Studio
- Modality: Video generation
- Confidence: High
- Best for:
  - practical prompt-driven video generation
  - longer short-form clips
  - clear camera-direction prompts
  - acting beats and audio-aware scenes
  - iterative storyboarding and previz

## 2. Capability snapshot that matters to the skill

From the official materials:

- prompt adherence improved significantly in 2.3
- longer, more descriptive prompts perform better than short prompts
- audio descriptions have greater impact than before
- cinematic terms are understood directly
- for longer outputs, the prompt needs enough detail to fill the duration

The 20-second guide adds an important practical point:

- longer-feeling videos benefit from slower camera movement, extended transitions, and descriptive staging

## 3. Prompting system from the source docs

The official guide presents LTX prompts as a flowing paragraph with a set of required elements.

### Key elements to include

1. Establish the shot
2. Describe the subject
3. Describe the action or progression
4. Describe the environment and atmosphere
5. Identify camera movement
6. Describe the audio

### Best-results rules

The official guide is explicit:

- write the prompt as a single flowing paragraph
- use present tense verbs
- match detail level to shot scale
- describe camera movement relative to the subject

## 4. Workflow-specific prompting guidance

### A. Text-to-video

The guide says to include:

- subject
- action
- environment
- lighting
- camera movement
- audio

Because everything is generated from scratch, detail is the main control lever.

### B. Image-to-video

This is a key source-backed rule:

- do not re-describe static elements that are already visible in the input image
- instead describe what happens next
- describe the transition from stillness to motion

### C. Audio-to-video

The official material says:

- the audio anchors the temporal structure
- the prompt should describe the visual interpretation of the soundtrack

### D. Longer clips

The 20-second guide adds:

- prompt specificity matters even more for longer clips
- slow camera moves and extended transitions make a clip feel longer and more intentional
- long videos need sufficiently detailed prompts or the model rushes through the action

## 5. What the sources emphasize most

- cinematic language works
- explicit camera language works
- explicit audio description works
- vague prompts underperform
- over-constrained numerical prompts underperform
- conflicting directions confuse the model
- readable text/logos are not reliable

## 6. Parameters and model-level implications

From the official materials:

- longer durations require more prompt detail
- 1080p is a practical starting point when iterating
- 24/25 fps are standard starting points in the longer-clip workflow

For the skill:

- if the segment is long, add more action progression and environmental detail
- if the shot is close-up, include more facial or tactile detail
- if the shot is wide, prioritize staging and composition over micro-detail

## 7. Failure modes and fixes

### Failure: clip feels rushed

Likely cause:

- prompt is too short for the duration

Fix:

- add more descriptive staging and progression

### Failure: camera motion is weak or wrong

Likely cause:

- prompt does not describe camera movement relative to the subject

Fix:

- specify how the camera moves in relation to the subject

### Failure: clip is vague

Likely cause:

- prompt lacks subject, action, lighting, or sound detail

Fix:

- include the full set of key elements

### Failure: prompt becomes brittle

Likely cause:

- too many numerical or overly literal control instructions

Fix:

- rewrite in natural cinematic language

## 8. Reusable templates for the skill

### Standard LTX prompt

```text
[Establish the shot]. [Subject]. [Action progression]. [Environment and atmosphere]. The camera [movement relative to subject]. [Audio].
```

### Image-to-video prompt

```text
Using the input image as the starting point, [describe what begins to move and how it evolves]. The camera [movement]. [Audio or ambience]. Do not rewrite static scene details already visible in the source image.
```

### Longer-clip prompt

```text
[Scene setup]. [Action progression over time]. The camera [slow movement or transition]. [Lighting and atmosphere]. [Audio bed].
```

## 9. What the skill should ask the user

Before writing an LTX-2.3 prompt, the skill should gather:

- shot type
- subject
- action progression
- environment
- camera movement
- audio or dialogue
- segment duration

## 10. Sources and provenance

Primary:

- [LTX-2.3 prompt guide](https://ltx.io/model/model-blog/ltx-2-3-prompt-guide)
- [How to generate 20-second AI videos with LTX-2.3](https://ltx.io/model/model-blog/how-to-generate-20-second-ai-videos)
- [LTX-2.3 model page](https://ltx.io/model/ltx-2-3)

Notes on confidence:

- The paragraph prompting style, key-element checklist, and duration-aware prompt strategy are directly supported by LTX's own materials.
