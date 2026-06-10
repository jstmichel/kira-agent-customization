---
name: draft-ticket
description: Draft a repository-grounded engineering ticket as markdown. Use when asked to write a ticket, task, or implementation brief.
user-invocable: false
---

# Ticket Drafting

Use this skill when the user wants a ticket or task artifact.

## Workflow

1. Read the minimum repository context needed to ground the ticket.
2. Infer the audience as engineers unless the user specifies otherwise.
3. Return exactly one fenced `md` code block unless the user asks for the ticket to be written to disk.
4. Keep the ticket actionable and concrete.

## Output Shape

- Include a clear title.
- Include context, problem or goal, scope, acceptance criteria, and risks when relevant.
- Add open questions only when they materially affect execution.
- Avoid implementation fiction that is not supported by the repository or user request.

## Example Output

```md
# Add a drafting agent for repository artifacts

## Context

The customization pack currently has architecture and coding agents but no dedicated worker for repository-facing prose artifacts.

## Goal

Add a drafting agent that can generate commit messages, PR descriptions, tickets, ADRs, and related markdown documents without editing source code.

## Acceptance Criteria

- a user-invocable drafting agent exists under `copilot/agents`
- commit, PR, ticket, and document-writing workflows are captured in skills
- the agent is documented in the README
```