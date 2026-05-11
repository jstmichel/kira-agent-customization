---
name: kira-pr-description
description: "Generate a pull request description from the current branch diff against the base branch. Use when asked for PR text, merge request text, branch summary, or review-ready change notes."
argument-hint: "Optional base branch, PR number, or extra reviewer context"
---

# Pull Request Description Workflow

Use this skill when a pull request description should be drafted from the current branch.

If the active project defines a PR template, contribution guide, or repository-specific review format, those rules override this workflow.

## Procedure

1. Determine the base branch:
   - use the branch or PR context provided by the user when available
   - otherwise use the repository default branch or the current PR base branch
2. Run `git fetch origin` before comparing branches.
3. Run `git diff --stat origin/<base>...HEAD` to identify the changed file set.
4. Run `git diff origin/<base>...HEAD` to inspect the actual branch diff.
5. Summarize the change in reviewer-oriented terms:
   - why the change exists
   - what changed
   - how it was validated
   - what risks, follow-ups, or deployment notes remain
6. If the project has a PR template, populate that structure.
7. Otherwise return a concise markdown description with these sections:
   - Summary
   - Changes
   - Validation
   - Risks or Notes

## Output

Return the PR description as ready-to-paste markdown.