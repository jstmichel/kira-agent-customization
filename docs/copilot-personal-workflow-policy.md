# GitHub Copilot Personal Workflow Policy

- Date: 2026-05-12
- Status: Recommended default policy
- Scope: Personal day-to-day use of Copilot Pro or Pro+ in VS Code and GitHub

## Purpose

This document turns the comparison in [copilot-workflow-flows-comparison.md](copilot-workflow-flows-comparison.md) into a practical personal operating policy.

It is intentionally prescriptive.

The goal is not to list every possible workflow. The goal is to define a sane default that balances:

- output quality
- speed
- reviewability
- AI-credit cost

## Core Policy

Use the lightest flow that can solve the problem safely.

Default to lower-cost models and lower-autonomy flows first. Escalate only when the task needs broader reasoning, more autonomy, or more context than the lighter flow can handle.

## Default Flow Ladder

This is the default escalation order.

1. Inline suggestions or next edit suggestions
2. Editor inline chat or terminal inline chat
3. Ask agent or Quick Chat
4. Plan agent
5. Local Agent in VS Code
6. Copilot CLI for background local execution
7. Cloud agent for GitHub-native background execution
8. Third-party agent only when the provider choice is the reason for the workflow

If a lower step solves the task cleanly, stop there.

## Default Model Policy

These are policy recommendations, not GitHub defaults.

### Cheap Default

Use one of these first for routine work:

- GPT-5 mini
- Grok Code Fast 1
- Gemini 3 Flash
- Claude Haiku 4.5

Use this tier for:

- quick questions
- small rewrites
- utility code
- routine debugging
- short drafting sessions

### Agentic Default

Use one of these when the work becomes multi-file or tool-heavy:

- GPT-5.4 mini
- GPT-5.3-Codex

Use this tier for:

- codebase exploration
- multi-file implementation
- iterative fixes with commands or tests
- structured agentic execution without jumping immediately to the most expensive reasoning models

### Deep Reasoning Default

Use one of these when the problem is ambiguous, architectural, or hard to debug:

- GPT-5.4
- Claude Sonnet 4.6
- Gemini 3.1 Pro

Use this tier for:

- multi-step debugging
- architectural tradeoffs
- large refactors
- planning hard implementation paths

### Premium Reserve Tier

Use these only when the earlier tiers are not enough:

- GPT-5.5
- Claude Opus 4.7

Use this tier for:

- hardest reasoning tasks
- deep technical decision-making
- very difficult debugging or design analysis where retries on cheaper models are already wasting time

## Routing Policy By Task Type

| Task shape | Default flow | Default model tier | Escalate when | Avoid as a starting point |
| --- | --- | --- | --- | --- |
| You already know the exact local edit | Inline suggestions or NES | Current completions model | The change spills beyond the local edit path | Plan, CLI, cloud agent |
| One function or one visible block needs work | Editor inline chat | Cheap default | The task needs repo context or multiple files | Cloud agent |
| One shell command or quick terminal help is enough | Terminal inline chat | Cheap default | The work turns into a multi-step environment task | Local Agent or CLI without a clear goal |
| You need explanation or codebase understanding | Ask or Quick Chat | Cheap default | The problem stays ambiguous after one pass | Jumping straight to agentic execution |
| You need a reviewable route before coding | Plan agent | Deep reasoning default | The plan is stable and implementation is clearly defined | Starting implementation directly on a risky task |
| The task needs multi-file local execution with commands and fixes | Local Agent | Agentic default | The task is mostly design reasoning, or needs background time | Inline chat for a repo-wide change |
| The task is well defined and can run in the background on your machine | Copilot CLI | Agentic default | The task depends on rich local editor context or needs GitHub workflow integration | Ask or inline chat |
| The task belongs in an issue or PR workflow | Cloud agent | Agentic default | The task depends on your local state or uncommitted editor context | Local editor-only flows |
| The task is unusually hard and reasoning quality dominates cost | Ask, Plan, or Local Agent | Deep reasoning default then premium reserve | One lower tier already failed cleanly | Staying on cheap models after repeated unproductive retries |

## Escalation Rules

Use these rules to decide when to move up the ladder.

### Escalate the flow when

- the work crosses file boundaries
- the work needs tool calls or terminal commands
- the work requires retries and self-correction
- the work needs reviewable planning before implementation

### Escalate the model when

- the answer is shallow but the task is genuinely complex
- a cheaper model failed once in a way that exposes a reasoning limit, not just a prompt-quality issue
- you are comparing designs, debugging subtle behavior, or making cross-component decisions

### Do not escalate just because

- the first answer was stylistically imperfect
- you have not yet constrained the task enough
- the task can still be solved with one tighter prompt or a smaller scope

