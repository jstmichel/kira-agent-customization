# Copilot Runtime Surface

This folder is the shipped customization pack.

The goal is to keep the feature set broad while keeping the user-facing surface small and predictable.

## Runtime Model

The pack now operates as a simple local one-agent model:

1. `Kira` agent for persona, fallback routing, local execution, planning, review, and route advice.
2. Prompt files for explicit workflows when the job is already known.
3. Shared skills for deeper reusable procedures behind those prompts.

That keeps the visible surface small while avoiding dependence on the built-in Ask, Agent, or Plan entry points.

`Kira` also exposes a `Reset Kira` handoff that switches the chat back to the Kira agent with Kira's default model after a prompt changed routing or model selection.

## Prompt Surface

The prompt layer is intentionally smaller than before and acts as a thin launcher into the matching workflow skill.

| Prompt | Purpose | Backing workflow |
| --- | --- | --- |
| `plan-with-kira` | Turn a ticket or change request into a reviewable implementation plan before coding | `kira-ticket-intake` plus `kira-architecture` |
| `implement-with-kira` | Implement a bug fix, feature, refactor, or test locally and validate the touched scope | `kira-implementation-workflow` |
| `review-with-kira` | Review a PR, branch, or diff and return findings first | `kira-review` |
| `design-with-kira` | Produce an ADR-style recommendation or pressure-test a design before coding | `kira-architecture` |
| `draft-commit-with-kira` | Draft a staged, squash, or merge commit message without creating the commit | `kira-draft-commit-message` |

## Shared Skills

The features are preserved in the skill layer even though the prompt surface is smaller.

### Core Shared Skills

- `kira-architecture`
- `kira-coverage-analysis`
- `kira-draft-commit-message`
- `kira-ef-migration-workflow`
- `kira-git-commit`
- `kira-implementation-workflow`
- `kira-review`
- `kira-ticket-intake`

## Instructions

The instructions layer stays small and scoped.

- `kira-csharp-conventions.instructions.md` provides C# conventions when C# files are being edited.

## What Changed

The redesign keeps the features but changes the operating shape.

| Previous surface | Current surface |
| --- | --- |
| two custom lanes (`Kira` + `Build`) | one tool-enabled `Kira` agent |
| no dedicated Kira reset entrypoint | `Reset Kira` handoff on the `Kira` agent |
| `plan ticket` and `plan change` | `plan-with-kira` launcher into `kira-ticket-intake` + `kira-architecture` |
| direct execution through `Build` | `implement-with-kira` launcher into `kira-implementation-workflow` |
| `review pr` and `review branch` | `review-with-kira` launcher into `kira-review` |
| `draft commit` and `draft squash commit` | `draft-commit-with-kira` launcher into `kira-draft-commit-message` |
| `write adr` and `design review` | `design-with-kira` launcher into `kira-architecture` |
| .NET coverage, EF migration, and C# conventions | always installed in the core pack |

## Design Rules

- Keep the visible surface small.
- Keep one custom agent unless a real tool or safety boundary appears.
- Use prompt files when the task is already known.
- Preserve specialized behavior in skills instead of multiplying prompts.
- Keep `Kira` as the fallback lane and let prompts narrow the job.
- Add new prompts only when they represent a genuinely distinct user entry point.
