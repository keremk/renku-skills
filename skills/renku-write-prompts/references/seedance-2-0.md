# Seedance 2.0

Seedance 2.0 is not a generic "swap-in video model." The strongest sources position it as a unified multimodal audio-video generation system with materially different workflows for text-to-video, image-to-video, start/end-frame animation, reference-driven generation, and multi-shot sequences.

That difference matters for the `create-video` skill.

The skill should not treat Seedance 2.0 as "just another text-to-video model with better quality." It should choose the correct workflow first, then write prompts for that workflow.

## 1. Model fit

- Provider: ByteDance Seed
- Modality: Multimodal video generation with synchronized native audio
- Confidence: High
- Best for:
  - short cinematic clips with synchronized sound
  - multi-shot sequences inside one generation
  - reference-driven brand or character consistency
  - image-anchored animation
  - controlled camera direction
  - scenes where sound design is part of the creative result, not an afterthought

## 2. Capability snapshot that matters to the skill

The sources emphasize:

- unified audio-video generation
- strong camera-language understanding
- multi-shot generation with explicit cut labeling
- multimodal reference workflows
- image-to-video with optional end frame
- native audio including ambience, sound effects, music feel, and lip-synced speech
- stronger controllability than earlier Seedance versions
- good handling of complex motion and multi-subject scenes

The biggest practical distinction is:

- Seedance 2.0 should be treated as a workflow family, not a single prompt style

The official ByteDance materials also position it as a broader multimodal system that supports:

- text input
- image input
- video input
- audio input

and references elements such as:

- composition
- shot scale
- camera movement
- visuals
- motion rhythm
- sound characteristics

## 3. Prompting system from the source docs

### Primary operational structure

The fal guide and ByteDance examples point to a reliable structure:

1. Subject and action first
2. Camera behavior second
3. Sound or audio cues third
4. Shot transitions or shot labeling last when multi-shot is needed

A useful working formula is:

`[Subject + action] + [Camera behavior] + [Sound design] + [Context / style] + [Shot structure if multi-shot]`

The critical shift from weaker prompting habits is:

- do not write static image-style keyword piles
- do not rely on vague "cinematic, beautiful, 4K" phrasing
- do describe motion, camera, sound, and temporal progression directly

### What the model seems to want

From the fal guide and official examples:

- cinematic direction over tag clouds
- explicit motion over static description
- camera instructions stated plainly
- one main action per shot
- explicit sound when sound matters
- clearly labeled shots for multi-shot sequences

### Camera language

The fal guide explicitly says cinematography terms work well.

Useful camera terms include:

- tracking shot
- handheld
- POV
- aerial shot
- slow push-in
- rack focus
- pan
- tilt
- orbit

These should be treated as production instructions, not decoration.

## 4. Workflow-specific prompting guidance

### A. Standard text-to-video

Use when the shot is being generated from scratch.

Operational rules:

- lead with the visible action
- state what the camera is doing
- state what should be heard if sound matters
- keep the shot centered on one strong beat
- use style and lighting as support, not as the whole prompt

The model performs better when the prompt feels like a directed scene rather than a mood board caption.

### B. Audio-aware text-to-video

This is one of Seedance 2.0's core strengths.

Operational rules:

- if sound matters, say what should be heard
- distinguish the key sound event from the ambient bed
- keep spoken content realistic for the clip length
- do not assume the model will infer the exact sound design you want from visuals alone

The model can generate:

- ambient sound
- sound effects
- music-like audio feel
- lip-synced speech

But the fal guide suggests:

- sound effects and ambience are especially strong
- dialogue-heavy use cases should be tested against production quality expectations before committing fully

### C. Multi-shot generation

This is a first-class workflow, not a hack.

Operational rules:

- label shots explicitly with `Shot 1:`, `Shot 2:`, and so on
- give each shot one primary action and one clear camera move
- give the generation enough time
- prefer roughly 10 to 15 seconds, or `auto`, for true multi-shot work
- do not cram too many shots into too little duration

If the prompt describes multiple shots but the duration is too short, the model may compress or skip shots.

### D. Image-to-video

Use when a starting image should anchor identity, layout, or visual composition.

Operational rules:

