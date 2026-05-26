# Kira Change Flow Next Steps

- Date: 2026-05-25
- Status: Evaluation note
- Scope: Possible follow-up work for the current reusable change flow in [kira-change-flow.md](kira-change-flow.md)

## Why This Exists

The current flow already gives a clear lane choice between design, planning, implementation, and commit drafting.

This note is for deciding whether the flow needs to grow further, or whether it is already small enough to stay as-is.

## Possible Next Steps

### 1. Add a review lane prompt

Create a dedicated review entrypoint for code review, PR feedback, and branch diffs.

Worth it if:

- review work is common enough to deserve its own prompt
- you want the review workflow to be as explicit as the planning and implementation lanes

Probably not needed yet if:

- you already use Kira directly for reviews without friction
- the current change flow is only meant to route creation work, not review work

### 2. Split planning into lightweight and full planning

Add a fast planning path for small tasks and keep the existing plan flow for higher-risk work.

Worth it if:

- you often pause on whether a task needs a full plan
- you want a cheaper decision path for small edits that still benefits from structure

Probably not needed yet if:

- the current plan prompt is already cheap enough in practice
- you rarely hesitate between planning and implementation

### 3. Add a maintenance lane

Create a lane for doc cleanup, asset validation, prompt tuning, and repo hygiene.

Worth it if:

- maintenance tasks are frequent and feel distinct from implementation work
- you want a prompt that optimizes for low-risk upkeep instead of feature delivery

Probably not needed yet if:

- maintenance work is still comfortably handled through the implementation lane

### 4. Add a decision cheat sheet

Keep the current flow, but add a one-screen summary that maps common intents to the right lane.

Worth it if:

- you want faster self-service routing
- you keep second-guessing which prompt to use for a task

Probably not needed yet if:

- the current flow already feels obvious after a quick read

### 5. Add examples for edge cases

Document a few concrete scenarios, like prompt cleanup, cross-file refactors, doc-only changes, or review follow-up.

Worth it if:

- you expect the flow to be reused by other people or future-you after some time away
- you want less ambiguity around borderline tasks

Probably not needed yet if:

- the existing lane descriptions already answer most routing questions

## A Simple Decision Rule

Keep the current flow unchanged unless one of these is true:

- you are repeatedly hesitating between two lanes
- a common task type has no obvious home
- a new lane would remove real confusion, not just add symmetry

If none of those are happening, the safest next step is to leave the flow alone and only add examples or a short cheat sheet.

## Suggested Order If You Do Expand It

1. Add examples for edge cases.
2. Add a short decision cheat sheet.
3. Split planning only if the current plan lane feels too broad.
4. Add a review lane only if review work becomes a regular first-class workflow.
5. Add a maintenance lane only if upkeep work starts competing with implementation work.

## Bottom Line

The current flow is already coherent and small.

The most conservative next step is not to add another lane yet, but to document a few examples or a cheat sheet if you want easier routing later.