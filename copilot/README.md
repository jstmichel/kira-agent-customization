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

The prompt layer is intentionally smaller than before.

| Prompt | Purpose | Backing workflow |
| --- | --- | --- |
| `plan` | Turn a ticket or change request into a reviewable implementation plan before coding | `kira-ticket-intake` when the input is ticket-like, then `kira-architecture` in planning mode |
| `implement` | Implement a bug fix, feature, refactor, or test locally and validate the touched scope | Kira operating rules plus any matching shared skill |
| `review` | Review a PR, branch, or diff and return findings first | `kira-review` |
| `architecture` | Produce an ADR-style recommendation or pressure-test a design before coding | `kira-architecture` with mode detection |
| `draft commit` | Draft a staged, squash, or merge commit message without creating the commit | `kira-draft-commit-message` |

## Shared Skills

The features are preserved in the skill layer even though the prompt surface is smaller.

### Core Shared Skills

- `kira-architecture`
- `kira-review`
- `kira-ticket-intake`
- `kira-draft-commit-message`
- `kira-git-commit`

## Optional .NET Pack

The .NET-specific pieces now live outside the default shipped core and are only installed when `KIRA_INCLUDE_DOTNET=1` is set.

### Optional Skills

- `kira-coverage-analysis`
- `kira-ef-migration-workflow`

### Optional Instructions

- `kira-csharp-conventions.instructions.md`

This keeps the default pack language-agnostic while preserving the .NET-specific workflows for users who want them.

## Instructions

The instructions layer stays small and scoped.

- `kira-conventional-commit.instructions.md` provides the commit-message format contract.

## What Changed

The redesign keeps the features but changes the operating shape.

| Previous surface | Current surface |
| --- | --- |
| two custom lanes (`Kira` + `Build`) | one tool-enabled `Kira` agent |
| no dedicated Kira reset entrypoint | `Reset Kira` handoff on the `Kira` agent |
| `plan ticket` and `plan change` | `plan` on `Kira` |
| direct execution through `Build` | `implement` or direct `Kira` |
| `review pr` and `review branch` | `review` |
| `draft commit` and `draft squash commit` | `draft commit` with mode detection |
| `write adr` and `design review` | `architecture` |
| default shipped .NET skills and C# instruction | optional .NET add-on pack |

## Design Rules

- Keep the visible surface small.
- Keep one custom agent unless a real tool or safety boundary appears.
- Use prompt files when the task is already known.
- Preserve specialized behavior in skills instead of multiplying prompts.
- Keep `Kira` as the fallback lane and let prompts narrow the job.
- Add new prompts only when they represent a genuinely distinct user entry point.
