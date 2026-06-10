# Kira Agent Customization

Kira is a portable GitHub Copilot customization pack optimized for a simple, cost-aware workflow.

## Copilot

The `copilot/` surface is now built around two modes in `Kira`:

- Ask mode: direct, concise, human answers for questions.
- Task mode: compact task reframing, then direct execution, helper delegation, or escalation.

Visible handoffs in `Kira` are:

- `Review with Architect`
- `Code`

For full Copilot flow details, see [copilot/README.md](copilot/README.md).

## Agent Surface

### Copilot

- [copilot/agents/kira.agent.md](copilot/agents/kira.agent.md): main daily-driver for planning, coding, refactoring, validation, lightweight review, and routing.
- [copilot/agents/kira-intake.agent.md](copilot/agents/kira-intake.agent.md): hidden low-cost request normalization helper.
- [copilot/agents/kira-draft.agent.md](copilot/agents/kira-draft.agent.md): low-cost drafting helper for commit/PR/ticket/summary and other wording-focused artifacts.
- [copilot/agents/kira-code.agent.md](copilot/agents/kira-code.agent.md): low-cost handoff coding specialist.
- [copilot/agents/kira-architect.agent.md](copilot/agents/kira-architect.agent.md): handoff-only architecture review specialist.

## Model Strategy

### Copilot

- `Kira`: `GPT-5.4 mini (copilot)`
- `Kira :: Intake`: `GPT-5 mini (copilot)`
- `Kira :: Draft`: `GPT-5 mini (copilot)`
- `Kira :: Code`: `GPT-5.4 mini (copilot)`
- `Kira :: Architect`: `GPT-5.4 (copilot)`

Optional: `Kira :: Architect` can be moved to `GPT-5.5 (copilot)` only when explicitly requested and supported.

## Invocation Rules

- `Kira` may inline-call only `Kira :: Intake` and `Kira :: Draft`.
- `Kira` must not inline-call `Kira :: Architect`.
- `Kira :: Code` and `Kira :: Architect` are handoff paths via frontmatter buttons.
- `Kira :: Architect` returns decisions and ADR-ready content; `Kira` saves requested ADR/analysis files or implements accepted follow-up work.

## Default Flow

- Start with `Kira`.
- Ask mode handles direct Q&A.
- Task mode handles implementation or drafting work with compact reframing.
- `Code` is the low-cost coding handoff path using `GPT-5.4 mini (copilot)`.
- `Kira :: Intake` remains the low-cost normalization helper for vague requests and external work items.
- `Kira :: Draft` is the low-cost inline artifact helper for commit, PR, ticket, ADR, analysis, and code snippet outputs in chat.
- `Kira :: Architect` is the premium review path for design and ADR-level decisions.

## Prompt Surface

- [copilot/prompts/kira-customize-copilot.prompt.md](copilot/prompts/kira-customize-copilot.prompt.md): customization helper entrypoint routed through `Kira`.
- [copilot/prompts/kira-create-adr.prompt.md](copilot/prompts/kira-create-adr.prompt.md): thin ADR creation entrypoint bound to `Kira :: Architect`.
- [copilot/prompts/kira-create-analysis.prompt.md](copilot/prompts/kira-create-analysis.prompt.md): thin analysis entrypoint bound to `Kira :: Architect`.
- [copilot/prompts/kira-draft-commit.prompt.md](copilot/prompts/kira-draft-commit.prompt.md): thin commit drafting entrypoint bound to `Kira :: Draft`.
- [copilot/prompts/kira-draft-pr.prompt.md](copilot/prompts/kira-draft-pr.prompt.md): thin PR drafting entrypoint bound to `Kira :: Draft`.
- [copilot/prompts/kira-draft-ticket.prompt.md](copilot/prompts/kira-draft-ticket.prompt.md): thin ticket drafting entrypoint bound to `Kira :: Draft`.
- [copilot/prompts/kira-refactor.prompt.md](copilot/prompts/kira-refactor.prompt.md): bounded refactor entrypoint routed through `Kira`.

## Skills and Instructions

- [copilot/skills/kira-customization-surface/SKILL.md](copilot/skills/kira-customization-surface/SKILL.md): capability for updating agents, prompts, skills, instructions, and docs consistently.
- [copilot/skills/kira-ticket-intake/SKILL.md](copilot/skills/kira-ticket-intake/SKILL.md): reusable ticket normalization capability.
- [copilot/skills/kira-draft-adr/SKILL.md](copilot/skills/kira-draft-adr/SKILL.md): ADR drafting capability.
- [copilot/skills/kira-draft-analysis/SKILL.md](copilot/skills/kira-draft-analysis/SKILL.md): analysis drafting capability.
- [copilot/skills/kira-draft-commit/SKILL.md](copilot/skills/kira-draft-commit/SKILL.md): commit message drafting capability.
- [copilot/skills/kira-draft-pr/SKILL.md](copilot/skills/kira-draft-pr/SKILL.md): PR description drafting capability.
- [copilot/skills/kira-draft-ticket/SKILL.md](copilot/skills/kira-draft-ticket/SKILL.md): ticket drafting capability.
- [copilot/skills/kira-draft-code-snippet/SKILL.md](copilot/skills/kira-draft-code-snippet/SKILL.md): chat code snippet drafting capability.
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

### Kira Code Handoff

```text
Kira, hand this feature implementation to the low-cost Code path and return validated changes.
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


Windows:
