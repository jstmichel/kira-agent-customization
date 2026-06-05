---
name: kira-change-docs
description: Use when you need ADR and analysis documentation from a ticket, plan, request, or implemented change, with lean decision-oriented output that can be saved by an edit-capable agent or returned in chat.
argument-hint: "ticket, plan, request, or diff context"
disable-model-invocation: true
---

# Kira Change Docs

Use this skill when the task needs decision documentation before or after implementation.

 Use these references when relevant:
 
 - [Workflow rules](../../instructions/kira-core.instructions.md)

## Procedure

1. Read the supplied ticket, plan, request, or diff.
2. Identify the decision that needs to be documented.
3. Extract the assumptions, alternatives, recommendation, risks, and validation expectations.
4. Produce an analysis draft, an ADR draft, or both, depending on the request.
5. Return the artifact in chat when the task is primarily asking for draft content.
6. Write the requested documents to the repository when the user asked to save them or when saving is the logical outcome of the task.
7. If the active agent cannot write the files that should be saved, return drafts and recommended target paths for an edit-capable agent to write.

## Analysis draft rules

- Focus on the problem, assumptions, options, recommendation, risks, and validation approach.
- Keep the note decision-oriented rather than speculative.
- If critical inputs are missing, name them explicitly.

## ADR draft rules

- Focus on context, decision, consequences, and validation notes.
- Keep the ADR compact and avoid copying the source material verbatim.
- Use assumptions only when they materially affect the decision.
- Prefer `docs/adr/YYYY-MM-DD-short-title.md` for ADR file paths unless the repository has an existing convention.

## Output contract

If the request asks for both artifacts and they are being returned in chat, return exactly two fenced markdown blocks in this order.

First block:

```markdown
# Analysis: <short title>
## Problem
## Assumptions
## Options
## Recommendation
## Risks
## Validation Approach
```

Second block:

```markdown
# ADR: <short title>
## Status
## Context
## Decision
## Consequences
## Validation Notes
```

If the request asks for only one artifact and it is being returned in chat, return only the relevant fenced block.
