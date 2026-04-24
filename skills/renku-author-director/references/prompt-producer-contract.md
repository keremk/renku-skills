# Prompt Producer Contract

Valid `producer.yaml` shape:

```yaml
meta:
  name: Director
  description: Generates structured prompts and plan fields
  id: DirectorProducer
  kind: producer
  version: 0.1.0
  promptFile: ./prompts.toml
  outputSchema: ./output-schema.json

inputs:
  - name: InquiryPrompt
    type: string
    required: true

outputs:
  - name: AssetPlan
    type: json
```

Do not use old top-level `type`, `artifacts`, `prompts`, or `output` sections.

TOML variables must exactly match YAML input names.

Output schema should be strict, with `additionalProperties: false` and all required fields declared explicitly.
