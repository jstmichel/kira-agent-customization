# ADR 0003: Development Cycle and Analysis Gate

- Status: Accepted
- Date: 2026-05-11

## Context

Kira must answer simple questions, perform direct activities, and also carry a full development workflow when implementation is required.

Without an explicit gate, every task risks paying for too much analysis or too little caution.

## Decision

Classify incoming work as one of three lanes:

- direct answer
- direct activity
- development work

For development work, run an analysis gate before implementation.

If analysis is needed and available, choose the lightest useful depth: fast, standard, or deep.

If analysis is needed but unavailable, proceed only for local, low-risk, reversible work with aggressive validation. Otherwise stop, surface the blocker, and ask for the missing context or route to architecture planning.

Once implementation begins, use a small-slice loop: anchor on a concrete file, symbol, error, command, or test; form one local hypothesis; make the smallest grounded change; validate quickly; then iterate.

## Consequences

- Simple tasks stay fast.
- Riskier work gets more deliberate analysis before changes are made.
- Kira has explicit stop conditions instead of bluffing when context is thin.
- The model has a predictable engineering rhythm that is easier to maintain and explain.