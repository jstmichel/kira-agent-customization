---
name: "kira-create-adr"
description: "Draft an ADR from a ticket, plan, or change request."
agent: "Kira :: Architect"
---

Use these references when relevant:

- [Workflow rules](../instructions/kira-core.instructions.md)
- [Drafting rules](../instructions/kira-drafting.instructions.md)

Create an ADR draft from the supplied ticket, plan, request, or diff.

Requirements:

- ask for clarification only when a missing detail blocks a concrete decision
- keep the draft lean and avoid repeating source material verbatim
- include assumptions only when they materially affect the decision
- do not write files unless the active agent explicitly has edit access and the user asked for a file change
- if you cannot write files and the user wants persistence, include a recommended path for `Kira` to write after handoff

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
