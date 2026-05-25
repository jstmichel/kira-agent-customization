---
name: "plan"
description: "Turn a ticket or change request into a reviewable implementation plan before coding."
argument-hint: "GitHub issue, Azure ticket, feature, bug, or refactor to plan"
agent: "Kira"
model: "GPT-5.4 mini (copilot)"
---

Plan this work before coding.

If the request is ticket-like, use the `kira-ticket-intake` workflow when available to resolve the ticket content first.

Then use the `kira-architecture` workflow in planning mode to produce the reviewable implementation and verification plan.

If provider, ticket identity, or ticket content is ambiguous, ask for the missing context instead of guessing.

Stop with a reviewable implementation and verification plan.

Do not implement the change.