- let the source image carry the static visual identity
- describe the motion, camera movement, and audio evolution
- do not waste most of the prompt re-describing what the image already establishes
- use end-frame guidance when you need an A-to-B transition

This is a strong fit for:

- animating a portrait or concept image
- controlled product motion
- bringing a still scene to life
- maintaining visual identity while adding motion

### E. Start-and-end-frame animation

Seedance 2.0 supports a start image plus an end image.

Operational rules:

- define the start image as the anchor
- define the end image only when the scene needs a controlled destination
- use the prompt to describe how the scene moves from A to B
- focus on the transition behavior, not just two disconnected states

This is especially useful for:

- transformation shots
- reveal shots
- before/after sequences
- controlled morphing or progression

### F. Reference-to-video

This is where Seedance 2.0 becomes much more than a generic video model.

In Renku, the Seedance reference workflow can receive any supplied mix of:

- optional `ReferenceImages`
- optional `ReferenceVideos`
- optional `ReferenceAudios`

Images are optional in this workflow too. Do not assume there is always an image reference just because the workflow is reference-driven.

The fal guide describes support for:

- up to 9 reference images
- up to 3 reference videos
- up to 3 reference audio clips
- total files across modalities not exceeding 12

Operational rules:

- assign each reference a role explicitly
- refer to them in the prompt as `@Image1`, `@Image2`, `@Video1`, `@Audio1`, and so on
- only mention labels for references that are actually supplied by the blueprint graph and producer contract
- say what each reference contributes
- ask the model to compose from those ingredients rather than vaguely "use the references"

Good reference roles include:

- hero subject
- character identity
- environment style
- storyboard or shot plan
- motion reference
- audio reference
- product or prop reference

The official ByteDance launch post is especially important here because it explicitly frames Seedance 2.0 as being able to reference:

- composition
- shot scale
- camera movement
- visuals
- motion rhythm
- sound characteristics

from the supplied assets.

That means reference prompts should be role-based, not generic.

## 5. What the sources emphasize most

- Seedance 2.0 wants direction, not decorative prompt fluff.
- Motion, camera, and sound are the main control layers.
- Multi-shot prompting should be explicit.
- Reference inputs should be assigned clear roles.
- Native audio is a real feature, not a side effect.
- One main action per shot is more reliable than overloaded choreography.
- The model is especially interesting when the workflow needs synchronized audio and video in one pass.

## 6. Parameters and controls that affect prompting

From the model docs and fal schemas:

- duration supports `4` to `15` seconds, plus `auto`
- resolution is effectively `480p` or `720p` on fal
- aspect ratio supports:
  - `auto`
  - `21:9`
  - `16:9`
  - `4:3`
  - `1:1`
  - `3:4`
  - `9:16`
- `generate_audio` is enabled by default
- `seed` can help iteration, though exact reproducibility is not guaranteed

For the skill:

- short single-shot beats often fit 4 to 6 seconds
- multi-shot prompts usually need more room
- if the scene includes dialogue, sound effects, and several actions, do not underspecify duration
- `auto` is acceptable when the scene description is clean and the workflow does not require exact editorial timing

### Renku-specific implementation note

This matters for the skill inside this repo.

Seedance 2.0 reference prompting must follow the actual Renku producer contract for the active graph.

In the current catalog:

- `video/text-to-video` exposes the text-to-video path
- `video/image-to-video` exposes start image and end image
- `video/start-end-frame-to-video` also supports the start/end-frame path
- Seedance reference workflows can expose optional `ReferenceImages`, `ReferenceVideos`, and `ReferenceAudios`

So the skill should follow this rule:

- write `@Image1`, `@Video1`, or `@Audio1` style reference labels only when that media item is actually wired into the model call
- do not write `@Image1` when the reference workflow is using only video and audio references
- keep numbering modality-local: the first supplied image is `@Image1`, the first supplied video is `@Video1`, and the first supplied audio clip is `@Audio1`

Do not write prompts that assume capabilities the current blueprint cannot wire.

## 7. Failure modes and fixes

### Failure: generic or lifeless motion

Likely cause:

- the prompt is mostly static visual description
- the action is not concrete
- camera behavior is absent

Fix:

- define one clear action
- define one clear camera move
- make the motion observable

### Failure: sound feels random or weak

Likely cause:

- the prompt never specified meaningful sound cues

