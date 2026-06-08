---
name: kira-create-adr
description: Draft an ADR from a ticket, plan, change request, architecture review, or diff when the task needs a concrete decision record.
argument-hint: "ticket, plan, request, diff, or architecture review"
disable-model-invocation: true
---

# Kira Create ADR

Use these references when relevant:

- [Core rules](../../instructions/kira-core.md)
- [Drafting rules](../../instructions/kira-drafting.md)

Create an ADR draft from the supplied ticket, plan, request, or diff.

## Requirements

- Ask for clarification only when a missing detail blocks a concrete decision.
- Keep the draft lean and avoid repeating source material verbatim.
- Include assumptions only when they materially affect the decision.
- Recommend `kira-architect` only when the decision needs deeper architecture review and the user has explicitly asked for escalation or subagents.
- When the task outcome should be a saved ADR, include a recommended path for the parent workflow to write.

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
