# Kira Agent Customization

Kira is a local GitHub Copilot customization pack built around a lightweight read-only Kira agent, built-in Plan for reviewable planning, and a single Build agent for tool-heavy execution.

This repository ships installable agents, prompts, instructions, and shared skills, plus the validation and smoke-test tooling needed to keep them trustworthy.

## What Is Included

| Area | Path | Purpose |
| --- | --- | --- |
| Agents | `copilot/agents` | Kira for read-only guidance and Build for execution-heavy local work |
| Prompts | `copilot/prompts` | Reusable entrypoints for planning, review, ADRs, and commit drafting |
| Skills | `copilot/skills` | Shared workflows such as review, architecture, coverage, and ticket intake |
| Instructions | `copilot/instructions` | Reusable convention files for commit style and C# guidance |
| ADRs and docs | `docs` | Decision records, comparisons, issue notes, and examples |
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

The install scripts copy agents, skills, and instructions into `~/.copilot` and copy prompts into the VS Code user prompt directory.

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
- size budgets for the core agent files
- install and uninstall smoke tests in isolated temp directories

## Contribution Flow

1. Make the smallest grounded change.
2. Run `npm run validate` for asset-only changes.
3. Run `npm test` when install behavior, paths, or validation logic changes.
4. Keep agent and prompt growth intentional; the core files have size budgets for a reason.
5. Update docs or examples when behavior changes.

More detailed guidance lives in [CONTRIBUTING.md](CONTRIBUTING.md).

## Example Workflows

- [Plan to build flow](docs/examples/scenarios/plan-to-build-handoff.md)
- [Review-first change workflow](docs/examples/scenarios/review-first-change.md)
- [Ticket to implementation workflow](docs/examples/scenarios/ticket-to-implementation.md)

Concrete sample agent files that are not part of the active shipped configuration live in [docs/examples/agents/plan-review-sample.agent.md](docs/examples/agents/plan-review-sample.agent.md) and [docs/examples/agents/implement-from-plan-sample.agent.md](docs/examples/agents/implement-from-plan-sample.agent.md).

## ADRs

Stable design decisions live in [docs/adr/README.md](docs/adr/README.md).

## Supporting Analysis

- [docs/copilot-billing-cost-analysis.md](docs/copilot-billing-cost-analysis.md)
- [docs/copilot-model-reference-personal.md](docs/copilot-model-reference-personal.md)
- [docs/copilot-workflow-flows-comparison.md](docs/copilot-workflow-flows-comparison.md)
- [docs/copilot-personal-workflow-policy.md](docs/copilot-personal-workflow-policy.md)
- [docs/copilot-workflow-cheat-sheet.md](docs/copilot-workflow-cheat-sheet.md)
- [docs/copilot-plan-vs-custom-agent.md](docs/copilot-plan-vs-custom-agent.md)
