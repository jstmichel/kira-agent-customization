---
name: kira-pr-create
description: "Create a pull request on GitHub or Azure DevOps. Detects the platform from the remote URL, generates a PR description using kira-pr-description, then opens the PR via CLI. Use when asked to open a PR, create a pull request, or raise a merge request."
argument-hint: "Optional base branch, PR title hint, or draft flag"
---

# PR Creation Workflow

Use this skill when a pull request should be created from the current branch.

If the active project defines a PR template, contribution guide, or required reviewers, those rules override the defaults in this workflow.

## Procedure

### 1 — Detect platform

```
git remote get-url origin
```

- URL contains `github.com` → **GitHub** (`gh` CLI)
- URL contains `dev.azure.com` or `visualstudio.com` → **Azure DevOps** (`az repos` CLI)
- Anything else → stop and report the remote URL to the user; ask them which platform to target.

Verify the required CLI is available (`gh --version` or `az --version`). If it is missing, stop and tell the user which tool to install.

### 2 — Determine base branch

- Use the base branch provided by the user if given.
- Otherwise use the repository default branch:
  ```
  git remote show origin | grep 'HEAD branch' | awk '{print $NF}'
  ```

### 3 — Check for unpushed commits

```
git status --short --branch
```

If the local branch is ahead of its remote, stop and tell the user to push first (or surface the **Commit & Push** handoff).

### 4 — Generate PR description

Apply the `kira-pr-description` skill to produce the title and body.

- **Title**: derive from the conventional commit summary or the branch name if no clean commit subject is available. Keep it under 72 characters.
- **Body**: the markdown output from `kira-pr-description`.

### 5 — Create the PR

**GitHub:**
```
gh pr create \
  --base <base-branch> \
  --title "<title>" \
  --body "<body>"
```
Add `--draft` if the user requested a draft PR.

**Azure DevOps:**
```
az repos pr create \
  --target-branch <base-branch> \
  --title "<title>" \
  --description "<body>" \
  --open
```
Add `--draft` if the user requested a draft PR.

### 6 — Confirm

Report:
- PR URL
- Title
- Base branch ← Head branch
- Draft status (if applicable)
