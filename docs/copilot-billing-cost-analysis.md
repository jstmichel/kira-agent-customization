# GitHub Copilot Billing and Cost Analysis for Personal Use

- Date: 2026-05-12
- Status: Point-in-time reference
- Purpose: Supporting cost and billing reference for personal Copilot Pro and Pro+ usage while preparing the June 1 workflow changes behind [ADR 0006](adr/0006-incremental-ai-customization-workflow.md)

## Scope

This file is intentionally scoped to individual usage only.

It covers Copilot Pro and Copilot Pro+ personal plans, plus the annual-plan transition edge case that can still affect individual subscribers after June 1, 2026.

It intentionally does not analyze Free, Student, Business, or Enterprise economics.

## Why This Lives Outside The ADR

The ADR should capture the stable workflow decision.

Pricing, plan allowances, model rates, and billing mechanics are volatile. They need their own repo document so the workflow decision can stay stable while the cost reference changes over time.

## June 1, 2026 Transition Snapshot

- Starting June 1, 2026, GitHub Copilot moves from premium request billing to usage-based billing.
- Usage is billed in GitHub AI Credits.
- 1 GitHub AI Credit = $0.01 USD.
- AI credit consumption is based on token usage: input tokens, output tokens, and cached tokens. Some model families also bill cache writes separately.
- Copilot Chat, Copilot CLI, Copilot cloud agent, Copilot Spaces, Spark, and third-party coding agents consume AI credits.
- Code completions and next edit suggestions do not consume AI credits and remain unlimited for paid plans.
- The old fallback behavior after you exhaust premium requests goes away under the usage-based model. Usage is instead governed by remaining credits and any budget you set.

## Personal Plan Economics

The official June 2026 individual-plan figures surfaced in the fetched GitHub docs are:

| Plan | Base price | Included monthly AI credits | Billing behavior |
| --- | --- | --- | --- |
| Copilot Pro | $10 per month | 1,000 | Monthly plans move automatically to usage-based billing on June 1, 2026. |
| Copilot Pro+ | $39 per month | 3,900 | Monthly plans move automatically to usage-based billing on June 1, 2026. |

Additional individual-use notes:

- If you exhaust your included AI credits, you can either wait for the next monthly reset or set a budget for additional paid usage.
- A $10 additional-usage budget covers 1,000 AI credits.
- If you subscribe, or have subscribed, through GitHub Mobile on iOS or Android, the option to purchase additional AI credits is not available.

## Monthly Vs Annual Personal Plans

Monthly and annual subscribers need to plan differently.

- If you are on a monthly Copilot Pro or Pro+ plan, you are automatically migrated to usage-based billing on June 1, 2026.
- If you are on an existing annual Copilot Pro or Pro+ plan, your plan does not auto-renew.
- Annual subscribers can cancel for a prorated refund, switch to a monthly paid plan, or remain on the old premium-request model until the annual plan ends.
- If an annual subscriber stays on the request-based model, model multipliers change on June 1, 2026.

That means personal-use documentation has to account for two billing systems during the transition window:

- monthly subscribers on AI credits
- annual holdouts on premium-request multipliers until expiration

## What Actually Burns Credits

For personal usage planning, the main rule is simple: chat and agentic workflows cost money, inline completion does not.

These features consume AI credits:

- Copilot Chat
- Copilot CLI
- Copilot cloud agent
- Copilot Spaces
- Spark
- third-party coding agents

These do not consume AI credits on paid plans:

- code completions
- next edit suggestions

## Monitoring And Spending Controls For Personal Use

The fetched GitHub sources expose several practical controls for individual users:

- In VS Code, you can view usage from the Copilot status bar entry.
- On GitHub.com, you can review current usage from the billing overview page.
- Starting in early May, GitHub exposes a billing preview that compares your current billing model to the June 1 AI-credit model.
- You can request a CSV usage report from the preview flow or premium request analytics page.
- The usage report includes `aic_quantity` and `aic_gross_amount`, which are the key columns for estimating personal spend under the new model.

## Practical Cost Rules For Personal Workflow Design

The pricing model has direct implications for how you should use customized Copilot workflows personally.

### 1. Keep always-on context small

Always-on instructions are injected repeatedly. Under usage-based billing, repeated prompt mass has a direct token cost.

### 2. Default routine work to low-cost models

Routine codebase exploration, draft generation, small edits, and straightforward debugging should default to lower-cost models whenever output quality remains acceptable.

### 3. Reserve expensive models for ambiguity or leverage

Frontier models only pay for themselves when they reduce retries, unblock hard reasoning, or materially improve quality on complex tasks.

### 4. Watch output-heavy workflows

Large generated plans, verbose rewrites, and repeated long-form review passes can cost materially more than short focused iterations.

### 5. Treat agentic work as premium

Agent mode and Copilot cloud agent can consume meaningfully more credits than a short chat exchange because they expand token use across longer sessions.

## Estimating Cost

Use this formula for rough planning:

```text
estimated_cost_usd =
  (input_tokens * input_rate_per_million
  + cached_input_tokens * cached_input_rate_per_million
  + cache_write_tokens * cache_write_rate_per_million
  + output_tokens * output_rate_per_million) / 1_000_000

estimated_ai_credits = estimated_cost_usd * 100
```

## Companion Model Reference

The detailed model-by-model catalog now lives in [copilot-model-reference-personal.md](copilot-model-reference-personal.md).

That file contains:

- current personal-plan model availability
- usage-based per-token pricing
- annual-plan before/after multiplier changes where GitHub publishes them
- task fit and example use cases for each relevant model

Workflow selection guidance, including the distinction between agentic work and lower-autonomy flows, now lives in [copilot-workflow-flows-comparison.md](copilot-workflow-flows-comparison.md).

## Sources

- [Usage-based billing for individuals](https://docs.github.com/en/copilot/concepts/billing/usage-based-billing-for-individuals)
- [Models and pricing for GitHub Copilot](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing)
- [Model multipliers for annual plans staying on request-based billing](https://docs.github.com/en/copilot/reference/copilot-billing/model-multipliers-for-annual-plans)
- [Supported AI models in GitHub Copilot](https://docs.github.com/en/copilot/reference/ai-models/supported-models)
- [Preparing for your move to usage-based billing](https://docs.github.com/en/copilot/how-tos/manage-and-track-spending/prepare-for-your-move-to-usage-based-billing)
- [Monitoring your GitHub Copilot usage and entitlements](https://docs.github.com/en/copilot/how-tos/manage-and-track-spending/monitor-premium-requests)
- [GitHub Copilot is moving to usage-based billing](https://github.blog/news-insights/company-news/github-copilot-is-moving-to-usage-based-billing/)