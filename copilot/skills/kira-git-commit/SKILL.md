---
name: kira-git-commit
description: "Git commit execution workflow. Use when the user says commit this, create the commit now, run git commit, or commit the staged changes."
---

# Git Commit Workflow

Use this skill only when the user explicitly wants the commit to be created.

## Safety Rules

1. Never stage files in this workflow.
2. Never commit unstaged changes.
3. Stop if there are no staged changes.
4. If the user provides an explicit commit message, use it.
5. Otherwise generate the message from the staged diff using the active commit-format instruction and the same drafting logic as the commit-message drafting workflow.

## Procedure

1. Run `git diff --cached --stat`.
2. If nothing is staged, stop and tell the user there is nothing staged to commit.
3. If the user did not provide a commit message, run `git diff --cached` and draft the message from the staged changes.
4. Write the final message to a temporary file.
5. Run `git commit -F <temp-file>`.
6. Remove the temporary file.
7. Run `git log -1 --pretty=format:%H%n%s`.
8. Return the new commit hash and subject.