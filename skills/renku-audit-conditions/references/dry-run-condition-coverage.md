# Dry-Run Condition Coverage

Dry-run validation should prove condition paths are produced and varied.

Look for:

- The condition field appears in the dry-run condition coverage list.
- Boolean condition fields have both true and false outcomes when dual-outcome coverage is required.
- Fixed item paths such as `ImagePlans[0].UseHistoricalReference` and `ImagePlans[1].UseHistoricalReference` appear when branch logic depends on them.
- Produced condition paths show concrete artifact paths and values.

If a condition field has no produced paths, the dry-run did not actually exercise the branch logic.
