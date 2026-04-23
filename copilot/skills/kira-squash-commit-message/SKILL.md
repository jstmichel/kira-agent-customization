---
name: kira-squash-commit-message
description: "Generate a squash commit message from the current branch diff. Use when asked for a squash commit or merge commit message. Project instructions override this workflow; otherwise format as a conventional commit."
---

# Squash Commit Message Workflow

This is a portable personal skill. If the active project defines squash, merge, or release message rules, those project instructions override this workflow.

## Procedure

1. Run `git merge-base HEAD main` to find the branch point. If `main` fails, try `origin/main`.
2. Run `git log <merge-base>..HEAD --oneline` to inspect the branch history.
3. Run `git diff <merge-base>..HEAD --stat` to inspect the total changed surface.
4. Summarize the branch as one coherent change set.
5. If the project defines squash or merge message rules, apply them.
6. Otherwise format the message as a conventional commit with a single compact header and concise grouped body when needed:
   - header: `<type>(<scope>): <subject>` in lowercase, max 72 characters
   - body: optional bullet list for grouped changes
   - footer: add `BREAKING CHANGE: <description>` when required
7. Return the final message as a single markdown code block.
