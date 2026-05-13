# Kira vs Stock Copilot Agent

Kira does not replace the stock Copilot agent's core coding ability. She wraps it in a clearer voice, tighter routing, and stronger execution defaults.

In short: stock Copilot is capable. Kira is more opinionated.

## Kira-Only Policy Additions

These are the extra layers Kira brings out of the box as first-class behavior.

| Area | What Kira Adds | Example Prompt |
| --- | --- | --- |
| Casual chat | Kira can simply talk like a person instead of forcing every exchange into task mode. | `I'm stuck on this bug. Can you talk it through with me before we start changing code?` |
| Stable identity | The same voice carries across chat, coding, review, and execution. | `Explain the bug, then fix it, then tell me what changed.` |
| Tone adaptation | Kira adjusts for playful, urgent, stressed, or high-risk moments. | `Skip the fluff and give me the fastest safe fix.` |
| Flirt-aware boundaries | She can be playful without turning that into the default tone. | `Keep a little personality, but stay focused on debugging this timeout issue.` |
| Request classification | Kira explicitly sorts a request into direct answer, direct activity, or development work. | `Run the tests` vs `Why does this fail?` vs `Implement this endpoint.` |
| Skill contract | Kira frames skill work tightly, respects stopping points, and relays only the useful outcome. | `Review this branch` or `Design the migration strategy first.` |
| Analysis gate | Kira decides whether analysis is needed before coding starts. | `Refactor this parser without changing behavior.` |
| Analysis depth | Kira can choose fast, standard, or deep analysis instead of treating every task the same way. | `Compare two approaches for this cross-service change.` |
| Analysis fallback | If analysis is needed but unavailable, Kira has explicit stop-or-proceed rules instead of bluffing. | `Implement this broad auth change, but only if you have enough context to do it safely.` |
| Ticket intake | Kira resolves GitHub or Azure ticket details before jumping into implementation. | `Implement GitHub issue #123.` |
| Ticket parsing | Kira explicitly extracts goal, constraints, acceptance criteria, and linked context from the ticket. | `Implement Azure work item 4567.` |
| Memory policy | Kira defines how repo memory and session memory should be used. | `Keep following the naming conventions we used earlier in this repo.` |
| Response framing | Kira leads with the answer or finding and keeps reviews findings-first. | `Review this PR and tell me what is wrong first.` |
| Truthfulness boundaries | Kira explicitly avoids pretending she ran something, knows something, or used a skill when she did not. | `Did you already run the tests?` |
| Chat-to-work continuity | Kira can move from banter to engineering work without changing identity. | `Okay, back to work. Fix the failing build.` |

## Shared Capabilities With Better Defaults

These are things stock Copilot can already do, but Kira gives them a stronger default operating model.

| Area | Better Kira Default | Example Prompt |
| --- | --- | --- |
| Coding and debugging | Kira makes it clearer when to answer directly, execute directly, or enter development mode. | `Fix this null reference in OrderService.` |
| End-to-end development flow | Kira follows a named cycle: classify, analyze, implement, add tests, validate, build, test, hand off. | `Add validation to this API endpoint.` |
| Local implementation loop | Kira works from a concrete anchor, forms a local hypothesis, makes the smallest edit, and validates quickly. | `Fix the failing test in PaymentServiceTests.` |
| Unit-test integration | Kira adds or updates unit tests when the surface is reasonable, and says plainly when coverage is blocked. | `Implement this service method.` |
| Validation discipline | Kira treats changed code as incomplete until it is checked. | `Patch the bug and verify it.` |
| Build and test verification | Kira makes build and relevant tests part of normal completion for development work. | `Add this DTO and mapper.` |
| Code review | Kira frames reviews findings-first instead of burying the real issues in summary. | `Review this branch for regressions.` |
| Tool use | Kira prefers targeted reads, fast search, parallel read-only checks, and disciplined terminal use. | `Find where this feature flag is set and why.` |
| Editing style | Kira prefers root-cause fixes, minimal diffs, and preserving existing style. | `Clean this up without changing behavior.` |
| Uncertainty handling | Kira is more explicit about when to proceed, when to ask, and when to stop. | `I think auth is broken somewhere around middleware. Trace it down and tell me if you need more context.` |
| Specialized workflows | Kira routes to the right skill with clearer boundaries and handoffs. | `Draft a commit message for the staged changes` or `Do an architecture review first.` |
| Ticket implementation | Kira resolves the ticket first, then runs the normal development cycle. | `Implement Azure ticket 4567.` |

## Scope Note

This README compares behavior and operating policy, not tool access. Both Kira and a stock Copilot coding agent can read code, edit files, run commands, and help solve engineering problems.

The difference is that Kira defines more of the experience up front.

## ADRs

The stable design decisions behind this repo live in [docs/adr/README.md](docs/adr/README.md).

## Supporting Analysis

Volatile pricing and billing references for the June 1 Copilot transition live in [docs/copilot-billing-cost-analysis.md](docs/copilot-billing-cost-analysis.md).

The personal-use model catalog, including per-model costs, annual before-and-after multiplier changes, and use-case guidance, lives in [docs/copilot-model-reference-personal.md](docs/copilot-model-reference-personal.md).

The workflow comparison, including agentic work versus non-agentic flows, lives in [docs/copilot-workflow-flows-comparison.md](docs/copilot-workflow-flows-comparison.md).

The prescriptive personal workflow policy lives in [docs/copilot-personal-workflow-policy.md](docs/copilot-personal-workflow-policy.md).

The short daily routing reference lives in [docs/copilot-workflow-cheat-sheet.md](docs/copilot-workflow-cheat-sheet.md).

The comparison between built-in Plan and custom planning agents lives in [docs/copilot-plan-vs-custom-agent.md](docs/copilot-plan-vs-custom-agent.md).

Concrete sample planning and implementation handoff agents live in [docs/examples/agents/plan-review-sample.agent.md](docs/examples/agents/plan-review-sample.agent.md) and [docs/examples/agents/implement-from-plan-sample.agent.md](docs/examples/agents/implement-from-plan-sample.agent.md).

These sample agent files are documentation examples, not active repo agent configuration. If you want VS Code to load them directly, copy or mirror them into a supported custom-agent location such as `.github/agents`, or point `chat.agentFilesLocations` at the path you want to use.