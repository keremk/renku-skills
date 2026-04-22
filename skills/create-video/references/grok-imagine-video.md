# Grok Imagine Video

The official xAI materials for Grok Imagine Video are useful for capabilities and request shape, but they do not yet provide a rich first-party prompting doctrine comparable to Veo, Wan, or LTX. This guide is therefore intentionally conservative and medium-confidence.

## 1. Model fit

- Provider: xAI
- Modality: Video generation
- Confidence: Medium
- Best for:
  - direct short-form video prompts
  - simple single-beat scenes
  - iterative prompting where the user wants readable natural language

## 2. Capability snapshot that matters to the skill

From the official docs:

- text-driven video generation
- support for short-form cinematic clips
- structured request APIs

The practical implication:

- the skill should keep prompts straightforward and shot-oriented instead of inventing undocumented advanced syntax

## 3. Prompting system from the references

Because xAI does not yet publish a deep first-party prompt formula here, the most defensible structure is:

`Subject + Action + Scene + Camera + Style`

This aligns with the official capability posture and the supplemental guidance.

## 4. Workflow-specific prompting guidance

### A. Standard video generation

Use:

- one subject
- one clear action
- one setting
- one camera behavior
- one style/mood layer

### B. Character moment

Use when:

- a face, reaction, gesture, or short performance beat matters

Operational rule:

- specify the visible action first
- then the camera
- then the mood and lighting

### C. Scenic or atmospheric clip

Use when:

- the segment is mainly environmental

Operational rule:

- keep the visible motion concrete
- specify camera drift, hold, or movement
- do not rely on mood words alone

## 5. What the sources emphasize most

- clear natural-language prompting
- cinematic framing language
- iteration through prompt refinement

## 6. Parameters and constraints that affect prompting

The official material is thinner here than the top-tier vendors.

For the skill, the safest operational rules are:

- do not overcomplicate
- do not assume advanced multi-shot syntax
- keep one segment to one beat unless the blueprint and production plan require otherwise

## 7. Failure modes and fixes

### Failure: clip feels flat

Likely cause:

- no camera behavior or no strong action

Fix:

- add a concrete subject verb and camera move

### Failure: prompt feels ambitious but output feels generic

Likely cause:

- too many abstract mood words and too little staging

Fix:

- rewrite around a visible event

### Failure: clip feels overstuffed

Likely cause:

- too many beats in one short segment

Fix:

- reduce to one scene beat

## 8. Reusable templates for the skill

### Standard prompt

```text
[Subject] [performing one action] in [scene]. The camera [movement or hold]. [Style and lighting].
```

### Character moment

```text
[Character] [visible emotional action or gesture] in [setting]. The camera [shot type and movement]. [Mood and lighting].
```

## 9. What the skill should ask the user

Before writing a Grok Imagine Video prompt, the skill should gather:

- main subject
- one main action
- setting
- camera behavior
- style and lighting

## 10. Sources and provenance

Primary:

- [xAI video generation docs](https://docs.x.ai/developers/model-capabilities/video/generation)
- [Grok Imagine Video model docs](https://docs.x.ai/developers/models/grok-imagine-video)

Supplemental:

- [Grok Imagine prompting guide](https://www.genaintel.com/guides/how-to-prompt-grok-imagine)

Notes on confidence:

- The capability framing is official.
- The prompt structure is a conservative synthesis because xAI has not yet published a richer first-party prompting guide for this model.
