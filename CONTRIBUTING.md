# Contributing

## Scope

This repository is a Copilot customization pack, not an application runtime. Most changes are markdown assets, install scripts, or workflow scaffolding.

Keep changes small, explicit, and easy to validate.

## Local Setup

Use Node.js 20 or newer.

```bash
npm run validate
npm run test:install
```

The validation tooling has no external package dependencies.

## Change Rules

- Prefer the smallest change that proves the intended behavior.
- Keep agent and prompt text intentional; extra context has direct token cost.
- Preserve current file naming patterns for agents, prompts, skills, and instructions.
- Update documentation examples when workflow behavior changes.
- If you touch install or uninstall behavior, run `npm test`.

## Validation Expectations

Run the narrowest useful check before opening a pull request:

- `npm run validate` for markdown, frontmatter, links, and handoff changes
- `npm run test:install` for install-path or script changes
- `npm test` when both surfaces changed or when in doubt

## Hooks

An optional pre-commit hook is included in `.githooks/pre-commit`.

```bash
git config core.hooksPath .githooks
chmod +x .githooks/pre-commit
```

The hook runs `npm run validate`.

## Pull Requests

Use the pull request template and include:

- the user-visible behavior change
- the validation commands you ran
- any token budget or file growth tradeoffs for agent or prompt edits

## Release Notes

Call out these items when they change:

- install or uninstall behavior
- new or renamed agents, prompts, skills, or instructions
- validation rule changes
- workflow or routing behavior changes
