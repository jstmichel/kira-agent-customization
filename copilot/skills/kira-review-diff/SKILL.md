---
name: kira-review-diff
description: "Fetch diff content for code review. Use when: retrieving a PR diff from GitHub or Azure DevOps, or comparing two branches via git."
---

# Review Diff Retrieval

## GitHub

```bash
# Fetch PR metadata and file list
gh pr view <N> --json title,body,baseRefName,headRefName,files

# Fetch the full diff
gh pr diff <N>
```

If `gh` is not authenticated or not installed, fall back to:
```bash
git fetch origin
git diff origin/<base>...origin/<head>
```

## Azure DevOps

```bash
# Fetch PR metadata
az repos pr show --id <N> --output json

# Get the file list
az repos pr list --status active --output json  # if ID not known

# Fetch the diff — use git after resolving branch names from the PR
git fetch origin
git diff origin/<targetBranch>...origin/<sourceBranch>
```

If `az` is not authenticated or not installed, ask the user to provide the source and target branch names and fall back to `git diff`.

## Branch Comparison

```bash
git fetch origin
git diff origin/<base>...origin/<feature> --stat      # file list
git diff origin/<base>...origin/<feature>             # full diff
```
