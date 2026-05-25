# Copilot Runtime Surface

This folder is the shipped customization pack.

The goal is to keep the feature set broad while keeping the user-facing surface small and predictable.

## Runtime Model

The pack now operates as a simple local three-lane model:

1. `Kira` agent for read-heavy exploration, architecture guidance, and route advice before coding.
2. Built-in `Plan` for reviewable implementation planning.
3. `Build` agent for implementation, validation, deep review, and explicit git-backed execution.

That keeps planning on the built-in planning surface and keeps the custom agents focused on the two roles that are specific to this pack.

## Prompt Surface

The prompt layer is intentionally smaller than before.

| Prompt | Purpose | Backing workflow |
| --- | --- | --- |
| `plan` | Turn a ticket or change request into a reviewable implementation plan before coding | built-in `Plan` plus `kira-ticket-intake` when the input is ticket-like |
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
| `kira` reset prompt | Use the `Kira` agent directly |
| `plan ticket` and `plan change` | `plan` |
| `review pr` and `review branch` | `review` |
| `draft commit` and `draft squash commit` | `draft commit` with mode detection |
| `write adr` and `design review` | `architecture` |
| default shipped .NET skills and C# instruction | optional .NET add-on pack |

## Design Rules

- Keep the visible surface small.
- Preserve specialized behavior in skills instead of multiplying prompts.
- Use built-in `Plan` for planning before adding more custom planning agents.
- Keep planning and exploration read-heavy; keep execution in `Build`.
- Add new prompts only when they represent a genuinely distinct user entry point.
