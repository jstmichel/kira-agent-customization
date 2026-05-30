---
name: "kira-create-analysis"
description: "Draft an implementation analysis note from a ticket, plan, or request."
agent: "Kira :: Mapper"
---

Use these references when relevant:

- [Workflow rules](../instructions/kira-workflow.instructions.md)
- [Drafting rules](../instructions/kira-drafting.instructions.md)

Create an analysis note before implementation starts.

Requirements:

- identify the problem, assumptions, options, recommendation, and risks
- keep the note decision-oriented rather than exploratory filler
- call out missing inputs if they block a sound recommendation
- do not write files unless the active agent explicitly has edit access and the user asked for a file change

Return exactly one fenced markdown block with this structure:

```markdown
# Analysis: <short title>
## Problem
## Assumptions
## Options
## Recommendation
## Risks
## Validation Approach
```
