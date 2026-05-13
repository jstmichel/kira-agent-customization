# Kira Request Routing Cheat Sheet

- Date: 2026-05-12
- Status: Working note
- Scope: Example user requests mapped to Kira, Kira :: Plan, Kira :: Code, and the current shared skill library

## Quick Routing Table

| Example request | Prompt command | Start agent | Default lane | Expected flow | Skills implicated |
| --- | --- | --- | --- | --- | --- |
| `What should we do for auth across these services?` | none | Kira | Stay in `Kira` | `Kira -> kira-architecture` | `kira-architecture` |
| `Write an ADR for this deployment decision.` | `/adr` | Kira | Stay in `Kira` | `Kira -> kira-architecture` | `kira-architecture` |
| `Pressure-test this design before we build it.` | `/design-review` | Kira | Stay in `Kira` | `Kira -> kira-architecture` | `kira-architecture` |
| `Plan this refactor before coding.` | `/plan-change` | Kira | Hand off to `Kira :: Plan` | `Kira -> Plan This -> Kira :: Plan -> kira-architecture -> Start Build if approved` | `kira-architecture` |
| `Implement issue #123, but I want the route first.` | `/plan-ticket` | Kira | Hand off to `Kira :: Plan` | `Kira -> Plan This -> Kira :: Plan -> kira-ticket-intake -> optionally kira-architecture -> Start Build if approved` | `kira-ticket-intake`, `kira-architecture` optional |
| `Fix this local bug in PaymentService.` | none | Kira | Hand off to `Kira :: Code` | `Kira -> Build This -> Kira :: Code` | none |
| `Implement this approved plan.` | none | Kira or Kira :: Plan | Hand off to `Kira :: Code` | `Kira -> Build This -> Kira :: Code` or `Kira :: Plan -> Start Build -> Kira :: Code` | none |
| `Review this branch for regressions.` | `/review-branch` | Kira :: Code | Execute in `Kira :: Code` | `Kira :: Code -> kira-review` | `kira-review` |
| `Review this PR and find missing tests.` | `/review-pr` | Kira :: Code | Execute in `Kira :: Code` | `Kira :: Code -> kira-review` | `kira-review` |
| `Write a commit message for the staged changes.` | `/draft-commit` | Kira :: Code | Execute in `Kira :: Code` | `Kira :: Code -> kira-draft-commit-message` | `kira-draft-commit-message` |
| `Draft a squash commit message for this branch.` | `/draft-squash` | Kira :: Code | Execute in `Kira :: Code` | `Kira :: Code -> kira-draft-commit-message` | `kira-draft-commit-message` |
| `Commit the staged changes.` | none | Kira | Stay in `Kira` | `Kira -> kira-git-commit` | `kira-git-commit` |
| `I changed entities and need an EF migration.` | none | Kira | Hand off to `Kira :: Code` | `Kira -> Build This -> Kira :: Code -> kira-ef-migration-workflow` | `kira-ef-migration-workflow` |
| `Generate and review the EF migration, but do not update the database.` | none | Kira | Hand off to `Kira :: Code` | `Kira -> Build This -> Kira :: Code -> kira-ef-migration-workflow` | `kira-ef-migration-workflow` |
| `Run coverage and fill easy test gaps.` | none | Kira | Hand off to `Kira :: Code` | `Kira -> Build This -> Kira :: Code -> kira-coverage-analysis` | `kira-coverage-analysis` |
| `Show me what code is still untested.` | none | Kira | Hand off to `Kira :: Code` | `Kira -> Build This -> Kira :: Code -> kira-coverage-analysis` | `kira-coverage-analysis` |

`Stay in Kira` means the request should be handled in the lead lane, usually by direct skill routing rather than a Plan or Code handoff.

## Current Routing Rules Behind The Table

| Situation | Preferred path |
| --- | --- |
| Direct decision, ADR, or design critique | `Kira -> kira-architecture` |
| Planning-first work with human review before coding | `Kira -> Plan This -> Kira :: Plan`, then hand off to `Kira :: Code` only after approval |
| Straight implementation with no special workflow | `Kira -> Build This -> Kira :: Code` |
| Specialized execution workflow with an existing skill | `Kira -> Build This -> Kira :: Code -> matching skill` |
| Review, commit-message drafting, or commit execution | `Kira -> Build This -> Kira :: Code -> matching skill` |

## Prompt Model Defaults

| Prompt command | Suggested model | Why |
| --- | --- | --- |
| `/kira` | `GPT-5 mini` | Utility reset prompt to get back to normal Kira lead mode and restore the normal Kira default model. |
| `/kira-deep` | `GPT-5.4` | Optional deeper utility lane for ambiguity-heavy requests where `/kira` depth is not enough. |
| `/adr` | `GPT-5.4` | Architectural recommendation quality matters more than raw speed. |
| `/design-review` | `GPT-5.4` | Design critique benefits from stronger reasoning and comparison. |
| `/plan-change` | `GPT-5.4` | Planning quality and risk handling matter more than token-minimal speed. |
| `/plan-ticket` | `GPT-5.4` | Ticket intake plus planning is ambiguity-heavy and benefits from stronger reasoning. |
| `/review-branch` | `GPT-5.4 mini` | Mid-cost review lane with stronger reasoning than cheap defaults and lower cost than top-tier models. |
| `/review-pr` | `GPT-5.4 mini` | Same as branch review with provider-aware PR intake and diff retrieval. |
| `/draft-commit` | cheap default | Commit-message drafting is structured and usually does not need a stronger model. |
| `/draft-squash` | cheap default | Same as staged commit drafting: keep it cheap unless quality is clearly lacking. |

`/kira` is a reset utility prompt. It is meant to switch you back to normal `Kira` behavior for the current request and reset the model to `GPT-5 mini`, not to enforce a special workflow.

`/kira-deep` is an opt-in reset utility prompt for deeper reasoning while keeping the same Kira lead-mode routing behavior.

## Next Maintenance Checks

- Revisit lane placement only if real usage shows excessive handoff friction.
- Reassess review model cost and quality after enough PR-review samples accumulate.
- Add stronger trigger phrases to skills only when a repeated routing miss is observed.