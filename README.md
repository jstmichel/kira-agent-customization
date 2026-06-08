# Kira Agent Customization

Kira is a portable GitHub Copilot and Codex customization pack optimized for a simple, cost-aware workflow:

- one daily-driver agent for normal coding work
- two cheap helper subagents for intake and drafting
- two explicit handoff-only premium agents for difficult architecture review and debugging
- chat-first artifact output, with file writes when saving is the logical outcome

## Agent Surface

### Copilot

- [copilot/agents/kira.agent.md](copilot/agents/kira.agent.md): main daily-driver for planning, coding, refactoring, validation, lightweight review, and routing.
- [copilot/agents/kira-intake.agent.md](copilot/agents/kira-intake.agent.md): hidden low-cost request normalization helper.
- [copilot/agents/kira-draft.agent.md](copilot/agents/kira-draft.agent.md): low-cost drafting helper for commit/PR/ticket/summary and other wording-focused artifacts.
- [copilot/agents/kira-architect.agent.md](copilot/agents/kira-architect.agent.md): handoff-only architecture review specialist.
- [copilot/agents/kira-codex.agent.md](copilot/agents/kira-codex.agent.md): handoff-only deep debugging and implementation rescue specialist.

### Codex

- [codex/agents/kira.toml](codex/agents/kira.toml): low-cost daily-driver user agent for routine coding, planning, validation, and routing.
- [codex/agents/kira-intake.toml](codex/agents/kira-intake.toml): read-only low-cost intake user agent.
- [codex/agents/kira-draft.toml](codex/agents/kira-draft.toml): read-only low-cost drafting user agent.
- [codex/agents/kira-architect.toml](codex/agents/kira-architect.toml): explicit escalation architecture user agent.
- [codex/agents/kira-codex.toml](codex/agents/kira-codex.toml): explicit escalation debugging and implementation rescue user agent.
- [codex/skills](codex/skills): Codex-native reusable workflows converted from the Copilot prompt and skill surface.
- [codex/skills/Architecture](codex/skills/Architecture/SKILL.md): `/Architecture` handoff to `kira-architect`.
- [codex/skills/Codex](codex/skills/Codex/SKILL.md): `/Codex` handoff to `kira-codex`.
- [codex/skills/Draft](codex/skills/Draft/SKILL.md): `/Draft` handoff to `kira-draft`.
- [codex/skills/Intake](codex/skills/Intake/SKILL.md): `/Intake` handoff to `kira-intake`.

## Model Strategy

### Copilot

- `Kira`: `GPT-5.4 mini (copilot)`
- `Kira :: Intake`: `GPT-5 mini (copilot)`
- `Kira :: Draft`: `GPT-5 mini (copilot)`
- `Kira :: Architect`: `GPT-5.4 (copilot)`
- `Kira :: Codex`: `GPT-5.3-Codex (copilot)`

Optional: `Kira :: Architect` can be moved to `GPT-5.5 (copilot)` only when explicitly requested and supported.

### Codex

- `kira`: `gpt-5.4-mini`, low reasoning.
- `kira-intake`: `gpt-5.4-mini`, low reasoning, read-only.
- `kira-draft`: `gpt-5.4-mini`, low reasoning, read-only.
- `kira-architect`: `gpt-5.4`, medium reasoning, explicit escalation only.
- `kira-codex`: `gpt-5.4`, medium reasoning, explicit escalation only.

The Codex setup keeps daily work cheap by default. Higher-cost agents are available, but the guidance tells Kira not to spawn them unless the user explicitly asks for subagents, parallel work, or escalation.

## Invocation Rules

- `Kira` may inline-call only `Kira :: Intake` and `Kira :: Draft`.
- `Kira` must not inline-call `Kira :: Architect` or `Kira :: Codex`.
- `Kira :: Architect` and `Kira :: Codex` are not direct entry points; they are manual escalation paths via handoff buttons.
- `Kira :: Architect` returns decisions and ADR-ready content; `Kira` saves requested ADR/analysis files or implements accepted follow-up work.

## Default Flow

