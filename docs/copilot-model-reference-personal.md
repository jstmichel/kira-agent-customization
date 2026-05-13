# GitHub Copilot Model Reference for Personal Use

- Date: 2026-05-12
- Status: Point-in-time reference
- Scope: Copilot Pro and Copilot Pro+ personal usage, plus the annual-plan transition models that matter to individual subscribers

Confirmed `Closing down` and `Retired` models are intentionally excluded from this catalog.

## How To Read This File

- `Usage-based price` is the June 1, 2026 AI-credit pricing from GitHub's official pricing reference.
- `Annual PRU change` only matters if you stay on an existing annual Copilot Pro or Pro+ plan under the old request-based model.
- `Status` comes from GitHub's supported-models reference.
- `Good at` and `Typical personal use cases` are based on GitHub's AI model comparison and task-comparison guidance when GitHub provides it. If GitHub does not provide current task guidance for a legacy or extension-only model, this file says so or limits the note to documented availability instead of guessing.

## Current Monthly Models For Personal Plans

These are the models that matter for current monthly Pro and Pro+ planning.

| Model | Pro | Pro+ | Status | Good at | Typical personal use cases | Usage-based price per 1M tokens | Annual PRU change |
| --- | --- | --- | --- | --- | --- | --- | --- |
| GPT-5 mini | Yes | Yes | GA | Low-cost general coding and writing | Utility scripts, quick edits, lightweight debugging, prototyping, default everyday work | input $0.25, cached $0.025, output $2.00 | 0 -> 0.33 |
| GPT-5.3-Codex | Yes | Yes | GA | High-quality agentic software development | Features, tests, debugging, refactors, reviews without a lot of prompt micromanagement | input $1.75, cached $0.175, output $14.00 | 1 -> 6 |
| GPT-5.4 | Yes | Yes | GA | Deep reasoning and debugging | Multi-step problem solving, architecture-level analysis, risky refactors, harder design decisions | input $2.50, cached $0.25, output $15.00 | 1 -> 6 |
| GPT-5.4 mini | Yes | Yes | GA | Agentic codebase exploration | Grep-heavy repo exploration, medium-cost agent runs, guided implementation work | input $0.75, cached $0.075, output $4.50 | 0.33 -> 6 |
| Claude Haiku 4.5 | Yes | Yes | GA | Fast everyday coding help | Boilerplate, test generation, validation logic, docs, lightweight code explanations | input $1.00, cached $0.10, cache write $1.25, output $5.00 | 0.33 -> 0.33 |
| Claude Sonnet 4.5 | Yes | Yes | GA | Broad multi-file general-purpose coding | Legacy modernization, cross-language work, multi-file refactors, architectural planning | input $3.00, cached $0.30, cache write $3.75, output $15.00 | 1 -> 6 |
| Claude Sonnet 4.6 | Yes | Yes | GA | General-purpose coding and agent tasks with stronger reasoning | Harder multi-file work, agent tasks, visually informed reasoning, more reliable completions under pressure | input $3.00, cached $0.30, cache write $3.75, output $15.00 | 1 -> 9 |
| Gemini 2.5 Pro | Yes | Yes | GA | Deep reasoning and research workflows | Complex code generation, debugging, technical research, long-form analysis | input $1.25, cached $0.125, output $10.00 | 1 -> 1 |
| Gemini 3 Flash | Yes | Yes | Public preview | Fast help with simple or repetitive tasks | Quick syntax help, lightweight prompts, simple coding questions, repetitive edits | input $0.50, cached $0.05, output $3.00 | 0.33 -> 0.33 |
| Gemini 3.1 Pro | Yes | Yes | Public preview | Deep reasoning with high tool precision | Edit-then-test loops, long-context debugging, technical analysis, research-heavy coding workflows | input $2.00, cached $0.20, output $12.00 | 1 -> 6 |
| Grok Code Fast 1 | Yes | Yes | GA | Fast coding-focused generalist work | Quick code generation, debugging across languages, low-cost everyday development | input $0.20, cached $0.02, output $1.50 | 0.25 -> 0.33 |
| Raptor mini | Yes | Yes | Public preview | Fast inline suggestions and explanations | Quick completions, short explanations, lightweight code drafting | input $0.25, cached $0.025, output $2.00 | 0 -> 0.33 |
| Claude Opus 4.7 | No | Yes | GA | Frontier deep reasoning and debugging | Hardest problem-solving, sophisticated reasoning, highest-complexity analysis | input $5.00, cached $0.50, cache write $6.25, output $25.00 | 15 -> 27 |
| GPT-5.4 nano | No | Yes | GA | No current GitHub task guidance surfaced; documented as Pro+ Codex VS Code extension only | Only relevant if you are using the Codex VS Code extension and want the cheapest GPT-5.4-family option GitHub exposes | input $0.20, cached $0.02, output $1.25 | n/a |
| GPT-5.5 | No | Yes | GA | Highest-depth reasoning | Very hard debugging, technical decision-making, deep architectural tradeoff analysis | input $5.00, cached $0.50, output $30.00 | 7.5 -> TBD |