Fix:

- name the key sound event
- name the ambient sound bed
- keep the audio logic aligned with the scene

### Failure: multi-shot output feels like one continuous take

Likely cause:

- shots were not labeled explicitly

Fix:

- use `Shot 1:`, `Shot 2:`, and so on
- make the cut structure visible in the prompt

### Failure: multi-shot sequence feels rushed or incomplete

Likely cause:

- too many shots for the chosen duration

Fix:

- reduce the number of shots
- simplify each shot
- increase duration toward the 10 to 15 second range

### Failure: reference assets are ignored or used vaguely

Likely cause:

- the prompt does not assign roles to the references

Fix:

- state what each reference contributes
- use explicit role language such as:
  - `@Image1 is the hero character`
  - `@Image2 defines the environment`
  - `@Video1 supplies the motion rhythm`
  - `@Audio1 is the voiceover`

### Failure: image-to-video drifts from the source image

Likely cause:

- the prompt is trying to replace the scene instead of animate it

Fix:

- use the source image as the anchor
- describe motion and camera evolution, not a brand-new scene

### Failure: dialogue quality is below the production bar

Likely cause:

- relying on native speech without checking whether the result meets the project's standards

Fix:

- test dialogue-heavy cases before committing
- if the scene's main value is dialogue fidelity rather than integrated ambience, consider whether another workflow is a better fit

## 8. Reusable templates for the skill

### Standard Seedance 2.0 single-shot prompt

```text
[Subject and action]. The camera [movement]. [Key sound or dialogue]. [Environment, lighting, and overall atmosphere].
```

### Audio-aware single-shot prompt

```text
[Visible action]. The camera [movement]. [Specific sound event]. [Ambient sound bed]. [Style and lighting].
```

### Multi-shot prompt

```text
Shot 1: [subject, action, camera, sound].
Shot 2: [subject, action, camera, sound].
Shot 3: [subject, action, camera, sound].
```

### Image-to-video prompt

```text
Using the source image as the visual anchor, animate [specific motion]. The camera [movement]. Preserve the established identity and layout while introducing [new action, atmosphere, or sound].
```

### Start-and-end-frame transition prompt

```text
Animate a transition from the starting image to the ending image. [Subject or scene] evolves through [specific action or transformation]. The camera [movement]. [Sound or ambience].
```

### Reference-to-video prompt

```text
@Image1 is [role]. @Video1 provides [motion or staging role]. @Audio1 provides [audio role]. Create [shot or sequence description]. The camera [movement]. [Sound behavior]. Keep the supplied references consistent while composing one coherent result.
```

Omit any label whose media is not supplied. For example, a video-and-audio-only reference prompt should start with `@Video1` and `@Audio1`, not with an invented `@Image1`.

## 9. What the skill should ask the user

Before writing a Seedance 2.0 prompt, the skill should gather:

- which workflow is intended:
  - text-to-video
  - image-to-video
  - start-and-end-frame
  - reference-to-video
  - multi-shot
- the main visible action
- the camera behavior
- whether audio matters
- the key sound event
- the ambient sound bed
- whether there is dialogue
- exact dialogue if needed
- whether references are being used
- what each reference is for
- how many shots are needed
- whether the duration should be exact or can be `auto`

## 10. Sources and provenance

Primary:

- [ByteDance Seedance 2.0 model page](https://seed.bytedance.com/en/seedance2_0)
- [ByteDance Seedance 2.0 official launch post](https://seed.bytedance.com/en/blog/official-launch-of-seedance-2-0)

Supplemental:

- [fal guide: How to use Seedance 2.0](https://fal.ai/learn/tools/how-to-use-seedance-2-0)

Repo-grounding for current Renku contracts:

- `cli/catalog/producers/video/text-to-video.yaml`
- `cli/catalog/producers/video/image-to-video.yaml`
- `cli/catalog/producers/video/start-end-frame-to-video.yaml`
- `cli/catalog/producers/video/ref-image-to-video.yaml`

Notes on confidence:

- The capability profile and multimodal positioning are strongly supported by ByteDance's official materials.
- The most practical prompt-writing rules come from fal's guide and its workflow examples.
- The Renku-specific warnings in this guide come from the local catalog mappings in this repo, not from the vendor docs.
