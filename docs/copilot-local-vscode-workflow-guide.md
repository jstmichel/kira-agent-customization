# GitHub Copilot Local VS Code Workflow Guide

- Date: 2026-05-25
- Status: Point-in-time reference
- Scope: Local, editor-first GitHub Copilot use in VS Code. This guide intentionally excludes Copilot CLI and cloud agent as primary workflows.

## Why This Document Exists

This repository customizes local Copilot behavior.

The goal is predictable, low-drift workflows inside VS Code rather than detached automation. The useful core idea from broader Copilot workflow articles is still the same: make context, roles, and validation explicit. The adaptation here is to apply that pattern to local VS Code surfaces only.

## Default Routing Ladder

Use the lightest surface that can solve the task.

### 1. Suggestions And Next Edit Suggestions

Start here when you already know the change.

Use them for:

- boilerplate
- intent propagation after a rename or small local change
- fast local corrections

These are the cheapest local surface because they are not billed in AI credits on paid plans.

### 2. Inline Chat

Use inline chat when the task is bounded to visible code or one terminal command.

Use it for:

- rewriting a function
- adding local validation or error handling
- explaining or transforming selected code
- generating and reviewing a single shell command

### 3. Ask Or Quick Chat

Use Ask or Quick Chat when you need understanding before implementation.

Use them for:

- codebase exploration
- root-cause discussion
- architecture questions
- comparing options before changing code

### 4. Plan

Use Plan before risky or cross-file work.

Plan is the right surface when you want:

- clarifying questions first
- an implementation sequence
- explicit verification steps
- a review checkpoint before code changes begin

### 5. Local Agent

Use the local Agent only when the task genuinely needs autonomous execution.

That usually means:

- multiple files
- tool usage
- terminal commands
- iterative fix-and-validate loops
- self-correction after failures

## Customization Stack

### Always-On Instructions

Keep `.github/copilot-instructions.md` small.

Put only non-obvious repo facts there:

- build and validation commands
- architecture constraints
- preferred libraries or patterns that are not inferable from the code
- rules the model repeatedly gets wrong without help

Link to supporting docs instead of copying long explanations into the always-on file.

### Path-Specific Instructions

Use `*.instructions.md` files with `applyTo` when rules only apply to part of the codebase.

Use them for:

- language-specific conventions
- framework-specific patterns
- test-only rules
- folder or layer boundaries

Prefer multiple small instruction files over one giant catch-all file.

### Prompt Files

Use prompt files for repeatable local workflows.

Good prompt files declare:

- the goal
- expected output format
- acceptance criteria
- validation gates
- any required user inputs

Prompt files should reuse linked instructions and docs instead of duplicating them.

### Custom Agents

Use custom agents when you need a persistent persona, restricted tools, or handoffs.

Good defaults:

- planning and review agents should be read-only by default
- implementation agents should only get the tools they actually need
- handoffs should move from planning to implementation to review, not skip directly to full autonomy unless the task justifies it

### Local Memory

Use the local memory tool intentionally:

- user memory for durable personal preferences
- repository memory for codebase facts and verified workflow rules
- session memory for temporary plans and task notes

Do not use memory as a dumping ground for long narratives. Store durable, reusable facts only.

## Model And Cost Defaults

Usage-based billing changes the shape of a good local workflow.

- Suggestions and next edit suggestions stay unbilled on paid plans.
- Chat and agent sessions consume AI credits.
- Always-on instructions increase repeated token cost, so keep them lean.

Practical defaults:

- use lightweight models for routine edits, explanations, and test scaffolding
- use GPT-5.4 mini or GPT-5.3-Codex when the task becomes tool-heavy or agentic
- use GPT-5.4, Claude Sonnet 4.6, or Gemini 3.1 Pro for harder debugging and architectural analysis
- use GPT-5.5 or Claude Opus 4.7 sparingly if you are on Pro+

## Session Discipline

Context quality drops when sessions accumulate unrelated work.

Use these rules:

- keep explore, plan, implement, and review in separate sessions when the task is non-trivial
- attach only relevant files, folders, or symbols
- tell Copilot to ask clarifying questions when requirements are ambiguous
- start a fresh session when the agent keeps dragging in stale context
- treat the Plan agent's session memory as temporary state, not as a permanent workflow document

## Verification Discipline

Reliable local Copilot use depends more on validation than on prompt cleverness.

Prefer this order:

1. targeted test or narrow validation for the touched slice
2. broader build, lint, or typecheck only when needed
3. human diff review before final acceptance

Additional rules:

- make validation explicit in the prompt
- review generated diffs before keeping them
- use checkpoints, undo, or a fresh session if an agent run starts to drift
- keep approval levels tight until the workflow has earned more autonomy

## Minimal Default Playbook

1. Start in Ask with the failing behavior, target files, or relevant context.
2. Switch to Plan if the work spans multiple files or has meaningful risk.
3. Refine the plan until the implementation and verification steps are acceptable.
4. Run the local Agent against the plan or explicitly referenced files.
5. Run a narrow validation step immediately after the first meaningful edit.
6. Only widen scope after that narrow check passes.
7. Capture stable lessons in instructions or repository memory instead of relying on giant chat histories.

## What Not To Do

- Do not default to the local Agent for tiny local edits.
- Do not put every convention in one always-on instructions file.
- Do not keep unrelated tasks in one long chat thread.
- Do not duplicate the same rules across instructions, prompts, and agents unless that duplication is deliberate.
- Do not leave validation implicit.

## Companion Documents

- billing context: [copilot-billing-cost-analysis.md](copilot-billing-cost-analysis.md)
- model reference: [copilot-model-reference-personal.md](copilot-model-reference-personal.md)
- broad flow comparison: [copilot-workflow-flows-comparison.md](copilot-workflow-flows-comparison.md)

## Sources

- [Best practices for using AI in VS Code](https://code.visualstudio.com/docs/copilot/best-practices)
- [Set up a context engineering flow in VS Code](https://code.visualstudio.com/docs/copilot/guides/context-engineering-guide)
- [Use custom instructions in VS Code](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
- [Custom agents in VS Code](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- [Use prompt files in VS Code](https://code.visualstudio.com/docs/copilot/customization/prompt-files)
- [Planning with agents in VS Code](https://code.visualstudio.com/docs/copilot/agents/planning)
- [Inline chat](https://code.visualstudio.com/docs/copilot/chat/inline-chat)
- [Inline suggestions from GitHub Copilot in VS Code](https://code.visualstudio.com/docs/copilot/ai-powered-suggestions)
- [Memory in VS Code agents](https://code.visualstudio.com/docs/copilot/agents/memory)
- [Prompt examples](https://code.visualstudio.com/docs/copilot/chat/prompt-examples)
- [Reliable AI workflow with GitHub Copilot: complete guide with examples](https://dev.to/petrashka/reliable-ai-workflow-with-github-copilot-complete-guide-with-examples-1bho)