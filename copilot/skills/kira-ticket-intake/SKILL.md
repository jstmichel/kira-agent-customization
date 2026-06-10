---
name: kira-ticket-intake
description: Normalize a GitHub issue, pull request, or Azure DevOps work item into a compact execution packet.
argument-hint: "github issue 123 | github pr 45 | azure work item 678"
disable-model-invocation: true
---

# Ticket Intake

Use this skill when the task starts from an external ticket and `Kira` or `Kira :: Intake` needs a compact packet before planning or implementation.

## Procedure

1. Identify the source system and the minimum identifiers needed to fetch the item.
2. Use the narrowest read-only CLI command that returns useful context.
3. Summarize the result into a compact handoff packet instead of copying long threads verbatim.
4. If access, setup, repository, project, or identifiers are missing, call that out explicitly.

## Source guidance

- GitHub issue or PR: prefer `gh issue view <id> --comments` or `gh pr view <id> --comments` when discussion context matters.
- Azure DevOps work item: prefer `az boards work-item show --id <id>` when extension and org context are available.

## Output contract

Return exactly one fenced markdown block with this structure:

```markdown
# Intake Packet
## Request Type
## Source
## Goal
## Current Context
## Acceptance Criteria
## Constraints
## Likely Impacted Areas
## Decision Needed
## Suggested First Step
## Blocking Unknowns
## Unknowns
## Recommended Next Step
## Recommended Escalation
## Missing Inputs
```
