---
name: "kira-draft-pr"
description: "Draft a pull request description from branch versus parent diff."
agent: "Kira :: Diff"
---

Use these references when relevant:

- [Workflow rules](../instructions/kira-core.instructions.md)
- [Drafting rules](../instructions/kira-drafting.instructions.md)

Draft a pull request description from the current branch versus its parent branch.

Defaults:

- compare against the upstream tracking branch first
- if no upstream branch is configured, compare against the repository default branch

Requirements:

- summarize the user-visible change first
- list key implementation points without turning the output into a changelog dump
- include validation results only when they are known
- call out risk or follow-up only when it is real

Return exactly one fenced markdown block with this structure:

```markdown
## Summary
## Changes
## Validation
## Risks
```
