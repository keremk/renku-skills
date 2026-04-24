# Blueprint Warning And Error Gotchas

Use this when validation succeeds with warnings, or when a dry-run fails before provider calls.

## Removed Or Stale Authoring Patterns

### `collectors:`

Do not add top-level `collectors:`. Fan-in is inferred from connections into producer inputs declared as fan-in capable.

Fix:

```yaml
connections:
  - from: ImageProducer[segment].GeneratedImage
    to: TimelineComposer.ImageSegments
```

### Authored `artifacts:`

Top-level authored blueprints should use `outputs:` for published artifacts. Runtime manifests still use canonical `Artifact:...` IDs, but authored YAML should not use legacy top-level `artifacts:`.

## Unused Warnings

### Unused Input

On top-level orchestration blueprints, unused inputs usually mean one of:

- the input should be wired to a producer,
- the input should be used as a loop `countInput`,
- the input should be removed,
- the corresponding input-template value should also be removed.

Producer contracts are different: a producer may declare inputs consumed by runtime/provider code. Do not delete producer contract inputs just to silence a top-level-style warning unless validation and contract review prove they are truly unused.

### Unused Output

An output declaration is useful only if it is wired from a producer or child blueprint. Asset-only blueprints may legitimately end at published outputs; they do not need timeline/exporter consumers.

### Unreachable Producer

An imported producer with no incoming required inputs is usually dead graph. Either wire it, remove it, or confirm it is intentionally triggered by system/runtime inputs.

## Cross-Dimension Collection Conflicts

When broadcasting a collection to each looped producer instance, wire the whole collection:

```yaml
- from: StyleReferenceImages
  to: CharacterImageProducer[character].SourceImages
```

Do not add a second loop dimension just to pass each collection element:

```yaml
# Bad shape for whole-collection broadcast
- from: StyleReferenceImages[styleImage]
  to: CharacterImageProducer[character].SourceImages[styleImage]
```

Use element indexing only when each producer instance needs one specific element:

```yaml
- from: CharacterImages[character]
  to: CharacterVideoProducer[character].ReferenceImages[0]
```

## Condition Path Failures

If a condition path fails prepared/viewer validation:

- verify the referenced field is produced by a prepared graph artifact,
- verify fixed indexes like `[0]` and `[1]` are compatible with schema-derived array paths,
- verify the director schema actually emits the field,
- do not replace missing paths with fallback/default logic.

## Wrong Model Names

Exact model names matter. Look them up in the current provider catalog and producer mapping before writing `models:`.

Symptoms of wrong model IDs include dry-run/runtime errors such as no handler or no mapping for the provider/model pair.

## Delivery Checklist

Before final handoff:

- validation has no unexplained warnings,
- dry-run succeeds,
- condition-heavy branches show produced condition paths,
- stage-limited path is tested when users will run layer by layer,
- the output summary tells the user what remains intentionally out of scope.
