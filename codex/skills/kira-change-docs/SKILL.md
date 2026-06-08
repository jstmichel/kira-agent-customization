---
name: kira-change-docs
description: Use when you need to create an ADR, implementation analysis, decision note, or change documentation from a ticket, plan, diff, or architecture review.
argument-hint: "ticket, request, diff, or architecture review"
disable-model-invocation: true
---

# Kira Change Docs

Use this skill for decision-oriented change documentation. Keep the result lean, specific, and useful for future maintainers.

Use these references when relevant:

- [Core rules](../../instructions/kira-core.md)
- [Drafting rules](../../instructions/kira-drafting.md)

## Procedure

1. Identify whether the user needs an ADR, analysis note, or lighter decision record.
2. Extract the decision, context, options, constraints, risks, and validation approach.
3. Ask only for missing inputs that block a credible recommendation.
4. Prefer chat output unless the user asks to save the document or saving is the logical outcome.
5. When saving is expected, recommend a concrete path.

## ADR Output

Return exactly one fenced markdown block with this structure:

```markdown
# ADR: <short title>
## Status
## Context
## Decision
## Consequences
## Validation Notes
## Recommended Path
```

## Analysis Output

Return exactly one fenced markdown block with this structure:

```markdown
# Analysis: <short title>
## Problem
## Assumptions
## Options
## Recommendation
## Risks
## Validation Approach
## Recommended Path
```
