# Seedance 1.5 Pro

Seedance 1.5 Pro is not a generic “text-to-video” model in the references. The strongest source treats it as an audio-video model with a layered prompt structure. That is the key distinction the skill should respect.

## 1. Model fit

- Provider: ByteDance Seed
- Modality: Video generation with synchronized audio
- Confidence: Medium-high
- Best for:
  - short narrative clips with synchronized sound
  - stylized motion and expressive character action
  - clips where sound design matters, not just visuals
  - prompts that explicitly coordinate subject, sound, and style

## 2. Capability snapshot that matters to the skill

The references emphasize:

- synchronized audio-video generation
- strong response to structured prompt layers
- explicit support for dialogue, environmental sound, and style
- camera control
- better results when progression is described over time

The biggest practical distinction is:

- if the blueprint uses Seedance 1.5 Pro, the skill should not write a visuals-only prompt unless the user explicitly wants silence

## 3. Prompting system from the source docs

### Primary four-layer structure

The fal guide explicitly defines a four-layer prompt system:

1. Primary subject or primary action
2. Dialogue or key sound event
3. Environmental audio cues
4. Visual style

This is the core structure the skill should use.

### What each layer does

#### Layer 1: Primary subject or action

- define the central visual event
- say who or what is in frame
- say what is happening

#### Layer 2: Dialogue or key sound event

- quote spoken lines when needed
- or specify a central sound event such as:
  - ceramic clink
  - footsteps
  - crowd gasp
  - sizzling oil

#### Layer 3: Environmental audio

- define the background soundscape:
  - room tone
  - wind
  - traffic
  - birds
  - machine hum
  - music feel

#### Layer 4: Visual style

- define the cinematic, animated, editorial, or stylized finish
- add lighting and visual mood

## 4. Workflow-specific prompting guidance

### A. Standard text-to-video

Use the four-layer structure directly.

The prompt should include:

- the visible action
- the meaningful sound
- the environmental bed
- the style and lighting

### B. Dialogue scene

When a character speaks:

- write the line in quotes
- anchor the speech to a visible delivery moment
- give the environment a sound bed
- keep the number of spoken lines realistic for the clip duration

### C. Action progression inside one clip

The source guide explicitly recommends temporal progression inside the prompt.

Operational rule:

- use comma-separated action progression to imply sequence
- describe how one motion leads into the next

### D. Contrast or emotional shift

The guide explicitly highlights contrast and juxtaposition as useful.

Operational rule:

- build one clear reversal or shift into the scene
- do not stack several unrelated shifts

## 5. What the sources emphasize most

- Audio is not an afterthought. It is one of the model's main strengths.
- Vague prompts create generic video and generic sound.
- Conflicting audio and visual instructions create incoherence instead of a useful failure.
- Temporal sequencing improves results.
- Sound-specific language matters:
  - rhythm
  - tone
  - ambient environment
  - key cue timing

## 6. Parameters and controls that affect prompting

From the sources:

- `camera_fixed` matters when you need a locked camera
- duration and aspect ratio choices should align with the prompt complexity
- native audio should be enabled intentionally
- safety checker behavior may block prompts that trip filters

The fal guide gives concrete use-case combinations like:

- cinematic establishing shots with wider aspect ratios and moving camera
- controlled static scenes with fixed camera

For the skill:

- if the story beat is emotional or dialogue-based, budget enough duration for speech
- if the scene is mostly visual, do not overstuff it with dialogue

## 7. Failure modes and fixes

### Failure: generic output

Likely cause:

- subject/action layer is too vague

Fix:

- make the visible action concrete and sensory

### Failure: incoherent sound

Likely cause:

- audio instructions conflict with the visuals

Fix:

- align dialogue, sound effects, and environment to the same scene logic

### Failure: wasted audio capability

Likely cause:

- prompt ignores sound entirely

Fix:

- add one key sound event and one environmental sound layer

### Failure: too much happens in one clip

Likely cause:

- too many actions or too much speech for the duration

Fix:

- reduce the clip to one main beat plus one progression

## 8. Reusable templates for the skill

### Standard Seedance prompt

```text
[Primary subject or action]. [Dialogue or key sound event]. [Environmental audio]. [Visual style and lighting].
```

### Dialogue scene

```text
[Character and visible action]. "[Exact line]". [Background sound bed]. [Style and lighting].
```

### Action progression

```text
[Subject action 1], [subject action 2], [subject action 3], [key sound event], [environmental audio], [style].
```

## 9. What the skill should ask the user

Before writing a Seedance 1.5 Pro prompt, the skill should gather:

- primary visible action
- whether anyone speaks
- exact spoken line if yes
- key sound cue
- ambient sound bed
- camera behavior
- style and lighting

## 10. Sources and provenance

Primary:

- [Seedance 1.5 Pro product page](https://seed.bytedance.com/en/seedance1_5_pro)
- [Seedance 1.5 Pro technical report](https://seed.bytedance.com/public_papers/seedance-1-5-pro-a-native-audio-visual-joint-generation-foundation-model)

Supplemental:

- [Seedance 1.5 prompt guide](https://fal.ai/learn/devs/seedance-1-5-prompt-guide)
- [Seedance 1.5 user guide](https://fal.ai/learn/devs/seedance-1-5-user-guide)

Notes on confidence:

- The layered prompt structure and failure patterns come mainly from fal's detailed guide.
- ByteDance's official material supports the audio-video positioning and the model's overall capability profile.
