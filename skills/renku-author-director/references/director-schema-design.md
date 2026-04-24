# Director Schema Design

A director schema is part of the graph contract.

Include fields when they are:

- wired to downstream producers,
- used in conditions,
- published as planning metadata,
- needed as array structure for looped outputs.

Do not include fields only because they help the model think. Put reasoning instructions in the system prompt instead.

For conditional fields, prefer explicit empty strings, false booleans, or empty arrays for inactive branches. Never emit `N/A` if that value could reach an SDK prompt.
