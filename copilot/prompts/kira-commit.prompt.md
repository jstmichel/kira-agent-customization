---
name: commit-with-kira
description: Stage all changes and commit using a conventional commit message generated from the diff.
agent: Kira
model: GPT-5 mini (copilot)
tools: [execute]
---

Use the `kira-commit-message` skill to generate a commit message from the current changes.

## Steps

1. Run `git diff --stat` to see what is unstaged, and `git diff --cached --stat` to see what is already staged.
2. Stage all changes with `git add -A`.
3. Run `git diff --cached` to inspect the full staged diff.
4. Follow the `kira-commit-message` skill procedure to generate a conventional commit message from the diff.
5. Commit with the generated message.
6. Confirm the commit hash and the full commit message.

Do not push.
