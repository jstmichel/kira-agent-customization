# Kira Agent Customization

Kira is a GitHub Copilot customization pack for ticket intake, planning, implementation, testing, and delivery drafting with explicit cost and tool discipline.

The current scaffold ships agents, instructions, prompt files, and skills. Broader surface expansion still follows the workflow map.

## Current Surface

- [copilot/agents/kira.agent.md](copilot/agents/kira.agent.md): read-only coordinator for backlog intake, lightweight questions, and routing.
- [copilot/agents/kira-packet.agent.md](copilot/agents/kira-packet.agent.md): hidden ticket-packet helper for GitHub and Azure CLI intake.
- [copilot/agents/kira-mapper.agent.md](copilot/agents/kira-mapper.agent.md): visible planning and architecture specialist.
- [copilot/agents/kira-forge.agent.md](copilot/agents/kira-forge.agent.md): visible implementation and refactor specialist.
- [copilot/agents/kira-probe.agent.md](copilot/agents/kira-probe.agent.md): visible testing and coverage specialist.
- [copilot/agents/kira-diff.agent.md](copilot/agents/kira-diff.agent.md): callable drafting specialist for commits, PRs, ADR cleanup, and ticket updates.
-- [copilot/instructions/kira-core.instructions.md](copilot/instructions/kira-core.instructions.md): identity, naming, output rules, workflow routing, and cost/token discipline.
- [copilot/instructions/kira-drafting.instructions.md](copilot/instructions/kira-drafting.instructions.md): drafting format contracts.
- [copilot/instructions/kira-csharp.instructions.md](copilot/instructions/kira-csharp.instructions.md): scoped C# coding guidance that only loads on matching files.
- [copilot/prompts/kira-create-adr.prompt.md](copilot/prompts/kira-create-adr.prompt.md): ADR draft prompt for Mapper-style planning work.
- [copilot/prompts/kira-create-analysis.prompt.md](copilot/prompts/kira-create-analysis.prompt.md): analysis-note prompt for pre-implementation reasoning.
- [copilot/prompts/kira-draft-commit.prompt.md](copilot/prompts/kira-draft-commit.prompt.md): commit draft prompt that defaults to the current worktree.
- [copilot/prompts/kira-draft-pr.prompt.md](copilot/prompts/kira-draft-pr.prompt.md): PR draft prompt for branch-versus-parent comparisons.
- [copilot/prompts/kira-draft-ticket.prompt.md](copilot/prompts/kira-draft-ticket.prompt.md): ticket content prompt for plans, requests, and updates.
- [copilot/prompts/kira-refactor.prompt.md](copilot/prompts/kira-refactor.prompt.md): bounded refactor prompt for Forge-style implementation work.
- [copilot/skills/kira-ticket-intake/SKILL.md](copilot/skills/kira-ticket-intake/SKILL.md): reusable ticket-intake workflow for GitHub and Azure CLI sources.
- [copilot/skills/kira-change-docs/SKILL.md](copilot/skills/kira-change-docs/SKILL.md): reusable ADR and analysis documentation workflow.

See [docs/kira-workflow-asset-map.md](docs/kira-workflow-asset-map.md) for the full planned surface and handoff model.

## Design Defaults

- `Kira` is read-only. It can read `todo.md`, attached files, and local docs, but it should not edit files or use the terminal to implement changes.
- Visible specialists own planning, coding, and testing.
- Hidden helpers are reserved for packetization; drafting can take the shortest path through `Kira :: Diff` directly.
- Prompt files pin the intended agent in frontmatter for installed use.
- In this source repository, editor diagnostics may still not resolve those custom agent names until the assets are installed into VS Code's discovered locations.
- Draft artifacts should be emitted in fenced code blocks.

## Instruction Precedence

- This repository keeps a small [copilot-instructions.md](copilot-instructions.md) so repo-local guidance wins without adding much always-on cost.
- Repo-local `copilot-instructions.md`, `.github/copilot-instructions.md`, `AGENTS.md`, and scoped repo instructions should override installed Kira defaults when both apply.
- Installed Kira instructions remain the user-level fallback when a repo does not provide local guidance for the active task.
- Language-specific rules such as [copilot/instructions/kira-csharp.instructions.md](copilot/instructions/kira-csharp.instructions.md) stay scoped with `applyTo` so unrelated sessions do not pay for them.

## Examples

### Kira

```text
Kira, read todo.md and tell me whether this request should go to planning, implementation, testing, or drafting.
```

```text
Kira, draft a commit message from the current worktree and a PR description against the parent branch.
```

### Kira :: Diff

```text
Draft a commit message from the current worktree and a PR description against the parent branch.
```

### Kira :: Mapper

```text
Create an implementation plan for ticket 142 and include an ADR draft plus an analysis note.
```

### Kira :: Forge

```text
Implement the approved plan for the CLI parser and run the narrowest relevant validation after the first edit.
```

### Kira :: Probe

```text
Add unit tests for the parser change and tell me whether this repo exposes a coverage command.
```

### Prompt files

```text
/kira-create-adr ticket 142
```

```text
/kira-draft-pr
```

### Skills

```text
/kira-ticket-intake github issue 142
```

```text
/kira-change-docs ticket 142
```

## Local Validation

```bash
npm run validate
npm run test:install
```

## Install

```bash
bash install.sh
```

On Windows:

```powershell
pwsh -File install.ps1
```
