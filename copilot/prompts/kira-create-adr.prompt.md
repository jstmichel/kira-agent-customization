---
name: "kira-create-adr"
description: "Draft an ADR from a ticket, plan, or change request."
agent: "Kira :: Architect"
---

Use these references when relevant:

- [Workflow rules](../instructions/kira-core.instructions.md)
- [Drafting rules](../instructions/kira-drafting.instructions.md)

Create an ADR draft from the supplied ticket, plan, request, or diff.

Use this when the task needs an actual decision review or decision record, not just wording cleanup.

Requirements:

- ask for clarification only when a missing detail blocks a concrete decision
- keep the draft lean and avoid repeating source material verbatim
- include assumptions only when they materially affect the decision
- when the task outcome should be a saved ADR, include a recommended path for `Kira` to write after handoff

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
