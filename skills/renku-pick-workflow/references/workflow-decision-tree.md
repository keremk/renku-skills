# Workflow Decision Tree

## Video

- Text-to-video: no visual anchor is required.
- Image-to-video: one source image anchors identity/layout.
- Start/end-frame: both source and destination frames are available and should be used.
- Reference-to-video: one or more references define identity, style, product, character, or environment.
- Multi-shot: one generation should contain structured shots or cuts.
- Talking head/lipsync: speech fidelity and face motion are central.

## Images

- Text-to-image: generate from prompt only.
- Image edit: modify one source image.
- Image compose: combine multiple source images.
- Storyboard/grid: generate multiple panels in one image when the blueprint extracts panels.

## Audio

- TTS: narration/dialogue needs reliable spoken audio.
- Native video audio: ambience, effects, simple speech, or tightly integrated sound are part of the video generation.
- Music: background music is requested explicitly.

Pick the workflow that exposes the needed control directly. Do not fake a missing control in the prompt.
