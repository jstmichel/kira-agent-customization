---
name: "plan"
description: "Turn a ticket or change request into a reviewable implementation plan before coding."
argument-hint: "GitHub issue, Azure ticket, feature, bug, or refactor to plan"
agent: "plan"
model: "GPT-5.4 mini (copilot)"
---

Plan this work before coding.

If the request is ticket-like, use the `kira-ticket-intake` workflow when available to resolve the ticket content first.

If provider, ticket identity, or ticket content is ambiguous, ask for the missing context instead of guessing.

Stop with a reviewable implementation and verification plan.

Do not implement the change.
