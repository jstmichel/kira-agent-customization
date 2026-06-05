---
name: "kira-create-analysis"
description: "Draft an implementation analysis note from a ticket, plan, or request."
agent: "Kira :: Architect"
---

Use these references when relevant:

- [Workflow rules](../instructions/kira-core.instructions.md)
- [Drafting rules](../instructions/kira-drafting.instructions.md)

Create an analysis note before implementation starts.

Use this when the task needs option analysis or a recommendation, not just wording cleanup.

Requirements:

- identify the problem, assumptions, options, recommendation, and risks
- keep the note decision-oriented rather than exploratory filler
- call out missing inputs if they block a sound recommendation
- when the task outcome should be a saved analysis document, include a recommended path for `Kira` to write after handoff

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
