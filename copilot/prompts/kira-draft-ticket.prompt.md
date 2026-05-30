---
name: "kira-draft-ticket"
description: "Draft ticket content or an update from a request, plan, or implemented change."
agent: "Kira :: Diff"
---

Use these references when relevant:

- [Workflow rules](../instructions/kira-workflow.instructions.md)
- [Drafting rules](../instructions/kira-drafting.instructions.md)

Draft ticket-ready content from the supplied request, plan, or implemented change.

Requirements:

- optimize for copy-paste into GitHub or Azure work items
- keep acceptance criteria concrete and testable when included
- include rollout or follow-up notes only when the source material supports them
- if key details are missing, include a short `Missing Inputs` section inside the draft

Return exactly one fenced markdown block with this structure:

```markdown
# <title>
## Summary
## Acceptance Criteria
## Notes
```
