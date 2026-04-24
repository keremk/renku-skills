# Inputs YAML Authoring

When editing inputs:

- Preserve existing unrelated values.
- Keep count inputs synchronized with arrays.
- Put model selections in `models:` with exact `producerId`, `provider`, and `model`.
- Do not invent fields the blueprint cannot consume.
- If a prompt-bearing field is model-specific, read the relevant prompt guide first.
- If the blueprint uses a director prompt producer, usually edit high-level director inputs instead of manually recreating every downstream prompt.
