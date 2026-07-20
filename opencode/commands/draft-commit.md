---
description: Draft a Conventional Commit message from the current git changes.
model: openai/gpt-5.4-mini
temperature: 0
---

Load and follow the `draft-commit-message` skill.

Draft one Conventional Commit message from the current worktree only. Do not
edit, stage, or commit files.

Return exactly one fenced `md` code block containing the commit message. Do
not add any explanation or surrounding text.

User constraints or intended file scope:
$ARGUMENTS
