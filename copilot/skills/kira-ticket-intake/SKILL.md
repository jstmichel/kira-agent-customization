---
name: kira-ticket-intake
description: Use when you need to intake a GitHub issue, GitHub pull request, or Azure DevOps work item through CLI and normalize it into a compact ticket packet with title, context, acceptance criteria, risks, linked artifacts, and missing inputs.
argument-hint: "github issue 123 | github pr 45 | azure work item 678"
disable-model-invocation: true
---

# Kira Ticket Intake

Use this skill when the task starts from an external ticket and you need a compact, copy-pasteable packet before planning or implementation.

Use these references when relevant:

- [Workflow rules](../../instructions/kira-workflow.instructions.md)
- [Cost routing](../../instructions/kira-cost-routing.instructions.md)

## Procedure

1. Determine the source system from the request.
2. Gather the minimum identifiers needed to fetch the ticket.
3. Prefer the narrowest CLI fetch that returns the useful fields without pulling excessive chatter.
4. Normalize the result into one compact packet.
5. If access, authentication, extension setup, or identifiers are missing, say so explicitly instead of guessing.

## Source-specific guidance

### GitHub issues and pull requests

- Prefer `gh issue view <id> --comments` for issues when comment context matters.
- Prefer `gh pr view <id> --comments` for pull requests when review context matters.
- If the repository is ambiguous, ask for the repository or state that the input is incomplete.
- Keep the packet compact; summarize long comment threads instead of copying them verbatim.

### Azure DevOps work items

- Prefer `az boards work-item show --id <id>` when the Azure DevOps extension is available.
- If the Azure CLI extension, organization, or project context is missing, call that out clearly.
- Do not invent fields that Azure did not return.

## Output contract

Return exactly one fenced markdown block with this structure:

```markdown
# Ticket Packet: <title>
## Source
## Summary
## Acceptance Criteria
## Linked Artifacts
## Risks
## Open Questions
## Missing Inputs
```

## Notes

- Omit empty sections only when the source clearly lacks that information.
- Preserve exact identifiers such as issue number, PR number, or work item ID.
- Keep the packet optimized for handoff into planning or implementation.
