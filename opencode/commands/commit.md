---
description: Draft a commit message, stage the intended changes, and commit them.
model: openai/gpt-5.4-mini
temperature: 0
---

Load and follow the `draft-commit-message` skill.

Draft one Conventional Commit message from the current worktree, then stage
the intended changed files and create one commit using exactly that message.

Before staging, inspect `git status --short` and the relevant diffs. Do not
stage unrelated user changes when the intended file set can be identified. Do
not use `git add -A` blindly. Include intended untracked files when they are
part of the current change.

Use a temporary commit message file or another safe multiline mechanism so the
commit body is preserved exactly. Do not amend an existing commit, force
anything, reset files, or remove unrelated worktree changes.

If there are no intended changes, do not create an empty commit. If staging or
the commit hook fails, preserve the worktree and report the failure without
retrying destructively.

User constraints or intended file scope:
$ARGUMENTS

After a successful commit, report the commit hash and the final `git status
--short` result.
