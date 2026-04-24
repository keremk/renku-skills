# Veo 3.1

Veo 3.1 has one of the strongest official prompting guides in this library. The skill should treat this as a high-confidence, source-backed operating guide rather than a loose best-practices summary.

## 1. Model fit

- Provider: Google
- Modality: Video generation with synchronized audio
- Confidence: High
- Best for:
  - premium cinematic clips
  - dialogue and sound-aware scenes
  - strong camera-language control
  - reference-driven multi-shot consistency
  - controlled first-frame/last-frame transitions

## 2. Capability snapshot that matters to the skill

From the official docs:

- 720p and 1080p output
- 16:9 and 9:16 aspect ratios
- 4, 6, or 8 second clips
- synchronized audio, dialogue, and sound effects
- improved image-to-video
- `ingredients to video` for consistent scene/character/object/style references
- `first and last frame` for controlled transitions
- add/remove object support

The key implication for the skill:

- Veo prompts should be written as cinematic direction, not generic prose

## 3. Prompting system from the source docs

### Primary five-part formula

Google's official formula:

`[Cinematography] + [Subject] + [Action] + [Context] + [Style & Ambiance]`

This is the default structure the skill should use for Veo 3.1.

### What each element means

#### Cinematography

- camera movement
- shot composition
- lens feel
- framing

#### Subject

- main character or focal element

#### Action

- what the subject is doing

#### Context

- environment
- background
- supporting scene elements

#### Style & Ambiance

- visual style
- tone
- mood
- lighting

## 4. Workflow-specific prompting guidance

### A. Standard cinematic clip

Use the five-part formula directly.

This is the default for:

- scene segments
- visual story beats
- premium ad clips
- dramatic dialogue moments

### B. Audio and dialogue

The official guide is unusually specific here.

Operational rules:

- use quotation marks for dialogue
- describe SFX directly
- describe ambient sound directly

Example categories:

- dialogue
- footsteps
- thunder
- room tone
- starship hum
- cheering crowd

### C. Ingredients to video

Use this when the workflow needs:

- consistent characters across shots
- consistent objects across shots
- consistent scene style across shots

Operational rule:

- use reference images as ingredients
- describe the current shot being composed from those ingredients

This is especially useful for:

- dialogue scenes
- recurring branded subjects
- story continuity

### D. First and last frame

Use this when the segment needs:

- a controlled transition
- a continuous camera move between two known visual states
- a reveal or arc move

Operational rule:

- the two images define the endpoints
- the Veo prompt should describe the transition and audio

### E. Timestamp prompting

The official guide includes timestamp workflows.

Use this when a segment needs more internal staging than a single unbroken description.

## 5. What the sources emphasize most

- Cinematography is the most powerful control layer.
- Veo understands cinematic terms and narrative structure well.
- Audio should be intentionally directed.
- Structured prompts produce more reliable results than loose prose.
- Advanced workflows are often better than trying to do everything in one monolithic prompt.

## 6. Parameters and constraints that affect prompting

From the official docs:

- durations are fixed to 4, 6, or 8 seconds
- aspect ratio is limited to 16:9 or 9:16

For the skill:

- design each segment around one clear beat
- keep spoken content within the clip duration
- use ingredients-to-video or first/last-frame workflows when consistency or transitions matter instead of forcing everything into one text prompt

## 7. Failure modes and fixes

### Failure: good-looking clip but weak story beat

Likely cause:

- style and mood dominate over action

Fix:

- strengthen the subject and action layers

### Failure: weak camera behavior

Likely cause:

- cinematography layer is too vague

Fix:

- specify movement, framing, and lens feel

### Failure: dialogue feels detached

Likely cause:

- line is present but the visual delivery moment is not

Fix:

- describe the speaker, the visible action, and the quoted line together

### Failure: continuity breaks across shots

Likely cause:

- references were not used or not assigned clearly

Fix:

- switch to ingredients-to-video

### Failure: transition is uncontrolled

Likely cause:

- trying to describe a transition in plain text alone

Fix:

- use first-and-last-frame workflow

## 8. Reusable templates for the skill

### Standard Veo prompt

```text
[Cinematography]. [Subject]. [Action]. [Context]. [Style & Ambiance].
```

### Dialogue scene

```text
[Cinematography]. [Character and visible action]. The character says, "[exact line]". [Context]. [Style, lighting, and ambient sound].
```

### Ingredients-to-video

```text
Using the provided images for [character / object / setting], create [shot description]. [Visible action]. [Camera behavior]. [Audio or dialogue].
```

### First-and-last-frame transition

```text
Animate a transition from the first frame to the last frame. The camera [movement]. [Subject action]. [Audio and ambience].
```

## 9. What the skill should ask the user

Before writing a Veo 3.1 prompt, the skill should gather:

- shot type and camera behavior
- main subject
- main action
- environment
- style and lighting
- whether audio is needed
- exact dialogue if any
- whether references or start/end frames should be used

## 10. Sources and provenance

Primary:

- [Ultimate prompting guide for Veo 3.1](https://cloud.google.com/blog/products/ai-machine-learning/ultimate-prompting-guide-for-veo-3-1)
- [Veo on Vertex AI docs](https://docs.cloud.google.com/vertex-ai/generative-ai/docs/models/veo/3-1-generate-preview)

Supplemental:

- [Veo prompt guide](https://ltx.studio/blog/veo-prompt-guide)

Notes on confidence:

- The five-part formula, cinematography emphasis, audio handling, and advanced workflows are directly grounded in Google's official prompt guide.
