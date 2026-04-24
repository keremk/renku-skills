# Prompt Failure Fixes

## Lifeless motion

Cause: prompt describes a static image.

Fix: add one concrete action, one camera move, and temporal progression.

## Reference ignored

Cause: references have no assigned roles.

Fix: say what each exposed reference contributes, such as character identity, environment, product, or style.

## Source image drift

Cause: prompt tries to replace the source scene.

Fix: treat the source image as anchor; describe motion and camera change.

## Multi-shot collapse

Cause: shots are not labeled or duration is too short.

Fix: label shots and reduce shot count or increase duration.

## Audio mismatch

Cause: prompt lacks specific sound timing or source.

Fix: state key sound event, ambience, speaker, tone, and turn-taking when relevant.
