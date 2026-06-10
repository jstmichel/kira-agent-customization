---
name: draft-commit-message
description: Draft a commit message from the current worktree only. Use when asked for a commit message and base it on git status and diffs, not chat history.
user-invocable: false
---

# Commit Message Drafting

Use this skill when the user wants a commit message for the current worktree.

## Workflow

1. Inspect only the current worktree state with terminal or source control context.
2. Use the minimum evidence needed, typically `git status --short`, `git diff --stat`, and targeted diffs for changed files.
3. Do not use chat history as evidence unless the user explicitly requests it.
4. Follow Conventional Commits with the shape `<type>[optional scope]: <description>`.
5. Add a short body only when it improves clarity.
6. Return exactly one fenced `md` code block.

## Output Rules

- Keep the subject specific and accurate.
- Do not mention files or changes that are not present in the worktree.
- Prefer a body with short bullet points when multiple distinct changes matter.
- Do not add surrounding explanation.

## Example Output

```md
feat(agents): add drafting worker for repository artifacts

- add a dedicated drafting agent for commit, PR, and ticket writing
- add supporting skills for repo-grounded drafting workflows
```