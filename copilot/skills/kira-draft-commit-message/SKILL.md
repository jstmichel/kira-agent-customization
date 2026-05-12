---
name: kira-draft-commit-message
description: "Commit message drafting workflow. Use when the user asks to write, draft, suggest, or generate a commit message, squash commit message, or merge commit message without creating the commit."
---

# Commit Message Draft Workflow

This is a portable personal skill. If the active project defines commit, squash, merge, release, or changelog rules, those project instructions override this workflow.

## Mode Detection

1. If the user asks for a squash or merge commit message, use branch-summary mode.
2. If the user already provides the relevant change summary or diff content, use provided-summary mode.
3. Otherwise default to staged mode.

## Procedure

### Staged Mode

1. Run `git diff --cached --stat` to identify the staged file set.
2. If nothing is staged, ask the user whether they want a branch-summary message instead.
3. Run `git diff --cached` to inspect the staged changes.
4. Summarize the actual change intent, not just the file names.

### Branch-Summary Mode

1. Run `git merge-base HEAD main` to find the branch point. If `main` fails, try `origin/main`.
2. Run `git log <merge-base>..HEAD --oneline` to inspect the branch history.
3. Run `git diff <merge-base>..HEAD --stat` to inspect the changed surface.
4. Summarize the branch as one coherent change set.

### Provided-Summary Mode

1. Use the change summary, diff text, or bullet list provided by the user.
2. Ask a follow-up only if the change intent is too ambiguous to name accurately.

## Output

1. Apply project-defined commit rules first.
2. Otherwise follow any active commit-format instruction.
3. Return the final message as a single markdown code block containing only the message.