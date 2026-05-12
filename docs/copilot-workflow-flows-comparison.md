# GitHub Copilot Workflow Flows Comparison

- Date: 2026-05-12
- Status: Point-in-time reference
- Scope: Personal workflow selection in VS Code and GitHub Copilot, with emphasis on agentic work versus lower-autonomy flows

## Why This Document Exists

"Use Copilot" is too vague to be operational.

GitHub Copilot exposes several different workflows, and they are not interchangeable. Some are predictive and stay inside the editor. Some are interactive but non-agentic. Some are explicitly agentic: they can break a goal into steps, use tools, edit across files, run commands, and keep iterating.

If you want a cost-effective and high-quality workflow, you need to choose the lightest flow that can solve the problem.

## What Counts As Agentic Work

Based on VS Code's agent overview, agentic work means you give the system a high-level goal and it works autonomously to complete it.

In practice, that means the flow can do some or all of the following:

- break the goal into steps
- edit files across the project
- invoke tools
- run terminal commands
- self-correct when something fails

This is different from simpler Copilot flows that only:

- predict the next code completion
- suggest a local edit for you to review
- answer a question without changing files
- draft a plan without implementing it

## The Main Workflow Families

### 1. Predictive Editor Flows

These are not agentic.

They predict what you are likely to type or edit next and let you accept or reject the suggestion.

Examples:

- ghost text suggestions
- next edit suggestions (NES)

They are strongest when you already know what you are doing and just want speed.

### 2. Scoped Guided Edit Flows

These are usually not agentic.

They stay tightly scoped to the active editor or terminal and ask you to review the result immediately.

Examples:

- editor inline chat
- terminal inline chat

They are strongest when the work is local, visible, and bounded.

### 3. Interactive Non-Agentic Chat Flows

These are question-and-answer or exploration flows, not autonomous execution flows.

Examples:

- Ask agent in the Chat view
- Quick Chat

They are strongest when you need explanation, codebase understanding, or fast iteration on ideas before changing code.

### 4. Planning Flow

This is an intermediate flow.

The Plan agent researches the task, asks clarifying questions, and produces a structured implementation and verification plan, but it does not jump straight into coding. It is more autonomous than basic Q and A, but it is still a planning flow rather than full implementation work.

### 5. Interactive Local Agentic Flow

This is full agentic work inside VS Code.

The local Agent can autonomously plan and implement changes, run terminal commands, and invoke tools while you remain in the loop inside the editor.

### 6. Background Local Agentic Flow

This is agentic work that runs on your machine, but not as an interactive editor-first loop.

The main example is Copilot CLI running in the background on your machine.

### 7. Background Remote Agentic Flow

This is agentic work that runs remotely and fits team workflows on GitHub.

The main example is Copilot cloud agent, which is designed for independently implementing well-defined tasks, issue assignment, and pull-request oriented collaboration.

### 8. Provider-Specific Agentic Flow

This is still agentic work, but you choose a third-party agent because you want a specific provider or model family.

VS Code's agent overview frames this as the path to take when you want a specific AI provider such as Anthropic or OpenAI.

## Comparison Table

| Flow | Agentic? | Where it runs | Typical scope | Human checkpoint style | Best for | Not ideal for |
| --- | --- | --- | --- | --- | --- | --- |
| Ghost text suggestions | No | Active editor | Current cursor or immediate continuation | You accept suggestion fragments or whole suggestions | Fast typing, boilerplate, short code completion | Broad reasoning, multi-file changes, debugging across files |
| Next edit suggestions | No | Active editor | Predicted next edit, sometimes away from cursor | You jump to and accept suggested edits | Local refactors, repeated edits, intent propagation inside a file or nearby code | Open-ended problem solving or autonomous task completion |
| Editor inline chat | Usually no | Active editor | Visible file or selected code | You review an inline diff with Keep or Undo | Quick targeted edits, rewrite a function, explain or transform selected code | Multi-step codebase work or broad implementation |
| Terminal inline chat | Usually no | Integrated terminal | One command or short terminal task | You review and run or insert the command | Command generation, shell help, quick terminal tasks | Long autonomous coding sessions |
| Ask agent / Quick Chat | No | Chat view or lightweight chat panel | Questions, explanations, codebase understanding | Conversational follow-up, no file edits by default | Learning, exploration, root-cause discussion, understanding a codebase | End-to-end implementation |
| Plan agent | Partially | Chat view | Research plus structured implementation plan | You review and iterate on the plan before implementation | Risky changes, feature planning, verification planning, design before coding | Tiny tasks where planning overhead is wasted |
| Local Agent | Yes | VS Code on your machine | Multi-file interactive implementation with local tools and editor context | Permission levels, approvals, ongoing interaction in session | Fixing issues with editor context, lint/test failures, multi-file implementation | Tasks you want fully detached in the background or on GitHub |
| Copilot CLI | Yes | Your machine, background terminal flow | Well-defined background implementation or experiments | You can delegate and check progress later | Background work while you keep coding, proof of concepts, isolated runs | Tasks that depend heavily on VS Code-only tools or rich editor context |
| Cloud agent | Yes | Remote cloud environment with GitHub integration | Well-defined autonomous task execution tied to issues and PRs | GitHub-oriented review and collaboration checkpoints | Assignable issue work, PR creation, collaboration with team review | Tasks needing your current local editor state or local-only tools |
| Third-party agent | Yes | Local or cloud depending on provider harness | Agentic work with provider-specific models | Depends on the selected provider and environment | When you specifically want Anthropic or OpenAI agent behavior | Cases where the built-in local or cloud agent already fits and extra provider choice adds complexity |

