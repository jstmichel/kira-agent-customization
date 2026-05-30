---
name: kira-change-docs
description: Use when you need ADR and analysis documentation from a ticket, plan, request, or implemented change, with lean decision-oriented output that can be pasted into repository docs or chat.
argument-hint: "ticket, plan, request, or diff context"
disable-model-invocation: true
---

# Kira Change Docs

Use this skill when the task needs decision documentation before or after implementation.

Use these references when relevant:

- [Workflow rules](../../instructions/kira-workflow.instructions.md)
- [Drafting rules](../../instructions/kira-drafting.instructions.md)
- [Cost routing](../../instructions/kira-cost-routing.instructions.md)

## Procedure

1. Read the supplied ticket, plan, request, or diff.
2. Identify the decision that needs to be documented.
3. Extract the assumptions, alternatives, recommendation, risks, and validation expectations.
4. Produce an analysis draft, an ADR draft, or both, depending on the request.
5. If the active agent has no edit access, return drafts in chat only.
6. If the active agent has edit access and the user explicitly asked to save files, write the requested documents to the repository.

## Analysis draft rules

- Focus on the problem, assumptions, options, recommendation, risks, and validation approach.
- Keep the note decision-oriented rather than speculative.
- If critical inputs are missing, name them explicitly.

## ADR draft rules

- Focus on context, decision, consequences, and validation notes.
- Keep the ADR compact and avoid copying the source material verbatim.
- Use assumptions only when they materially affect the decision.

## Output contract

If the request asks for both artifacts, return exactly two fenced markdown blocks in this order.

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

If the request asks for only one artifact, return only the relevant fenced block.
