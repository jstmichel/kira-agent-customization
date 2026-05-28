# Kira Agent Customization

Kira is a local GitHub Copilot customization pack built around a single public front door, `Kira`, plus one drafting worker for commit messages and PR descriptions.

This repository currently ships the minimal pack first: two agents, install and uninstall scripts, and validation tooling. Prompts, skills, and instructions are intentionally empty for now so the runtime can grow in smaller steps.

## What Is Included

| Area | Path | Purpose |
| --- | --- | --- |
| Agents | `copilot/agents` | Primary `Kira` front door plus the `Kira Draft` worker used for commit messages and PR descriptions |
| Prompts | `copilot/prompts` | Reserved for future expansion; currently empty |
| Skills | `copilot/skills` | Reserved for future expansion; currently empty |
| Instructions | `copilot/instructions` | Reserved for future expansion; currently empty |
| Customization guide | `copilot/README.md` | Runtime surface and design rules for the current minimal pack |
| Docs | `docs` | Billing, model, and workflow reference notes for the shipped customization pack |
| Validation tooling | `scripts` | Asset validation and install smoke tests |

## Quickstart

### macOS / Linux

```bash
./install.sh
```

### Windows PowerShell

```powershell
.\install.ps1
```

The install scripts copy the current agents into `~/.copilot/agents` and clean up older Kira prompts, skills, and instructions from previous installs.

## Update and Remove

Re-run the install script to refresh an existing setup.

```bash
./install.sh
./uninstall.sh
```

```powershell
.\install.ps1
.\uninstall.ps1
```

For automation and isolated testing, both install and uninstall scripts also respect:

- `KIRA_HOME`
- `VSCODE_PROMPTS_DIR`

## Validate Changes

Node.js 20 or newer is enough; there are no package dependencies.

```bash
npm run validate
npm run test:install
npm test
```

These checks currently verify:

- required frontmatter on active agents, prompts, and skills
- internal relative links across repository markdown
- agent references between shipped agents
- size budgets for the core agent file
- install and uninstall smoke tests for the current minimal pack in isolated temp directories

## Contribution Flow

1. Make the smallest grounded change.
2. Run `npm run validate` for asset-only changes.
3. Run `npm test` when install behavior, paths, or validation logic changes.
4. Keep the visible surface small and grow the runtime deliberately; the core files have size budgets for a reason.
5. Update docs or examples when behavior changes.

More detailed guidance lives in [CONTRIBUTING.md](CONTRIBUTING.md).

## Supporting Analysis

- [docs/copilot-billing-cost-analysis.md](docs/copilot-billing-cost-analysis.md)
- [docs/copilot-model-reference-personal.md](docs/copilot-model-reference-personal.md)
- [docs/copilot-workflow-flows-comparison.md](docs/copilot-workflow-flows-comparison.md)
- [docs/copilot-local-vscode-workflow-guide.md](docs/copilot-local-vscode-workflow-guide.md)