## Transition-Only Personal Models

These models matter because they still appear in GitHub's annual-plan before/after multiplier page, but they are not the main anchors for new monthly personal workflow planning.

| Model | Current personal status | Annual PRU change | Good at | Recommended replacement or note |
| --- | --- | --- | --- | --- |
| Claude Opus 4.5 | Not in current monthly Pro or Pro+ plan table | 3 -> 15 | Closest current family guidance: frontier deep reasoning and complex problem solving | For current personal monthly planning, use Claude Opus 4.7 if you are on Pro+ |
| Claude Opus 4.6 | Not in current monthly Pro or Pro+ plan table | 3 -> 27 | Closest current family guidance: frontier deep reasoning and complex problem solving | For current personal monthly planning, use Claude Opus 4.7 if you are on Pro+ |
| GPT-4o | Not surfaced in the current supported-model inventory used for monthly planning | 0 -> 0.33 | No current GitHub personal-use task guidance surfaced in the fetched comparison docs | Prefer GPT-5 mini for current general-purpose work |
| GPT-4o mini | Not surfaced in the current supported-model inventory used for monthly planning | 0 -> 0.33 | No current GitHub personal-use task guidance surfaced in the fetched comparison docs | Prefer GPT-5 mini or Raptor mini for low-cost work |

## Practical Personal Selection Rules

Use the table above as a working default set:

- Start with GPT-5 mini, Grok Code Fast 1, Claude Haiku 4.5, or Gemini 3 Flash when the task is routine and speed matters.
- Move to GPT-5.3-Codex or GPT-5.4 mini when the task becomes agentic or tool-heavy.
- Move to GPT-5.4, Claude Sonnet 4.6, Gemini 3.1 Pro, or Claude Opus 4.7 when you genuinely need deeper reasoning.
- Treat GPT-5.5 and Claude Opus 4.7 as premium reasoning tools, not defaults.
- Use this file as a forward-looking catalog; confirmed closing-down and retired models have already been removed.

## Source Basis

This file is assembled from the following official GitHub materials:

- plan availability: [Supported AI models in GitHub Copilot](https://docs.github.com/en/copilot/reference/ai-models/supported-models) and [Plans for GitHub Copilot](https://docs.github.com/en/copilot/about-github-copilot/subscription-plans-for-github-copilot)
- usage-based pricing: [Models and pricing for GitHub Copilot](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing)
- annual before/after multiplier changes: [Model multipliers for annual plans staying on request-based billing](https://docs.github.com/en/copilot/reference/copilot-billing/model-multipliers-for-annual-plans)
- task fit and recommended use cases: [AI model comparison](https://docs.github.com/en/copilot/reference/ai-models/model-comparison) and [Comparing AI models using different tasks](https://docs.github.com/en/copilot/using-github-copilot/ai-models/comparing-ai-models-using-different-tasks)
- retirement and replacement guidance for legacy models: [Supported AI models in GitHub Copilot](https://docs.github.com/en/copilot/reference/ai-models/supported-models#model-retirement-history)