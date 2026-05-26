# Kira Agent Customization

Kira is a local GitHub Copilot customization pack built around one Kira custom agent, action-named prompt entrypoints, and shared skills behind those workflows.

This repository ships installable agents, prompts, instructions, and shared skills, plus the validation and smoke-test tooling needed to keep them trustworthy.

## What Is Included

| Area | Path | Purpose |
| --- | --- | --- |
| Agents | `copilot/agents` | Single Kira agent for persona, local execution, planning, review, and route advice |
| Prompts | `copilot/prompts` | Thin entrypoints that delegate to the matching workflow skill |
| Skills | `copilot/skills` | Canonical workflows such as review, architecture, implementation, ticket intake, commit handling, coverage, and EF migrations |
| Instructions | `copilot/instructions` | File-based conventions such as C# behavior |
| Customization guide | `copilot/README.md` | Runtime surface, prompt map, and feature-preserving redesign notes |
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

The install scripts copy the core agent, skills, and instructions into `~/.copilot` and copy prompts into the VS Code user prompt directory.

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
- agent references between active agents
- size budgets for the core agent file
- install and uninstall smoke tests in isolated temp directories

## Contribution Flow

1. Make the smallest grounded change.
2. Run `npm run validate` for asset-only changes.
3. Run `npm test` when install behavior, paths, or validation logic changes.
4. Keep agent and prompt growth intentional; the core files have size budgets for a reason.
5. Update docs or examples when behavior changes.

More detailed guidance lives in [CONTRIBUTING.md](CONTRIBUTING.md).

## Supporting Analysis

- [docs/kira-change-flow.md](docs/kira-change-flow.md)
- [docs/kira-change-flow-next-steps.md](docs/kira-change-flow-next-steps.md)
- [docs/copilot-billing-cost-analysis.md](docs/copilot-billing-cost-analysis.md)
- [docs/copilot-model-reference-personal.md](docs/copilot-model-reference-personal.md)
- [docs/copilot-workflow-flows-comparison.md](docs/copilot-workflow-flows-comparison.md)
- [docs/copilot-local-vscode-workflow-guide.md](docs/copilot-local-vscode-workflow-guide.md)
