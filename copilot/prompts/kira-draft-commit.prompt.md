---
name: "kira-draft-commit"
description: "Draft a Conventional Commits message from the current worktree by default."
agent: "Kira :: Diff"
---

Use these references when relevant:

- [Workflow rules](../instructions/kira-workflow.instructions.md)
- [Drafting rules](../instructions/kira-drafting.instructions.md)

Draft a commit message from the current worktree unless the user supplies a narrower diff.

Requirements:

- follow Conventional Commits 1.0.0 exactly
- keep the subject line specific and concise
- add body bullets only when they materially help review
- if the worktree intent is ambiguous, say what is unclear before drafting

Return exactly one fenced text block.
