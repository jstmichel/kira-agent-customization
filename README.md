# Kira Agent Customization

Kira is a portable GitHub Copilot customization pack optimized for a simple, cost-aware workflow:

- one daily-driver agent for normal coding work
- two cheap helper subagents for intake and drafting
- two explicit handoff-only premium agents for difficult architecture and debugging

## Agent Surface

- [copilot/agents/kira.agent.md](copilot/agents/kira.agent.md): main daily-driver for planning, coding, refactoring, validation, lightweight review, and routing.
- [copilot/agents/kira-intake.agent.md](copilot/agents/kira-intake.agent.md): hidden low-cost request normalization helper.
- [copilot/agents/kira-draft.agent.md](copilot/agents/kira-draft.agent.md): low-cost drafting helper for commit/PR/ADR/ticket/summary text.
- [copilot/agents/kira-architect.agent.md](copilot/agents/kira-architect.agent.md): handoff-only architecture specialist.
- [copilot/agents/kira-codex.agent.md](copilot/agents/kira-codex.agent.md): handoff-only hard implementation/debugging specialist.

## Model Strategy

- `Kira`: `GPT-5.4 mini (copilot)`
- `Kira :: Intake`: `GPT-5 mini (copilot)`
- `Kira :: Draft`: `GPT-5 mini (copilot)`
- `Kira :: Architect`: `GPT-5.4 (copilot)`
- `Kira :: Codex`: `GPT-5.3-Codex (copilot)`

Optional: `Kira :: Architect` can be moved to `GPT-5.5 (copilot)` only when explicitly requested and supported.

## Invocation Rules

- `Kira` may inline-call only `Kira :: Intake` and `Kira :: Draft`.
- `Kira` must not inline-call `Kira :: Architect` or `Kira :: Codex`.
- `Kira :: Architect` and `Kira :: Codex` are manual escalation paths via handoff buttons.

## Prompt Surface

- [copilot/prompts/kira-create-adr.prompt.md](copilot/prompts/kira-create-adr.prompt.md): ADR drafting flow bound to `Kira :: Architect`.
- [copilot/prompts/kira-create-analysis.prompt.md](copilot/prompts/kira-create-analysis.prompt.md): implementation analysis drafting flow bound to `Kira :: Architect`.
- [copilot/prompts/kira-draft-commit.prompt.md](copilot/prompts/kira-draft-commit.prompt.md): commit drafting flow bound to `Kira :: Draft`.
- [copilot/prompts/kira-draft-pr.prompt.md](copilot/prompts/kira-draft-pr.prompt.md): PR drafting flow bound to `Kira :: Draft`.
- [copilot/prompts/kira-draft-ticket.prompt.md](copilot/prompts/kira-draft-ticket.prompt.md): ticket drafting flow bound to `Kira :: Draft`.
- [copilot/prompts/kira-refactor.prompt.md](copilot/prompts/kira-refactor.prompt.md): bounded refactor flow routed through `Kira`.

## Skills and Instructions

- [copilot/skills/kira-ticket-intake/SKILL.md](copilot/skills/kira-ticket-intake/SKILL.md): reusable intake packet workflow for GitHub and Azure sources.
- [copilot/skills/kira-change-docs/SKILL.md](copilot/skills/kira-change-docs/SKILL.md): reusable ADR and analysis drafting workflow.
- [copilot/instructions/kira-core.instructions.md](copilot/instructions/kira-core.instructions.md): core naming, output, and cost discipline.
- [copilot/instructions/kira-drafting.instructions.md](copilot/instructions/kira-drafting.instructions.md): drafting format contracts.
- [copilot/instructions/kira-csharp.instructions.md](copilot/instructions/kira-csharp.instructions.md): scoped C# guidance.

## Usage Examples

### Kira

```text
Kira, normalize this issue into a compact packet, implement the accepted fix, run validation, and summarize risks.
```

### Kira :: Draft

```text
Draft a PR description from the current branch diff against its parent branch.
```

### Kira :: Architect

```text
Review this schema and API boundary change and provide decision constraints before implementation.
```

### Kira :: Codex

```text
Take over this failing integration test loop and deliver a focused diagnosis-plus-fix result.
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

Windows:

```powershell
pwsh -File install.ps1
```