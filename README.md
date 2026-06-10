# Kira Agent Customization

Repository for small, cost-efficient Copilot customizations.

## Core Rules

- Follow the repo instructions in `.github/copilot-instructions.md`.
- Keep instructions, prompts, and skills short.
- Prefer the smallest workable context and the fewest tool calls.
- Keep output to the required minimum.

## Capabilities


- `create-flow` prompt: user-facing entry point for creating a minimal user-wide installable flow package.
- `flow-creation` skill: reusable execution workflow for building or updating small user-wide installable flow packages.

All repository-wide flow files must live under `.github/`.

## Layout

- `copilot/agents` for source copies used by the install scripts.
- `copilot/prompts` for source copies used by the install scripts.
- `copilot/skills` for source copies used by the install scripts.
- `.github/agents`, `.github/prompts`, and `.github/skills` for repository-wide customizations.
- `docs` for workflow and billing guidance.

## Install

Use the repo install scripts to copy the customization files into the local Copilot locations.