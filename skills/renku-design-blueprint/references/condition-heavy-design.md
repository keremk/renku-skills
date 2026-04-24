# Condition-Heavy Design

Use this before adding optional branches.

## Design rule

Every branch has three separate questions:

1. When is the producer scheduled?
2. When is each output consumed?
3. When is each published output emitted?

The answer must match. If a consumer can run when the source producer is skipped, the graph is unsafe.

## Split producers when needed

If a single prompt producer feeds Text, StartEnd, MultiShot, and Reference but those branches have different activation rules, split the producer import by branch. This is clearer and avoids unused model calls.

## Start/end anchors

A start/end video producer that consumes generated stills must be gated not only on `Workflow=StartEnd`, but also on the conditions that prove the start and end images are actually produced.
