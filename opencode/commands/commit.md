---
description: Generate a Conventional Commit message from the current git changes.
model: openai/gpt-5.6-luna
temperature: 0
---

Write one Conventional Commit message for the uncommitted git changes below.

!`git status --short`
!`git diff --stat`
!`git diff`

Return only:

```text
type(optional-scope): short imperative summary

- Detail 1
- Detail 2
- Detail 3
```

Use 2-6 bullets. Do not explain or repeat.