## Oversight Policy

Higher autonomy requires higher intentionality.

Use these defaults:

- suggestions and inline chat for immediate visible review
- Ask for understanding before execution when the cause is still unclear
- Plan before Agent when the change is risky, cross-cutting, or expensive to reverse
- Local Agent with approvals when the task is real but you still want direct oversight
- CLI or cloud agent only when the task is well defined enough to survive background execution

## Cost Policy

The billing docs make a few rules operationally important:

- code completions and next edit suggestions are not billed in AI credits on paid plans
- longer conversations and more elaborate tasks consume more usage
- agentic features can involve multiple model calls and can consume significantly more usage than a quick question in chat

That leads to these personal cost rules:

- do not start agentic unless the task actually needs agentic behavior
- do not start premium reasoning models for routine work
- do not keep retrying the same expensive setup when a smaller scoped prompt or cheaper flow would disambiguate the problem faster
- keep always-on and repeated prompt context lean

## Opinion On Vibe Coding

This policy does cover it now, explicitly.

Vibe coding means loose-spec, intuition-led implementation where you explore by prompting, steering, and reacting instead of working from a stable requirement set.

That mode is useful, but it should not be the default for important implementation.

Use vibe coding for:

- prototypes
- spikes
- throwaway experiments
- UX exploration
- early idea shaping before requirements are stable

Do not use vibe coding as the default for:

- production bug fixes with real impact
- cross-file refactors with behavioral risk
- changes that need clear acceptance criteria
- work that must be reviewable against a defined outcome

Personal policy:

- keep vibe coding cheap, fast, and bounded
- prefer inline chat, Ask, or a tightly scoped local agent session
- use lower-cost models first
- isolate the work to a branch, a spike, or a clearly reversible slice
- if the result becomes real implementation, switch out of vibe mode and move into a spec-driven workflow before calling it done

The problem with vibe coding is not that it is exploratory. The problem is pretending exploration is the same thing as verified delivery.

## Opinion On Full-Spec Implementation Workflow

This repo already leaned that way through planning and ticket-intake ADRs. This policy makes it explicit.

Full-spec implementation is the preferred workflow for non-trivial delivery work.

Use it when you have one or more of the following:

- acceptance criteria
- a ticket or work item with real constraints
- architectural or behavioral risk
- code that must be reviewed against a known outcome
- work that is expensive to undo

Default full-spec workflow:

1. Resolve the spec first: goal, constraints, acceptance criteria, and linked context.
2. Use Ask if the codebase or problem still needs clarification.
3. Use Plan when the implementation route or verification strategy should be reviewed before coding.
4. Implement with the lightest execution flow that fits the task, usually Local Agent for local multi-file work or cloud agent for GitHub-native background work.
5. Validate against the spec, not just against whether the code now looks plausible.

This is the safer default because it separates exploration from commitment.

In other words:

- vibe coding is acceptable for discovery
- full-spec workflow is preferred for delivery

## Default Personal Operating Rules

Use these as daily rules of thumb:

1. If the task is visible and local, stay in the editor.
2. If the task is unclear, ask before you execute.
3. If the task is risky, plan before you code.
4. If the task is multi-file and procedural, use an agent.
5. If the task can run while you do something else, prefer background execution.
6. If the task is easy but frequent, optimize for cheap and fast.
7. If the task is hard and expensive, earn the escalation with one failed lower-cost pass first.

## Companion Documents

- explanatory comparison: [copilot-workflow-flows-comparison.md](copilot-workflow-flows-comparison.md)
- quick-reference summary: [copilot-workflow-cheat-sheet.md](copilot-workflow-cheat-sheet.md)
- Plan versus custom-agent planning: [copilot-plan-vs-custom-agent.md](copilot-plan-vs-custom-agent.md)
- model selection and costs: [copilot-model-reference-personal.md](copilot-model-reference-personal.md)
- billing context: [copilot-billing-cost-analysis.md](copilot-billing-cost-analysis.md)

## Sources

- [Using agents in Visual Studio Code](https://code.visualstudio.com/docs/copilot/agents/overview)
- [Planning with agents in VS Code](https://code.visualstudio.com/docs/copilot/agents/planning)
- [Prompt examples](https://code.visualstudio.com/docs/copilot/chat/prompt-examples)
- [Inline chat](https://code.visualstudio.com/docs/copilot/chat/inline-chat)
- [Inline suggestions from GitHub Copilot in VS Code](https://code.visualstudio.com/docs/copilot/ai-powered-suggestions)
- [Usage-based billing for individuals](https://docs.github.com/en/copilot/concepts/billing/usage-based-billing-for-individuals)