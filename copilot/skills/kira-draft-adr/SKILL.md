---
name: draft-adr
description: Draft a concise ADR from request, plan, or change context.
argument-hint: "request, ticket, plan, or diff context"
disable-model-invocation: true
---

# Draft ADR

Use this skill to produce ADR content in chat when a design decision is already requested.

Return exactly one fenced markdown block:

```markdown
# ADR: <short title>
## Status
## Context
## Decision
## Consequences
## Validation Notes
```