## The Practical Difference Between Agentic And Non-Agentic Flows

The main difference is not just "how smart" the flow is. It is how much execution responsibility you hand over.

Non-agentic flows mainly help you think, type, or make bounded edits.

Agentic flows take on execution responsibility by:

- planning task steps
- deciding what to inspect next
- using tools or commands
- applying changes across multiple files
- rerunning checks and adjusting course

That makes agentic work more powerful, but also more expensive in attention, trust, and usually token usage.

## Oversight And Control Differences

VS Code's agents overview makes the oversight gradient explicit.

- Predictive and inline flows keep you closest to the code and require immediate acceptance.
- Ask and Quick Chat keep control entirely conversational.
- Plan keeps implementation paused until the plan is reviewed.
- Local Agent introduces tool approvals and permission levels.
- CLI and cloud agent shift more of the work into background execution and later review.

If the task is risky, ambiguous, or easy to overrun, higher-autonomy flows should usually be gated by planning or tighter approvals.

## Cost And Resource Implications

The official personal billing docs matter here.

- Code completions and next edit suggestions are not billed in AI credits on paid plans.
- Copilot Chat, Copilot CLI, Copilot cloud agent, Copilot Spaces, Spark, and third-party coding agents do consume AI credits.
- Longer conversations and more elaborate tasks consume more usage.
- Agentic features such as agent mode and Copilot cloud agent can involve multiple model calls within one task and can consume significantly more usage than a quick question in chat.

This creates a practical cost ladder:

- lowest cost pressure: suggestions and NES
- low to moderate cost pressure: short chat interactions and scoped edit sessions
- moderate cost pressure: planning sessions
- highest cost pressure: long local agent, CLI, and cloud-agent runs, especially on expensive models

For the billing details behind this, see [copilot-billing-cost-analysis.md](copilot-billing-cost-analysis.md).

## Recommended Default Routing

Use this sequence as a default decision rule:

1. Use inline suggestions or NES when you already know the change and want speed.
2. Use inline chat when the task is local to visible code or a single terminal command.
3. Use Ask or Quick Chat when you need explanation, codebase understanding, or problem framing.
4. Use Plan when the task is important enough to benefit from explicit implementation and verification steps.
5. Use the local Agent when the task needs autonomous implementation and local editor context.
6. Use Copilot CLI when the task is well-defined and you want it running in the background on your machine.
7. Use cloud agent when the task fits a GitHub-native background workflow with issue or PR review checkpoints.

## Simple Rule Of Thumb

If you can point at one file or one visible selection, start with a non-agentic flow.

If the task needs multiple files, commands, retries, or its own execution loop, that is agentic work.

If the task is important enough that you want to inspect the route before code changes begin, insert a planning step first.

## Companion Documents

- default operating policy: [copilot-personal-workflow-policy.md](copilot-personal-workflow-policy.md)
- quick-reference version: [copilot-workflow-cheat-sheet.md](copilot-workflow-cheat-sheet.md)
- Plan versus custom-agent planning: [copilot-plan-vs-custom-agent.md](copilot-plan-vs-custom-agent.md)
- model details: [copilot-model-reference-personal.md](copilot-model-reference-personal.md)
- billing context: [copilot-billing-cost-analysis.md](copilot-billing-cost-analysis.md)

## Sources

- [Using agents in Visual Studio Code](https://code.visualstudio.com/docs/copilot/agents/overview)
- [Planning with agents in VS Code](https://code.visualstudio.com/docs/copilot/agents/planning)
- [Prompt examples](https://code.visualstudio.com/docs/copilot/chat/prompt-examples)
- [Inline chat](https://code.visualstudio.com/docs/copilot/chat/inline-chat)
- [Inline suggestions from GitHub Copilot in VS Code](https://code.visualstudio.com/docs/copilot/ai-powered-suggestions)
- [Concepts for GitHub Copilot agents](https://docs.github.com/en/copilot/concepts/agents)
- [Usage-based billing for individuals](https://docs.github.com/en/copilot/concepts/billing/usage-based-billing-for-individuals)