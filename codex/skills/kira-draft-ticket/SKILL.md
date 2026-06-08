---
name: kira-draft-ticket
description: Draft ticket content or a ticket update from a request, plan, analysis, or implemented change.
argument-hint: "request, plan, analysis, diff, or implemented change"
disable-model-invocation: true
---

# Kira Draft Ticket

Use these references when relevant:

- [Core rules](../../instructions/kira-core.md)
- [Drafting rules](../../instructions/kira-drafting.md)

Draft ticket-ready content from the supplied request, plan, or implemented change.

## Requirements

- Optimize for copy-paste into GitHub or Azure work items.
- Keep acceptance criteria concrete and testable when included.
- Include rollout or follow-up notes only when the source material supports them.
- If key details are missing, include a short `Missing Inputs` section inside the draft.

Return exactly one fenced markdown block with this structure:

```markdown
# <title>
## Summary
## Acceptance Criteria
## Notes
```
