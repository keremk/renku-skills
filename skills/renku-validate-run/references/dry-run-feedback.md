# Dry-Run Feedback

A useful dry-run report includes:

- job count and layer count,
- succeeded/skipped/failed counts,
- producer breakdown by layer,
- condition fields and coverage,
- produced condition paths for branch-heavy blueprints.

For condition-heavy blueprints, dry-run coverage is not decoration. It proves that the simulated plan produced the data needed by conditional routing.
