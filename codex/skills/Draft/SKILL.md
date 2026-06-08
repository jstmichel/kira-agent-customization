---
name: Draft
description: Use when the user invokes /Draft or asks to spawn the Kira Draft agent for commit messages, PR descriptions, ticket text, changelog notes, summaries, or other wording-focused artifacts.
argument-hint: "commit, PR, ticket, changelog, summary, or wording request"
disable-model-invocation: true
---

# Draft Handoff

Use this skill as a slash-style handoff prompt for low-cost drafting.

## Procedure

1. Treat this as explicit permission to spawn a specialist agent.
2. Spawn `kira-draft` with the requested artifact type and the smallest useful context.
3. Prefer supplying a diff, summary, ticket, or concrete notes over broad repository context.
4. Return the draft directly unless the user asked for explanation.

## Spawn Prompt Shape

Send a compact prompt like:

```text
Draft the requested wording artifact.

Artifact:
<commit message | PR description | ticket | changelog | summary | other>

Source context:
<user request, diff summary, ticket details, or relevant notes>

Keep it concise, paste-ready, and aligned with Kira drafting conventions.
```
