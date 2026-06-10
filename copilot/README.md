# Copilot Workflow

This directory defines the GitHub Copilot customization surface for Kira.

## Modes in Kira

`Kira` runs in two modes:

- Ask mode: direct concise answers for questions. No artifact wrappers unless requested.
- Task mode: compact reframing, then execution, helper delegation, or escalation.

## Handoffs

Visible handoffs from `Kira`:

- `Review with Architect`: architecture, API, schema, security, and ADR-level tradeoffs.
- `Code`: low-cost coding handoff using `GPT-5.4 mini (copilot)`.

Low-cost coding remains in `Kira` by default.

## Flow Examples

### Asking question flow

Ask a question -> `Kira` answers concisely in ask mode.

### Simple implementation flow

Request task -> `Kira` reframes in task mode -> `Kira` implements -> optional inline draft output via `Kira :: Draft`.

### Medium implementation flow

Request task -> `Kira` reframes -> handoff to `Kira :: Architect` when design review is needed -> handoff to `Code` when implementation is straightforward -> handoff back to `Kira` -> optional inline draft output via `Kira :: Draft`.

### Complex implementation flow

Request complex task -> `Kira` reframes -> handoff to `Kira :: Architect` when decision review is needed -> handoff to `Code` for implementation -> handoff back to `Kira` -> optional inline draft output via `Kira :: Draft`.

## Responsibilities

- Agents: operating behavior, routing, and output contracts.
- Skills: reusable capabilities.
- Prompts: thin intent entrypoints with minimal input framing.

## Skill Surface

- `kira-customization-surface`: updates the copilot customization surface with docs and validation alignment.
- `kira-ticket-intake`: external ticket normalization.
- `kira-draft-adr`: ADR drafting.
- `kira-draft-analysis`: analysis drafting or full analysis refresh.
- `kira-draft-commit`: commit message drafting.
- `kira-draft-pr`: PR description drafting.
- `kira-draft-ticket`: ticket drafting.
- `kira-draft-code-snippet`: chat code snippet drafting.

## Architect Update Rule

When explicitly asked to update or refresh analysis, `Kira :: Architect` must return a new full analysis block, not a partial delta, unless the user explicitly asks for a diff-style update.

## Validation

Run:

```bash
npm run validate
```
