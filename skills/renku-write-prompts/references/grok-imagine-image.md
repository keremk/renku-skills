# Grok Imagine Image

The official xAI image docs are stronger on capability and workflow than on explicit prompt formulas. The supplemental GenAIntel guide fills some of that gap. This guide should therefore be treated as medium-confidence and more conservative than the Google or Black Forest Labs guides.

## 1. Model fit

- Provider: xAI
- Modality: Image generation and editing
- Confidence: Medium
- Best for:
  - direct text-to-image prompts
  - iterative multi-turn editing
  - multi-image merging or composite edits
  - workflows where natural-language prompting is acceptable

## 2. Capability snapshot that matters to the skill

From the official docs:

- text-to-image generation
- image editing
- multi-image editing
- multi-turn iterative editing
- control over aspect ratio and resolution
- up to 5 images for editing in one request
- output aspect ratio can follow the first input image or be overridden

## 3. Prompting system from the references

There is no strong first-party xAI prompt formula yet. The safest standardized approach is:

### Primary formula

`Scene + Style + Mood + Lighting + Camera`

This comes from the supplemental guide and aligns with the natural-language examples in the official docs.

### Composition rule

The supplemental guidance strongly recommends:

- specifying framing
- using photographic language
- stating camera or lens feel when it matters

### Editing rule

The supplemental guide's strongest practical rule is:

- state what must remain unchanged
- specify the added or changed detail precisely

This aligns with the official xAI editing workflow.

## 4. Workflow-specific prompting guidance

### A. Text-to-image

Use direct natural language with:

- clear subject
- clear setting
- clear style
- visible lighting
- framing or camera note

### B. Image editing

The official docs support editing by providing a source image plus a prompt.

Operational rule:

- describe the desired transformed end state
- preserve face, pose, composition, or layout explicitly when needed

### C. Multiple-image editing

The official docs support combining several source images.

Operational rule:

- tell the model how the subjects should appear together
- state the final scene
- explicitly avoid unwanted additions

### D. Multi-turn editing

The official docs explicitly support iterative edits.

Operational rule:

- make one targeted change at a time
- keep the core scene stable
- adjust lighting, framing, mood, or one detail per turn

## 5. What the sources emphasize most

- Natural-language prompts work well.
- Composition language helps.
- Editing works better when preservation rules are explicit.
- Iteration should happen through small changes.

## 6. Parameters and constraints that affect prompting

From the official docs:

- image editing can use one source image
- multiple-image editing can use up to 5 images
- aspect ratio can be overridden

For the skill:

- do not overload Grok Imagine Image with overly baroque prompt structures
- use precise but readable prose
- when merging images, explicitly say how the subjects should appear together

## 7. Failure modes and fixes

### Failure: output is generic

Likely cause:

- insufficient scene, lighting, or camera detail

Fix:

- rewrite using the five-part structure

### Failure: edit drifts from the original

Likely cause:

- preservation rules were omitted

Fix:

- specify what must remain unchanged

### Failure: merged image introduces unwanted elements

Likely cause:

- the final composite scene was under-specified

Fix:

- describe the final arrangement and explicitly rule out extra subjects if needed

## 8. Reusable templates for the skill

### Standard prompt

```text
Scene: [what is happening]. Style: [visual style]. Mood: [emotional direction]. Lighting: [light quality and time]. Camera: [framing / lens / focus].
```

### Edit prompt

```text
Keep [face / pose / layout / composition] unchanged. Add or change [specific detail]. Do not change [camera angle or overall scene structure].
```

### Multi-image merge prompt

```text
Show all provided subjects together in [final scene]. Arrange them as [composition]. Use [lighting and mood]. No additional people or animals.
```

## 9. What the skill should ask the user

Before writing a Grok Imagine Image prompt, the skill should gather:

- scene
- style
- mood
- lighting
- camera or framing
- whether this is generation, edit, or merge
- what must stay unchanged

## 10. Sources and provenance

Primary:

- [xAI image generation docs](https://docs.x.ai/developers/model-capabilities/images/generation)

Supplemental:

- [Grok Imagine prompting guide](https://www.genaintel.com/guides/how-to-prompt-grok-imagine)

Notes on confidence:

- The workflow and capability guidance are official.
- The explicit five-part prompt formula and some editing heuristics come from the supplemental guide.
