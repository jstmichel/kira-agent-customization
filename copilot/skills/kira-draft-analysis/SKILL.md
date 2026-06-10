---
name: draft-analysis
description: Draft or refresh a full implementation analysis from request, plan, or change context.
argument-hint: "request, ticket, plan, or diff context"
disable-model-invocation: true
---

# Draft Analysis

Use this skill to produce full analysis content in chat.

When asked to update an analysis, regenerate a full new analysis artifact instead of returning only changed sections.

Return exactly one fenced markdown block:

```markdown
# Analysis: <short title>
## Problem
## Assumptions
## Options
## Recommendation
## Risks
## Validation Approach
```