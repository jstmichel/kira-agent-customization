---
name: kira-create-analysis
description: Draft an implementation analysis note from a ticket, plan, request, diff, or architecture review when the task needs option analysis and a recommendation.
argument-hint: "ticket, plan, request, diff, or architecture review"
disable-model-invocation: true
---

# Kira Create Analysis

Use these references when relevant:

- [Core rules](../../instructions/kira-core.md)
- [Drafting rules](../../instructions/kira-drafting.md)

Create an analysis note before implementation starts.

## Requirements

- Identify the problem, assumptions, options, recommendation, and risks.
- Keep the note decision-oriented rather than exploratory filler.
- Call out missing inputs if they block a sound recommendation.
- Recommend `kira-architect` only when deeper design review is required and the user has explicitly asked for escalation or subagents.
- When the task outcome should be a saved analysis document, include a recommended path for the parent workflow to write.

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
