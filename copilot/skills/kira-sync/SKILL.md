---
name: kira-sync
description: "Full git sync: commit any local changes, pull from remote, and push. Uses kira-commit-message for the commit message. Stops and reports conflicts clearly if the pull produces a merge conflict."
argument-hint: "Optional commit scope or emphasis to pass to kira-commit-message"
---

# Sync Workflow

Use this skill when asked to sync, sync with remote, or do a full fetch/pull/commit/push cycle.

## Procedure

### 1 — Snapshot state

Run the following to understand the starting position:

```
git fetch
git status --short --branch
git diff --stat
git diff --cached --stat
```

### 2 — Commit local changes (if any)

If there are staged or unstaged changes, apply the `kira-commit-message` skill:

1. Stage all changes with `git add -A`.
2. Follow the `kira-commit-message` skill to generate a conventional commit message from the staged diff.
3. Commit with the generated message.

If the working tree is clean, skip this step.

### 3 — Pull

```
git pull
```

If the pull produces a merge conflict:

- **Stop immediately. Do not continue to push.**
- Run `git diff --name-only --diff-filter=U` to list every conflicting file.
- Report the full list clearly to the user with instructions to resolve each conflict, then run `git add <file>` and `git commit` to finalize the merge before re-running this skill.

### 4 — Push

```
git push
```

### 5 — Confirm

Report:
- Commit hash and message (if a commit was made in step 2)
- Current branch and its upstream tracking status (`git status --short --branch`)
- Push result (ref updated, already up to date, or error)
