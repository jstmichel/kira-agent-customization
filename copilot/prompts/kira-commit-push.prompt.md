---
name: commit-and-push-with-kira
description: Stage all changes, commit using a conventional commit message, and push to the current remote branch.
agent: Kira
model: GPT-5 mini (copilot)
tools: [execute]
---

Use the `kira-commit-message` skill to generate a commit message from the current changes, then push.

## Steps

1. Run `git diff --stat` to see what is unstaged, and `git diff --cached --stat` to see what is already staged.
2. Stage all changes with `git add -A`.
3. Run `git diff --cached` to inspect the full staged diff.
4. Follow the `kira-commit-message` skill procedure to generate a conventional commit message from the diff.
5. Commit with the generated message.
6. Push with `git push`.
7. Confirm the commit hash, the full commit message, and the push status.
