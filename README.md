# Renku Skills

This repository is a standalone skills/plugin package for working with the Renku CLI and Renku video-generation workflows.

It was split out from the main Renku codebase so teams can install and share the Renku blueprint and video-workflow layer without distributing the full repository.

Important: these skills assume you already have the Renku CLI installed and configured. Without the CLI, they are not useful.

## Install Renku CLI first

- Website: https://gorenku.com
- Source code: https://github.com/keremk/renku

After installing, verify:

```bash
renku --version
```

If this is your first Renku setup, initialize your workspace:

```bash
renku init --root=~/renku-workspace
```

## What is in this repo

```text
.
├── .agents/
│   └── plugins/
│       └── marketplace.json
├── .codex-plugin/
│   └── plugin.json
├── .claude-plugin/
│   ├── plugin.json
│   └── marketplace.json
├── agents/
│   ├── director-prompt-engineer.md
│   └── model-picker.md
└── skills/
    ├── create-blueprint/
    ├── director-prompt-engineer/
    └── model-picker/
```

- `skills/` contains the reusable skill definitions (`SKILL.md` + references)
- `agents/` contains Claude Code subagents used by the skills
- `.claude-plugin/plugin.json` is the Claude Code plugin manifest
- `.claude-plugin/marketplace.json` lets you install this plugin through Claude's marketplace flow (local or Git-hosted)
- `.codex-plugin/plugin.json` is the Codex plugin manifest
- `.agents/plugins/marketplace.json` is the repo-scoped Codex marketplace entry that points back to this repo root

## Quick start

1. Clone this repository.
2. Install and verify Renku CLI (above).
3. Install skills in your coding tool of choice (sections below).

## Install in Claude Code CLI

You can use either a session-only load or an installed plugin.

### Option A: Session-only (fastest)

```bash
claude --plugin-dir /absolute/path/to/this/repo
```

### Option B: Installed plugin (recommended)

Inside Claude Code, run:

```text
/plugin marketplace add /absolute/path/to/this/repo
/plugin install renku-plugin@renku-skills
```

Then reload plugins:

```text
/reload-plugins
```

Use skills with namespaced commands such as:

```text
/renku-plugin:create-blueprint
```

## Install in Claude Code desktop app

Claude Code desktop uses the same plugin system as CLI.

1. Open a local Code session.
2. Use either:
   - the **Plugins** menu in the `+` prompt menu, or
   - slash commands (`/plugin ...`) directly in the session.
3. Add/install this plugin with:

```text
/plugin marketplace add /absolute/path/to/this/repo
/plugin install renku-plugin@renku-skills
/reload-plugins
```

## Install in Codex CLI

This repo now supports two Codex installation styles.

### Option A: Install as a Codex plugin

From the Codex docs, the current plugin flow starts by adding a marketplace source. Because this repo now includes a repo marketplace at `.agents/plugins/marketplace.json`, you can add the repo itself as a marketplace root:

```bash
codex plugin marketplace add /absolute/path/to/this/repo
```

Then restart Codex, open the plugin directory, choose the marketplace, and install `renku-plugin`. The plugin will expose the existing shared `skills/` tree from this repo.

This uses:

- `.codex-plugin/plugin.json` as the Codex plugin manifest
- `.agents/plugins/marketplace.json` as the Codex marketplace catalog

### Option B: Load the skills directly

Codex also loads skills from `~/.agents/skills` (user scope) and from `.agents/skills` in repositories. If you only want the skills, without using the plugin marketplace flow, you can still symlink them directly.

Recommended from this repo root:

```bash
./scripts/install-codex-skills.sh
```

To remove only the symlinks created by this repo later:

```bash
./scripts/uninstall-codex-skills.sh
```

Manual equivalent:

```bash
mkdir -p ~/.agents/skills
for s in /absolute/path/to/this/repo/skills/*; do ln -sfn "$s" ~/.agents/skills/"$(basename "$s")"; done
```

Then start Codex and verify skills are visible:

```text
/skills
```

Invoke directly with skill syntax, for example:

```text
$create-blueprint
```

## Install in Codex app

Codex app uses the same plugin and skill locations as Codex CLI.

### Option A: As a plugin

1. Add this repo as a marketplace root:

```bash
codex plugin marketplace add /absolute/path/to/this/repo
```

2. Restart Codex app.
3. Open the plugin directory and select the marketplace from this repo.
4. Install `renku-plugin`.

### Option B: As direct skills

1. Install skills to `~/.agents/skills` with `./scripts/install-codex-skills.sh`.
2. Open or restart Codex app.
3. Open **Skills** in the sidebar to confirm they loaded.
4. Invoke with `$<skill-name>` such as `$create-blueprint`.

## Notes on compatibility

- Claude Code uses this repo as a plugin (`.claude-plugin`, `agents/`, `skills/`).
- Codex can now use this repo as a plugin (`.codex-plugin`, `.agents/plugins/marketplace.json`) or consume the `skills/*` directories directly via `.agents/skills` or `~/.agents/skills`.
- The same skill content is shared across both tools.
