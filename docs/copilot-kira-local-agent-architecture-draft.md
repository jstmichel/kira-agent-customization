# Kira Local Agent Architecture Draft

- Date: 2026-05-12
- Status: Draft
- Scope: VS Code-only local development with GitHub Copilot, shared skills, and optional frontmatter handoffs between user-invocable custom agents

## Goal

Find a local workflow sweet spot that is more predictable than one general-purpose agent, but lighter and cheaper than a full multi-agent chain.

## Recommended Shape

Use a small three-agent layout:

| Agent | Role | Default Cost Posture | Primary Job |
| --- | --- | --- | --- |
| Kira | Lead agent | Low | Intake, direct answers, small local work, skill-aware routing, and user guidance |
| Kira :: Plan | Planning sub-agent | Medium | Clarify the task, map the implementation route, identify risks, and prepare a reviewable plan |
| Kira :: Code | Builder sub-agent | Medium | Implement the approved route, run focused validation, and finish the delivery loop |

This is intentionally not a conveyor belt.

The purpose is to separate workflow boundaries, not to create an agent for every engineering step.

## Why This Shape

- `Kira` stays cheap and fast for routine requests.
- `Kira :: Plan` isolates the expensive thinking when planning is actually needed.
- `Kira :: Code` owns implementation and validation so coding does not spill back into planning.
- Shared skills remain the specialization layer, which avoids creating a new agent every time a new workflow appears.

## Agent Responsibilities

### Kira

`Kira` is the main entry point.

Use `Kira` for:

- direct answers
- simple repo questions
- minor local edits
- requests that clearly map to an existing skill
- deciding whether the task should stay local, move to planning, or move straight to implementation

`Kira` should stay in-lane when:

- the task is obvious and low-risk
- the edit is small and local
- the user mainly needs explanation or guidance
- a skill can handle the workflow without opening a new stage

`Kira` should hand off when:

- the goal or acceptance criteria are unclear
- the change is risky, cross-file, or design-heavy
- the user explicitly wants a plan first
- implementation is substantial enough that a dedicated builder lane is cleaner

### Kira :: Plan

`Kira :: Plan` is planning-first.

Use `Kira :: Plan` for:

- ambiguous bugs
- risky refactors
- feature planning
- verification planning
- extracting goals, constraints, and acceptance criteria from a ticket-like request

`Kira :: Plan` should:

- gather only enough context to produce a credible route
- stay read-heavy and concise
- stop before implementation
- offer a clear handoff to `Kira :: Code` when the route is ready

`Kira :: Plan` should not become a second lead agent. Its job is planning, not general intake.

### Kira :: Code

`Kira :: Code` is execution-first.

Use `Kira :: Code` for:

- well-defined implementation work
- multi-file changes
- bug fixes with a stable hypothesis
- adding or updating tests for the changed behavior
- focused validation after edits

`Kira :: Code` should:

- work from a concrete anchor
- make the smallest grounded change first
- validate the first changed slice quickly
- continue until the implementation loop is complete or a real blocker appears

`Kira :: Code` should not perform broad design exploration. If the spec is unstable, it should stop and route back to planning.

## Handoff Rules

Keep handoffs explicit and limited.

Recommended buttons or redirect paths:

| From | To | Use When | Suggested Label |
| --- | --- | --- | --- |
| Kira | Kira :: Plan | The request needs planning before coding | Plan This |
| Kira | Kira :: Code | The task is implementation-ready | Build This |
| Kira :: Plan | Kira :: Code | The plan is approved and ready to execute | Start Build |
| Kira :: Code | Kira :: Plan | New ambiguity or architectural risk appears during coding | Replan |

Do not add more handoff edges until this smaller graph feels stable.

## Model Strategy

Use model defaults by lane instead of one fixed cost profile for every task.

| Agent | Model Posture |
| --- | --- |
| Kira | Cheap default or light general-purpose model |
| Kira :: Plan | Deeper reasoning default only when planning is actually invoked |
| Kira :: Code | Agentic implementation default for tool-heavy coding work |

This is the main reason this design can outperform one single custom agent with a fixed default model.

## Skills And Instructions Boundary

- Keep shared workflow capabilities in skills.
- Keep agent instructions focused on role, routing, stopping points, and handoff behavior.
- Do not copy the same workflow rules into every agent.
- Let `Kira` be aware of the skill catalog, but do not turn `Kira` into the executor for every specialized workflow.

## What Not To Add Yet

Do not start with dedicated sub-agents for:

- unit testing
- validation
- review
- commit drafting
- migration workflows already covered by skills

These are better kept inside the builder lane or inside shared skills until repeated usage proves a real boundary is needed.

## Decision Summary

If the repo wants predictability with low manual coordination, prefer this small handoff-based structure over both extremes:

- better than one agent that plans, builds, reviews, and validates in the same lane
- better than a long chain of specialized agents that adds orchestration overhead for every task

The intended sweet spot is:

- one lead agent
- one planner
- one builder
- shared skills underneath them

## Suggested Next Iteration

1. Keep this as a docs-only draft first.
2. Define draft prompts and frontmatter for `Kira`, `Kira :: Plan`, and `Kira :: Code`.
3. Pilot the three-agent layout before adding any extra sub-agent lanes.