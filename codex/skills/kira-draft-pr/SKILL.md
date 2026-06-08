---
name: kira-draft-pr
description: Draft a pull request description from the current branch versus parent branch, a supplied diff, or a concise change summary.
argument-hint: "optional base branch, diff, or change summary"
disable-model-invocation: true
---

# Kira Draft PR

Use these references when relevant:

- [Core rules](../../instructions/kira-core.md)
- [Drafting rules](../../instructions/kira-drafting.md)

Draft a pull request description from the current branch versus its parent branch.

## Defaults

- Compare against the upstream tracking branch first.
- If no upstream branch is configured, compare against the repository default branch.

## Requirements

- Summarize the user-visible change first.
- List key implementation points without turning the output into a changelog dump.
- Include validation results only when they are known.
- Call out risk or follow-up only when it is real.

Return exactly one fenced markdown block with this structure:

```markdown
## Summary
## Changes
## Validation
## Risks
```
