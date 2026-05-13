---
name: kira-ticket-intake
description: "Ticket intake workflow. Use when the user provides a GitHub issue reference, Azure DevOps work item reference, or a ticket-like identifier that must be resolved before planning or implementation."
---

# Ticket Intake Workflow

Resolve ticket identity and content before planning or implementation. Do not guess from ambiguous identifiers.

## Intake Goals

- Determine provider: GitHub, Azure DevOps, or user-pasted ticket content.
- Retrieve ticket content when a provider-specific path is available.
- Extract the delivery anchors: goal, constraints, acceptance criteria, linked technical context.
- Stop and ask for missing context when provider or identity is ambiguous.

## Provider Detection Order

1. Prefer explicit ticket URLs:
	- GitHub issue URL
	- Azure DevOps work item URL
2. If no URL is provided, use explicit user context (for example: "GitHub issue" or "Azure work item").
3. If only a bare identifier is provided, use host/repo context when available.
4. If still ambiguous, ask for provider confirmation and do not guess.

## Retrieval Paths

### GitHub Issue

1. Run `gh issue view <N> --json title,body,url,labels,assignees` when repository context is known.
2. If repository context is not known, ask for the issue URL or `<owner>/<repo>#<number>`.
3. If `gh` is unavailable, ask for the ticket link or pasted ticket content.

### Azure DevOps Work Item

1. Run `az boards work-item show --id <N> --output json`.
2. If `az` is unavailable or not configured, ask for the ticket link or pasted ticket content.

### Pasted Ticket Content

1. Parse the provided text directly.
2. If required fields are missing, ask focused follow-up questions.

## Extraction Checklist

Always extract:

- Goal
- Constraints
- Acceptance Criteria
- Linked Technical Context

## Stop Conditions

Stop and ask for clarification when:

- provider cannot be determined confidently
- retrieval tooling is unavailable and no usable ticket text is provided
- the ticket content is incomplete or contradictory

Never fabricate ticket details.