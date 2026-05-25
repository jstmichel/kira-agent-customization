# GitHub Copilot Model Reference for Personal Use

- Date: 2026-05-25
- Status: Point-in-time reference
- Scope: Copilot Pro and Copilot Pro+ personal usage in VS Code, plus the annual-plan transition notes that still matter for individual subscribers

This file focuses on the included-by-default models that matter for late-May 2026 monthly planning. It intentionally excludes retired models from the main catalog and does not attempt to mirror every transient row from GitHub's broader supported-model inventories or evaluation-model listings.

## How To Read This File

- `Pro` and `Pro+` use the current GitHub plan-comparison tables for included-by-default access.
- VS Code can expose additional models beyond what is included by default with a subscription, but that is not the baseline this file optimizes for.
- `Usage-based price` is the June 1, 2026 AI-credit pricing from GitHub's official pricing reference.
- `Annual PRU change` only matters if you stay on an existing annual Copilot Pro or Pro+ plan under the old request-based model.
- `Best fit` is grounded in GitHub's current model-comparison and task-comparison guidance.

## Default Monthly Planning Anchors

These are the current models that matter most for personal monthly Pro and Pro+ planning.

| Model | Pro | Pro+ | Status | Best fit | Usage-based price per 1M tokens | Annual PRU change | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| GPT-5 mini | Yes | Yes | GA | Low-cost general coding and writing | input $0.25, cached $0.025, output $2.00 | 0 -> 0.33 | Best low-cost default for everyday code and prose. |
| GPT-5.3-Codex | Yes | Yes | GA | Agentic software development | input $1.75, cached $0.175, output $14.00 | 1 -> 6 | Best current Codex-family default for local agentic work. |
| GPT-5.4 | Yes | Yes | GA | Deep reasoning and debugging | input $2.50, cached $0.25, output $15.00 | 1 -> 6 | Strong general reasoning default for harder bugs and design questions. |
| GPT-5.4 mini | Yes | Yes | GA | Agentic repo exploration and tool-heavy work | input $0.75, cached $0.075, output $4.50 | 0.33 -> 6 | Good mid-cost local-agent choice. |
| Claude Haiku 4.5 | Yes | Yes | GA | Fast simple or repetitive tasks | input $1.00, cached $0.10, cache write $1.25, output $5.00 | 0.33 -> 0.33 | Cheap Anthropic option for small tasks and test scaffolding. |
| Claude Sonnet 4.5 | Yes | Yes | GA | General-purpose coding and multi-file work | input $3.00, cached $0.30, cache write $3.75, output $15.00 | 1 -> 6 | Still included, but usually superseded by Sonnet 4.6. |
| Claude Sonnet 4.6 | Yes | Yes | GA | General-purpose coding and agent tasks with stronger reasoning | input $3.00, cached $0.30, cache write $3.75, output $15.00 | 1 -> 9 | Current Sonnet-family default for harder coding work. |
| Gemini 2.5 Pro | Yes | Yes | GA | Deep reasoning and research workflows | input $1.25, cached $0.125, output $10.00 | 1 -> 1 | Strong value reasoning model for research-heavy work. |
| Gemini 3 Flash | Yes | Yes | Public preview | Fast help with simple or repetitive tasks | input $0.50, cached $0.05, output $3.00 | 0.33 -> 0.33 | Fast preview option for lightweight coding help. |
| Gemini 3.1 Pro | Yes | Yes | Public preview | Deep reasoning with high tool precision | input $2.00, cached $0.20, output $12.00 | 1 -> 6 | Strong for edit-then-test loops and long-context debugging. |
| Gemini 3.5 Flash | Yes | Yes | GA | Fast help with simple or repetitive tasks | input $1.50, cached $0.15, output $9.00 | 14 -> 14 | Included, but relatively expensive on annual request-based plans. |
| Raptor mini | Yes | Yes | Public preview | Fast inline suggestions and explanations | input $0.25, cached $0.025, output $2.00 | 0 -> 0.33 | Fine-tuned GPT-5 mini family model for fast local help. |
| Claude Opus 4.7 | No | Yes | GA | Frontier deep reasoning and debugging | input $5.00, cached $0.50, cache write $6.25, output $25.00 | 15 -> 27 | Pro+ only. Use when the harder reasoning genuinely pays for itself. |
| GPT-5.4 nano | No | Yes | GA | Cheapest GPT-5.4-family option | input $0.20, cached $0.02, output $1.25 | n/a | Pro+ only, Codex VS Code extension only, not Copilot Chat. |
| GPT-5.5 | No | Yes | GA | Highest-depth reasoning | input $5.00, cached $0.50, output $30.00 | 7.5 -> TBD | Pro+ only. Reserve for the hardest reasoning work. |

## Closing-Down And Recently Retired Models

These models still appear in the live GitHub docs, but they are no longer good defaults for new personal workflow guidance.

| Model | Current state | Recommended replacement |
| --- | --- | --- |
| GPT-4.1 | Closing down 2026-06-01 | Prefer GPT-5 mini for general work or GPT-5.4 for harder reasoning. |
| GPT-5.2 | Closing down 2026-06-01 | Prefer GPT-5.4 or GPT-5.5 for deeper reasoning. |
| GPT-5.2-Codex | Closing down 2026-06-01 | Prefer GPT-5.3-Codex for agentic software development. |
| Grok Code Fast 1 | Retired 2026-05-15 | Prefer GPT-5 mini. |

## Practical Personal Selection Rules

Use the table above as a working default set:

- Start with GPT-5 mini, Claude Haiku 4.5, Gemini 3 Flash, or Raptor mini when the task is routine and speed matters.
- Move to GPT-5.4 mini or GPT-5.3-Codex when the task becomes tool-heavy, multi-file, or agentic.
- Move to GPT-5.4, Claude Sonnet 4.6, or Gemini 3.1 Pro when you genuinely need deeper reasoning or broader codebase context.
- Treat GPT-5.5 and Claude Opus 4.7 as premium reasoning tools, not defaults.
- Stop writing workflow guidance that assumes GPT-4.1, GPT-5.2, GPT-5.2-Codex, or Grok Code Fast 1 are the stable baseline.

## VS Code Version Notes

- GitHub recommends VS Code 1.120 for accurate usage-based billing UI and terminology.
- GPT-5.3-Codex, GPT-5.4, and GPT-5.4 mini require VS Code 1.104.1 or newer, and GitHub explicitly notes that VS Code 1.108 and later improves GPT-5.3-Codex prompting quality.
- Gemini 3 Flash, Gemini 3.1 Pro, and Gemini 3.5 Flash require VS Code 1.115 or newer.
- GPT-5.5 requires VS Code 1.117 or newer.

## Source Basis

This file is assembled from the following official GitHub materials:

- plan availability: [Plans for GitHub Copilot](https://docs.github.com/en/copilot/get-started/plans) and [Supported AI models in GitHub Copilot](https://docs.github.com/en/copilot/reference/ai-models/supported-models)
- usage-based pricing: [Models and pricing for GitHub Copilot](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing)
- annual before/after multiplier changes: [Model multipliers for annual plans staying on request-based billing](https://docs.github.com/en/copilot/reference/copilot-billing/model-multipliers-for-annual-plans)
- task fit and recommended use cases: [AI model comparison](https://docs.github.com/en/copilot/reference/ai-models/model-comparison) and [Comparing AI models using different tasks](https://docs.github.com/en/copilot/tutorials/compare-ai-models)
- retirement and replacement guidance for legacy models: [Supported AI models in GitHub Copilot](https://docs.github.com/en/copilot/reference/ai-models/supported-models#model-retirement-history)