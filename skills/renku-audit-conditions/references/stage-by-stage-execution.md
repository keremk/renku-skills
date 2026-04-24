# Stage-By-Stage Execution

Users often run layer by layer with `--up` or `--up-to-layer`.

Validation and runtime plan safety must not fail because a later-layer dependency is not scheduled yet. Only validate dependencies for jobs in the active scheduled scope.

Regression scenario:

- Layer 0 produces an upstream artifact.
- Layer 1 consumes it.
- A stage-0 run schedules only layer 0.
- Runtime dependency safety should not inspect layer-1 consumers as if they were scheduled.

When changing scheduler safety, add or check a regression test for this behavior.
