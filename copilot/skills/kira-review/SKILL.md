---
name: kira-review
description: "Code review workflow. Use when the user asks to review this PR, review this branch, review this diff, find bugs or regressions, spot risky changes, or identify missing tests."
---

# Code Review Workflow

Perform an actual review. Retrieve the diff, inspect the changed files, and return findings ordered by severity. Do not stop at diff retrieval.

## Review Goals

- Prioritize bugs, behavioral regressions, broken assumptions, security concerns, data-loss risks, and missing tests.
- Treat style comments as low value unless they hide a real defect or violate an explicit rule.
- If there are no findings, say so explicitly and note any residual testing gaps or review limits.

## Workflow

1. Determine the review source:
	- GitHub PR URL or PR number
	- Azure DevOps PR URL or PR number
	- explicit branch comparison
	- current branch against its base when the user asks for a general review
2. Detect provider before retrieval:
	- Prefer explicit PR URLs.
	- If only a bare PR number is given, use remote host context when available.
	- If the user already states GitHub or Azure DevOps, use that explicit provider context.
	- If provider is still ambiguous, ask for missing PR context instead of guessing.
3. Retrieve enough context to review the change set:
	- PR title and body when available
	- file list or diff stat
	- full diff for changed files
4. Read the most relevant changed files directly when the diff alone is not enough to judge behavior.
5. Produce findings with concrete evidence. Do not invent issues.

## Diff Retrieval

### GitHub PR

1. Run `gh pr view <N> --json title,body,baseRefName,headRefName,files`.
2. Run `gh pr diff <N>`.
3. If `gh` is unavailable, ask for the PR URL or source and target branches.
4. Use `git fetch origin` then `git diff origin/<base>...origin/<head>` after resolving the branch names.

### Azure DevOps PR

1. Run `az repos pr show --id <N> --output json`.
2. Resolve source and target branches from the PR metadata.
3. Run `git fetch origin` then `git diff origin/<targetBranch>...origin/<sourceBranch>`.
4. If `az` is unavailable, ask for the source and target branch names and fall back to `git diff`.

### Branch Comparison

1. Run `git fetch origin`.
2. Run `git diff origin/<base>...origin/<feature> --stat`.
3. Run `git diff origin/<base>...origin/<feature>`.

## Output Format

Return findings first.

- If findings exist, list each one with severity, the affected file, and the concrete risk or regression.
- If no findings exist, state that explicitly.
- After findings, add `Open Questions / Assumptions` only when needed.
- End with a short change summary or testing gap note only as secondary detail.