# Plan Agent Versus Custom Agent

- Date: 2026-05-12
- Status: Point-in-time reference
- Scope: Personal workflow choice in VS Code between the built-in Plan agent and a custom planning-oriented agent

## Why This Document Exists

The question sounds simple, but it mixes two different things:

- a built-in workflow mode: Plan
- a customization mechanism: custom agents

Those are not direct equivalents.

Plan is a ready-made planning workflow in VS Code. A custom agent is a configurable wrapper around instructions, tools, model selection, and handoffs.

## Short Answer

If you want the shortest correct answer:

- use Plan when you want the built-in planning workflow and its default UX
- use a custom agent when you want planning behavior shaped to your own rules, tools, deliverables, or model preferences

Can a custom agent plan the same way?

- functionally, often yes
- operationally, not exactly by default

The official custom agents documentation explicitly uses a planning agent as an example. You can create a custom agent with planning instructions and read-only tools.

But the built-in Plan agent still has its own workflow affordances, such as dedicated Plan entry points, plan-oriented settings, and automatic plan session memory.

## What The Built-In Plan Agent Is

According to the VS Code planning documentation, Plan is a built-in agent in the Chat view that:

- takes a high-level task
- asks clarifying questions
- researches the task
- generates a structured implementation and verification plan
- keeps implementation paused until you review the plan

It also has dedicated planning-specific affordances:

- `/plan` as a direct entry point
- `chat.planAgent.defaultModel` for the planning model
- `github.copilot.chat.planAgent.additionalTools` for extra research tools
- automatic session memory in `/memories/session/plan.md`

That makes Plan a workflow product, not just a prompt style.

## What A Custom Agent Is

According to the VS Code custom agents documentation, a custom agent is a reusable configuration that can define:

- instructions
- tools
- model selection
- subagents
- handoffs

The docs explicitly say a custom agent could be a planning agent with read-only tools and instructions for generating an implementation plan.

That means a custom agent can absolutely be used for planning.

## Can A Custom Agent Plan The Same Way?

The precise answer is: it can plan in a very similar way, and in some cases in a better way for your workflow, but it is not automatically identical to the built-in Plan experience.

### What a custom planning agent can match well

- planning-first behavior
- clarifying questions
- structured implementation steps
- verification checklist generation
- read-only research posture
- model selection for planning
- handoff from planning to implementation or review

### What the built-in Plan agent still owns more directly

- dedicated `/plan` UX
- built-in plan-specific settings
- automatic `plan.md` session-memory behavior
- a default expectation that implementation is paused until the plan is reviewed

### Practical conclusion

If your question is "can I make a custom agent that behaves like a planner?" the answer is yes.

If your question is "is a custom planning agent literally the same product behavior as built-in Plan?" the answer is no.

The better way to think about it is this:

- Plan is the standard planning lane
- a custom planning agent is a specialized planning lane

## Comparison Table

| Dimension | Built-in Plan agent | Custom planning agent |
| --- | --- | --- |
| What it is | A built-in planning workflow | A user-defined or workspace-defined specialized agent |
| Main purpose | Produce a plan before implementation | Produce a plan using your own rules, tools, and model choices |
| Default UX | Native Plan selection and `/plan` entry | Selected from custom agents list or invoked via handoff/subagent flow |
| Tool posture | Planning research tools, with optional extra tools via settings | Whatever tools you explicitly allow |
| Safety posture | Naturally planning-first | Depends on how you configure tools and instructions |
| Model control | Plan-specific model setting | `model` frontmatter or current model picker |
| Memory behavior | Automatically saves `plan.md` in session memory | No documented automatic `plan.md` behavior unless you reproduce it another way |
| Handoffs | Built-in implementation continuation flow | Explicit custom handoffs to implementation or review agents |
| Best for | Standard planning before risky work | Repeatable planning templates, team rules, constrained tools, specialized outputs |
| Main weakness | Less tailored to your own exact workflow | More setup and more chances to over-customize |

## Quick Decision Matrix

| If you need... | Choose... | Why |
| --- | --- | --- |
| A fast default planning lane with minimal setup | Built-in Plan agent | It already has the planning UX, session-memory behavior, and the standard review-before-implementation flow |
| A reusable planning persona with your own structure, tool limits, or default model | Custom planning agent | It lets you lock in planning rules, cost posture, and handoffs for repeated use |
| A reviewable plan first and then a separate execution lane with different tools or models | Plan plus handoff or a paired custom planning and implementation flow | It keeps planning and execution intentionally separate while preserving continuity |

