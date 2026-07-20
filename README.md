# Kira Agent Customization

Repository for small, cost-efficient Copilot and OpenCode customizations.

## Core Rules

- Follow the repo instructions in `.github/copilot-instructions.md`.
- Keep instructions, prompts, and skills short.
- Prefer the smallest workable context and the fewest tool calls.
- Keep output to the required minimum.

## Capabilities


- `create-flow` prompt: user-facing entry point for creating a minimal user-wide installable flow package.
- `Architecture` agent: creates ADRs, implementation plans, and structured architecture or infrastructure analysis in a copy-pasteable markdown block.
- `Drafter` agent: drafts commit messages, PR descriptions, tickets, ADRs, and other supporting markdown documents without writing code.
- `draft-*` and `write-supporting-doc` skills: reusable drafting workflows for repo-grounded commit, PR, ticket, and document work.
- `flow-creation` skill: reusable execution workflow for building or updating small user-wide installable flow packages.

All repository-wide flow files must live under `.github/`.

## Layout

- `copilot/agents` for source copies used by the install scripts.
- `copilot/prompts` for source copies used by the install scripts.
- `copilot/skills` for source copies used by the install scripts.
- `opencode/commands` for source copies of user-level OpenCode commands.
- `opencode/agents` for source copies of user-level OpenCode agents.
- `opencode/skills` for reusable OpenCode workflows used by commands and agents.
- `.github/agents`, `.github/prompts`, and `.github/skills` for repository-wide customizations.
- `docs` for workflow and billing guidance.

## Install

Use the repo install scripts to copy customization files into the local Copilot and OpenCode locations.

```bash
bash install.sh
bash update.sh
bash uninstall.sh
```

On Windows, run the corresponding `install.ps1`, `update.ps1`, or `uninstall.ps1` script in PowerShell. Set `KIRA_HOME`, `VSCODE_PROMPTS_DIR`, or `OPENCODE_HOME` to override the default user-level destinations. Restart OpenCode after installing, updating, or uninstalling so it reloads customization files.

OpenCode commit commands:

- `/draft-commit` drafts one Conventional Commit message and does not modify the worktree.
- `/commit` drafts a message, stages the intended changes, and creates the commit.

Both commands use the shared `draft-commit-message` skill and a low-cost model. Run `bash update.sh` or `update.ps1` to install the latest command and skill sources.
