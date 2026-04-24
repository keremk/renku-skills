# Error Codes

Use Renku numbered errors and helpers. Do not throw ad-hoc unnumbered errors for validation/runtime failures.

Useful categories:

- `Pxxx`: parser/load errors.
- `Vxxx`: static blueprint validation errors.
- `Wxxx`: non-blocking validation warnings.
- `Rxxx`: planning/runtime errors.
- `Sxxx`: SDK/provider errors.

When adding validation behavior, add tests that assert the specific error code.
