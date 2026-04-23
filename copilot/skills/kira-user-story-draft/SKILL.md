---
name: kira-user-story-draft
description: "Draft a GitHub issue or user story from a feature description. Prefer project issue templates and project instructions when present; otherwise use a portable title/body workflow."
---

# User Story Draft Workflow

This is a portable personal skill. If the active project defines issue templates, story sections, naming rules, or acceptance-criteria conventions, those project rules override this workflow.

## Procedure

1. If the feature or bug description is missing, ask for it before proceeding.
2. Check `.github/ISSUE_TEMPLATE/` for an applicable template.
3. If a template exists, populate it with the provided details and inferred acceptance criteria.
4. If no template exists, ask which sections should be included before drafting.
5. Output the title in a code block containing only the title string.
6. Output the issue body in a separate code block.
7. Stop after drafting. Do not publish automatically.
