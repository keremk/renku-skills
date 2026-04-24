# Validation Checklist

For catalog or reusable blueprint work:

```bash
pnpm --filter @gorenku/cli exec tsx src/cli.tsx blueprints:validate <blueprint.yaml>
pnpm --filter @gorenku/cli exec tsx src/cli.tsx generate --blueprint=<blueprint.yaml> --inputs=<inputs.yaml> --preflight-only
pnpm --filter @gorenku/cli exec tsx src/cli.tsx generate --blueprint=<blueprint.yaml> --inputs=<inputs.yaml> --dry-run
```

If source code changed in the Renku repo, finish with:

```bash
pnpm build
pnpm test
```

For stage-by-stage workflows, also preflight and dry-run the relevant layer controls the user will use.

Report warnings. Do not hide them just because validation exits successfully.
