# Director To Graph Alignment

Before finalizing a director:

1. For each schema field, identify the blueprint connection or published output that consumes it.
2. For each condition path, confirm the director produces it in every required array item.
3. For each looped array, confirm its length matches the corresponding loop count.
4. For each model-specific workflow branch, confirm the director emits only fields the branch can consume.
5. Run validation and dry-run, then inspect produced condition paths.

If a field cannot be traced to graph usage, remove it or publish it intentionally.