- Start with `Kira` for normal coding work, quick questions, routine planning, and straightforward implementation.
- `Kira :: Intake` is the cheap normalization helper for vague requests, issues, PRs, and tickets.
- `Kira :: Draft` is the cheap wording helper for commit messages, PR descriptions, ticket text, and similar artifacts that do not require a new design decision.
- `Kira :: Architect` is the premium review path for architecture, API, schema, security, and ADR-worthy tradeoffs.
- `Kira :: Codex` is the premium rescue path for repeated failures, non-obvious debugging, and deep multi-file repair loops.
- Artifacts default to fenced markdown blocks when returned in chat.
- When a saved repo document is the logical outcome, such as an ADR or analysis file, `Kira` can write it to disk.

## Prompt Surface

- [copilot/prompts/kira-create-adr.prompt.md](copilot/prompts/kira-create-adr.prompt.md): ADR drafting flow bound to `Kira :: Architect`.
- [copilot/prompts/kira-create-analysis.prompt.md](copilot/prompts/kira-create-analysis.prompt.md): implementation analysis drafting flow bound to `Kira :: Architect`.
- [copilot/prompts/kira-draft-commit.prompt.md](copilot/prompts/kira-draft-commit.prompt.md): commit drafting flow bound to `Kira :: Draft`.
- [copilot/prompts/kira-draft-pr.prompt.md](copilot/prompts/kira-draft-pr.prompt.md): PR drafting flow bound to `Kira :: Draft`.
- [copilot/prompts/kira-draft-ticket.prompt.md](copilot/prompts/kira-draft-ticket.prompt.md): ticket drafting flow bound to `Kira :: Draft`.
- [copilot/prompts/kira-refactor.prompt.md](copilot/prompts/kira-refactor.prompt.md): bounded refactor flow routed through `Kira`.

## Skills and Instructions

- [copilot/skills/kira-ticket-intake/SKILL.md](copilot/skills/kira-ticket-intake/SKILL.md): reusable intake packet workflow for GitHub and Azure sources, including suggested first step and blocking unknowns.
- [copilot/skills/kira-change-docs/SKILL.md](copilot/skills/kira-change-docs/SKILL.md): reusable ADR and analysis drafting workflow.
- [copilot/instructions/kira-core.instructions.md](copilot/instructions/kira-core.instructions.md): core naming, output, and cost discipline.
- [copilot/instructions/kira-drafting.instructions.md](copilot/instructions/kira-drafting.instructions.md): drafting format contracts.
- [copilot/instructions/kira-csharp.instructions.md](copilot/instructions/kira-csharp.instructions.md): scoped C# guidance.
- [codex/instructions/kira-core.md](codex/instructions/kira-core.md): Codex Kira identity, friendly persona, output defaults, and low-cost routing rules.
- [codex/skills](codex/skills): Codex skills for intake, change docs, ADRs, analysis notes, commit drafts, PR drafts, ticket drafts, and bounded refactors.

## Usage Examples

### Kira

```text
Kira, normalize this issue into a compact packet, implement the accepted fix, run validation, and summarize risks.
```

### Kira :: Draft

```text
Draft a PR description from the current branch diff against its parent branch.
```

### Kira Architecture Handoff

```text
Kira, review this schema and API boundary change with Architect before implementation.
```

```text
Kira, get an architecture review for this decision, then save the ADR under docs/adr.
```

```text
/Architecture this change adds tenant-scoped cache keys to the API boundary; review the tradeoffs before implementation.
```

### Kira Debug Handoff

```text
Kira, hand this failing integration test loop to Codex and bring back a focused diagnosis-plus-fix result.
```

## Local Validation

```bash
npm run validate
npm run test:install
```

## Install

Copilot:

```bash
bash install.sh
```

Windows:

```powershell
pwsh -File install.ps1
```

Codex:

```bash
bash install-codex.sh
```

Windows:

```powershell
pwsh -File install-codex.ps1
```

Codex installs user agents to `~/.codex/agents`, user skills to `$HOME/.agents/skills`, and managed Kira guidance to `~/.codex/AGENTS.md`. The Codex installer overwrites any existing `AGENTS.md`.

The Codex installer also installs slash-style handoff skills named `Architecture`, `Codex`, `Draft`, and `Intake` so prompts like `/Architecture this change ...` can spawn the matching Kira user agent.
