# Review-First Change Workflow

Use this route when the risk is not in writing code but in understanding what could break.

## Example

1. Ask Kira to review the branch or diff.
2. Let the review workflow gather the actual diff and changed files.
3. Fix only the findings that are grounded in the code or diff.
4. Re-run validation after each meaningful fix slice.

## Why It Helps

- keeps findings ahead of summaries
- separates review evidence from implementation work
- avoids speculative cleanup during defect-focused changes
