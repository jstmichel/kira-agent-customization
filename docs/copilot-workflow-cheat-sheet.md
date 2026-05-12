# GitHub Copilot Workflow Cheat Sheet

- Date: 2026-05-12
- Status: Quick reference
- Scope: Day-to-day personal routing for Copilot flows and model tiers

## Fast Routing

| If you need to... | Start with... | Model tier | Escalate to... |
| --- | --- | --- | --- |
| Accept or finish code you already know | Inline suggestions or NES | Current completions model | Editor inline chat |
| Rewrite or fix one visible function | Editor inline chat | Cheap default | Ask, then Local Agent if the change spreads |
| Generate or refine one terminal command | Terminal inline chat | Cheap default | Copilot CLI |
| Understand code, logs, or a bug before changing code | Ask or Quick Chat | Cheap default | Plan or a deeper reasoning model |
| Review the route before implementation | Plan agent | Deep reasoning default | Local Agent |
| Execute a multi-file fix locally with tools and commands | Local Agent | Agentic default | Deep reasoning default or CLI |
| Run a well-defined task in the background on your machine | Copilot CLI | Agentic default | Cloud agent |
| Run a GitHub-native background workflow with PR review checkpoints | Cloud agent | Agentic default | Deep reasoning default only if needed |
| Solve a genuinely hard reasoning problem | Ask, Plan, or Local Agent | Deep reasoning default | Premium reserve tier |

## Model Tiers

### Cheap Default

- GPT-5 mini
- Grok Code Fast 1
- Gemini 3 Flash
- Claude Haiku 4.5

Use for routine work, short questions, small edits, and quick debugging.

### Agentic Default

- GPT-5.4 mini
- GPT-5.3-Codex

Use for multi-file implementation, codebase exploration, and tool-heavy execution.

### Deep Reasoning Default

- GPT-5.4
- Claude Sonnet 4.6
- Gemini 3.1 Pro

Use for architecture, ambiguous bugs, and hard planning.

### Premium Reserve

- GPT-5.5
- Claude Opus 4.7

Use only when the lower tiers are not enough.

## Default Escalation Order

1. Suggestions or NES
2. Inline chat
3. Ask or Quick Chat
4. Plan
5. Local Agent
6. Copilot CLI
7. Cloud agent

## Quick Cost Rules

- Cheapest practical path: suggestions and NES
- Cheap but billed: short chat and scoped edit sessions
- More expensive: planning sessions
- Most expensive: long agentic sessions, especially on high-cost models

## Do This, Not That

- If the task is local and visible, do not start with an agent.
- If the task is unclear, do not start with cloud or CLI background execution.
- If the task is risky, do not skip planning.
- If the cheap model failed for style only, do not escalate the model yet.
- If the cheap model failed for reasoning, escalate the model before repeating the same prompt.

## Two Named Modes

| Mode | Use it for | Start with | Rule |
| --- | --- | --- | --- |
| Vibe coding | Prototypes, spikes, idea shaping, disposable exploration | Ask, inline chat, or a tightly scoped local agent session | Keep it cheap and reversible; do not confuse it with verified delivery |
| Full-spec implementation | Tickets, defined acceptance criteria, risky or reviewable delivery work | Ask, then Plan, then the lightest fitting execution flow | Validate against the spec, not just the generated code |

## One-Line Rule

Use the lightest flow that can solve the task safely, and use the cheapest model that can solve it reliably.

## Companion Documents

- detailed comparison: [copilot-workflow-flows-comparison.md](copilot-workflow-flows-comparison.md)
- default operating policy: [copilot-personal-workflow-policy.md](copilot-personal-workflow-policy.md)
- model details: [copilot-model-reference-personal.md](copilot-model-reference-personal.md)
- billing context: [copilot-billing-cost-analysis.md](copilot-billing-cost-analysis.md)