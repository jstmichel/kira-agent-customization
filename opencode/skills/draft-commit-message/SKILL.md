---
name: draft-commit-message
description: Draft one accurate Conventional Commit message from the current worktree. Use when reviewing changes for a commit or preparing a commit.
---

# Draft Commit Message

Use the current worktree as the source of truth. Do not use chat history unless
the user explicitly asks for it.

1. Inspect `git status --short`.
2. Inspect `git diff --stat` and relevant `git diff` output.
3. Inspect staged diff output when staged changes are part of the intended commit.
4. Account for intended untracked files when their contents are available.
5. Write one Conventional Commit message with an imperative subject.
6. Add 2-6 concise body bullets only when multiple distinct changes need context.

Return exactly one fenced `md` code block and no surrounding explanation. Do
not mention changes that are not present in the intended worktree changes.
