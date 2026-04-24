# Model Contract Checklist

Before recommending a model:

1. Search catalog producer mappings for the exact model name.
2. Confirm provider and model ID in `catalog/models/<provider>/<provider>.yaml`.
3. Confirm the producer exposes every input the workflow needs.
4. Confirm duration, resolution, aspect ratio, reference count, and audio controls.
5. Record required config explicitly in `models:`.
6. If the model supports a vendor feature that the producer does not expose, treat it as unavailable for this blueprint.

Do not use model names from memory. Catalog mappings are the source of truth.
