---
name: kira-draft-commit
description: Draft a Conventional Commits message from the current worktree, a supplied diff, or a concise change summary.
argument-hint: "optional diff, scope, or change summary"
disable-model-invocation: true
---

# Kira Draft Commit

Use these references when relevant:

- [Core rules](../../instructions/kira-core.md)
- [Drafting rules](../../instructions/kira-drafting.md)

Draft a commit message from the current worktree unless the user supplies a narrower diff.

## Requirements

- Follow Conventional Commits 1.0.0 exactly.
- Keep the subject line specific and concise.
- Add body bullets only when they materially help review.
- If the worktree intent is ambiguous, say what is unclear before drafting.

Return exactly one fenced text block.
