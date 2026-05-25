# GitHub Copilot Workflow Flows Comparison

- Date: 2026-05-25
- Status: Point-in-time reference
- Scope: Personal workflow selection in VS Code, with editor-first local work as the default and background or remote flows included only for contrast

## Why This Document Exists

"Use Copilot" is still too vague to be operational.

VS Code now exposes multiple Copilot surfaces that differ in autonomy, cost, context access, and review style. If you want a high-quality workflow, you need to choose the lightest surface that can solve the problem instead of reaching for full agent mode every time.

## What Counts As Agentic Work

Based on VS Code's current agent overview, agentic work means you give the system a high-level goal and it works autonomously to complete it.

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

- Ask in the Chat view
- Quick Chat

They are strongest when you need explanation, codebase understanding, or fast iteration on ideas before changing code.

### 4. Planning Flow

This is an intermediate flow.

The Plan agent researches the task, asks clarifying questions, and produces a structured implementation and verification plan, but it does not jump straight into coding.

### 5. Interactive Local Agentic Flow

This is full agentic work inside VS Code.

The local Agent can autonomously plan and implement changes, run terminal commands, and invoke tools while you remain in the loop inside the editor.

### 6. Detached Background Or Remote Flow

These are still agentic flows, but they are no longer editor-first.

Examples:

- Copilot CLI on your machine
- Copilot cloud agent on GitHub
- third-party agent harnesses

They matter as a contrast surface, not as the default for this repository's local customization strategy.

## Comparison Table

| Flow | Agentic? | Where it runs | Typical scope | Human checkpoint style | Best for | Cost pressure |
| --- | --- | --- | --- | --- | --- | --- |
| Ghost text suggestions | No | Active editor | Current cursor or immediate continuation | You accept suggestion fragments or whole suggestions | Fast typing, boilerplate, short code completion | Lowest; unbilled on paid plans |
| Next edit suggestions | No | Active editor | Predicted next edit, sometimes away from cursor | You jump to and accept suggested edits | Local refactors, repeated edits, intent propagation inside a file or nearby code | Lowest; unbilled on paid plans |
| Editor or terminal inline chat | Usually no | Active editor or integrated terminal | Visible code or one command | You review an inline diff with Keep or Undo, or review a command with Run or Insert | Quick targeted edits, rewrite a function, explain or transform selected code, shell help | Low to moderate |
| Ask / Quick Chat | No | Chat view or lightweight chat panel | Questions, explanations, codebase understanding | Conversational follow-up, no file edits by default | Learning, exploration, root-cause discussion, understanding a codebase | Moderate |
| Plan agent | Partially | Chat view | Research plus structured implementation plan | You review and iterate on the plan before implementation | Risky changes, feature planning, verification planning, design before coding | Moderate |
| Local Agent | Yes | VS Code on your machine | Multi-file interactive implementation with local tools and editor context | Permission levels, approvals, and ongoing session review | Fixing issues with editor context, lint or test failures, multi-file implementation | Highest local cost pressure |
| Background or remote agents | Yes | Your machine in the background or a remote GitHub environment | Detached well-defined task execution | Later review, PR review, or background monitoring | Tasks you explicitly want detached from the editor-first loop | Highest overall cost and lowest editor-context fidelity |

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

VS Code's current agent docs make the oversight gradient explicit.

- Predictive and inline flows keep you closest to the code and require immediate acceptance.
- Ask and Quick Chat keep control entirely conversational.
- Plan keeps implementation paused until the plan is reviewed.
- Local Agent introduces tool approvals and permission levels such as Default Approvals, Bypass Approvals, and Autopilot.
- Detached background and remote agents shift more of the work into later review rather than live editor review.

If the task is risky, ambiguous, or easy to overrun, higher-autonomy flows should usually be gated by planning or tighter approvals.

## Cost And Resource Implications

The official personal billing docs matter here.

- Code completions and next edit suggestions are not billed in AI credits on paid plans.
- Copilot Chat, local agent sessions, Copilot CLI, Copilot cloud agent, Copilot Spaces, Spark, and third-party coding agents do consume AI credits.
- Longer conversations and more elaborate tasks consume more usage.
- Agentic features can involve multiple model calls within one task and can consume significantly more usage than a quick question in chat.

This creates a practical cost ladder:

- lowest cost pressure: suggestions and NES
- low to moderate cost pressure: short chat interactions and scoped edit sessions
- moderate cost pressure: planning sessions
- highest cost pressure: long local agent sessions and detached background or remote runs, especially on expensive models

For the billing details behind this, see [copilot-billing-cost-analysis.md](copilot-billing-cost-analysis.md).

## Recommended 2026 Default Routing

Use this sequence as the default decision rule for personal VS Code work:

1. Use inline suggestions or NES when you already know the change and want speed.
2. Use inline chat when the task is local to visible code or a single terminal command.
3. Use Ask or Quick Chat when you need explanation, codebase understanding, or problem framing.
4. Use Plan when the task is important enough to benefit from explicit implementation and verification steps.
5. Use the local Agent when the task needs autonomous implementation and local editor context.
6. Reach for detached background or remote agents only when you explicitly want work to continue away from the editor-first loop.

## Simple Rule Of Thumb

If you can point at one file or one visible selection, start with a non-agentic flow.

If the task needs multiple files, commands, retries, or its own execution loop, that is agentic work.

If the task is important enough that you want to inspect the route before code changes begin, insert a planning step first.

## Companion Documents

- model details: [copilot-model-reference-personal.md](copilot-model-reference-personal.md)
- billing context: [copilot-billing-cost-analysis.md](copilot-billing-cost-analysis.md)
- editor-first playbook: [copilot-local-vscode-workflow-guide.md](copilot-local-vscode-workflow-guide.md)

## Sources

- [Using agents in Visual Studio Code](https://code.visualstudio.com/docs/copilot/agents/overview)
- [Planning with agents in VS Code](https://code.visualstudio.com/docs/copilot/agents/planning)
- [Best practices for using AI in VS Code](https://code.visualstudio.com/docs/copilot/best-practices)
- [Prompt examples](https://code.visualstudio.com/docs/copilot/chat/prompt-examples)
- [Inline chat](https://code.visualstudio.com/docs/copilot/chat/inline-chat)
- [Inline suggestions from GitHub Copilot in VS Code](https://code.visualstudio.com/docs/copilot/ai-powered-suggestions)
- [Usage-based billing for individuals](https://docs.github.com/en/copilot/concepts/billing/usage-based-billing-for-individuals)