## Example Custom Agents

This repo now includes a concrete paired example:

- planning example: [examples/agents/plan-review-sample.agent.md](examples/agents/plan-review-sample.agent.md)
- implementation example: [examples/agents/implement-from-plan-sample.agent.md](examples/agents/implement-from-plan-sample.agent.md)

These files live under the docs tree as documentation examples. To have VS Code discover them automatically, place them in a supported custom-agent location such as `.github/agents`, or configure `chat.agentFilesLocations` to include the repo path you want to use.

The pair shows a cost-aware pattern:

- a planning agent with read-heavy tools and a planning-oriented model choice
- an implementation agent with broader execution tools and a direct handoff from the planning stage

## Cost Calculus

There is no separate published price tier for "Plan" versus "custom agent."

The billing docs describe cost in terms of:

- model choice
- token consumption
- interaction complexity
- agentic behavior that triggers multiple model calls

That means the primary question is not "Plan or custom agent?" The primary question is "which model, how much context, how many turns, and how much tool-driven work?"

## What Costs The Same In Both Cases

If Plan and a custom planning agent use roughly the same:

- model
- prompt size
- conversation length
- amount of retrieved context
- amount of output generated

then their cost should be broadly similar.

There is no documented custom-agent surcharge.

## What Can Make A Custom Planning Agent Cheaper

A custom planning agent can be cheaper than built-in Plan when you deliberately constrain it.

Examples:

- forcing a cheaper model in the agent frontmatter
- limiting tools to read-only research and search
- using tighter instructions that keep output concise
- using handoffs so planning ends before implementation begins

If the built-in Plan agent is using a stronger default model and your custom planning agent uses a cheaper one, the custom planning agent can cost less.

## What Can Make A Custom Planning Agent More Expensive

A custom planning agent can also cost more if you overbuild it.

Examples:

- selecting a more expensive model than the built-in Plan configuration
- adding long always-on planning instructions
- allowing extra tools that expand research and context gathering
- generating overly long plan deliverables
- chaining planning directly into implementation or review with more autonomous work

In other words, custom agents are not inherently cheaper. They are more tunable.

## Practical Cost Difference By Driver

| Cost driver | Built-in Plan agent | Custom planning agent | Practical takeaway |
| --- | --- | --- | --- |
| Model price | Controlled by Plan model setting | Controlled by agent `model` or picker | The chosen model matters more than the workflow label |
| Prompt overhead | Built-in planning prompt and session context | Built-in context plus your custom instructions | Large custom instructions add recurring token cost |
| Tool scope | Standard planning research path, optionally expanded | Exactly what you allow | Wider tool access can increase context and turns |
| Output length | Depends on how much planning detail you ask for | Same | Long plans cost more regardless of lane |
| Execution spillover | May continue into implementation after review | May hand off to implementation or another agent | The big cost jump usually happens when coding starts |

## Recommended Routing

Use the built-in Plan agent when:

- you want standard planning quickly
- you do not need strong workflow specialization
- you want the default planning UX and session-memory behavior

Use a custom planning agent when:

- you want a fixed planning template
- you want planning constrained to read-only tools
- you want a specific planning model by default
- you want explicit handoffs to implementation or review
- you want a reusable planning persona for repeated work

Use both together when:

- you want a planning stage and an implementation stage with different tools or models
- you want planning to be reviewable before execution starts
- you want to standardize your own personal or team planning workflow

## Bottom Line

Plan is the easiest standard planning workflow.

A custom planning agent is the better choice when you want that planning workflow shaped to your own rules.

Cost is not fundamentally "Plan versus custom agent."

Cost is mostly:

- model rate
- token volume
- context size
- tool breadth
- whether the session stays in planning or spills into full agentic execution

## Companion Documents

- workflow comparison: [copilot-workflow-flows-comparison.md](copilot-workflow-flows-comparison.md)
- personal workflow policy: [copilot-personal-workflow-policy.md](copilot-personal-workflow-policy.md)
- workflow cheat sheet: [copilot-workflow-cheat-sheet.md](copilot-workflow-cheat-sheet.md)
- billing reference: [copilot-billing-cost-analysis.md](copilot-billing-cost-analysis.md)
- model reference: [copilot-model-reference-personal.md](copilot-model-reference-personal.md)

## Sources

- [Planning with agents in VS Code](https://code.visualstudio.com/docs/copilot/agents/planning)
- [Custom agents in VS Code](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- [Usage-based billing for individuals](https://docs.github.com/en/copilot/concepts/billing/usage-based-billing-for-individuals)