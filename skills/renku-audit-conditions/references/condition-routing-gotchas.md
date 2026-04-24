# Condition Routing Gotchas

## Unsafe source/consumer mismatch

Bad:

```yaml
- from: SegmentPlainImageProducer[segment][0].GeneratedImage
  to: SeedanceStartEndClipProducer[segment].StartImage
  if: motionIsStartEnd
```

If image 0 is historical-reference based, the plain image producer is skipped, but the StartEnd clip still asks for its output.

Good:

```yaml
motionIsStartEndWithPlainAnchors:
  all:
    - when: PlanDirector.AssetPlan.Segments[segment].MotionPlan.Workflow
      is: StartEnd
    - when: PlanDirector.AssetPlan.Segments[segment].ImagePlans[0].UseHistoricalReference
      is: false
    - when: PlanDirector.AssetPlan.Segments[segment].ImagePlans[1].UseHistoricalReference
      is: false
```

Then use that exact condition for the StartEnd prompt, frame inputs, duration, resolution, clip output, and published output.

## Unused prompt producer branch

Bad: one generic prompt producer runs for every motion-enabled workflow, including Reference, while only Reference-specific prompts feed reference clips.

Good: separate branch-specific prompt producers. Text prompt producer runs only for Text. StartEnd prompt producer runs only for StartEnd with plain anchors. MultiShot prompt producer runs only for MultiShot. Reference prompt producer runs only for Reference.
