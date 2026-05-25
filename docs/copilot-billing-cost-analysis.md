# GitHub Copilot Billing and Cost Analysis for Personal Use

- Date: 2026-05-25
- Status: Point-in-time reference
- Purpose: Supporting cost and billing reference for personal Copilot Pro and Pro+ usage while keeping this repository's VS Code workflows aligned with the June 1, 2026 billing transition.

## Scope

This file is intentionally scoped to individual use.

It covers Copilot Pro and Copilot Pro+ monthly planning, plus the annual-plan transition edge case that can still affect individual subscribers after June 1, 2026.

It does not attempt to analyze Free, Student, Business, Enterprise, or Copilot Max economics in detail.

## Why This Lives Outside The Core Workflow Docs

Workflow guidance should stay relatively stable.

Pricing, included usage, model rates, and billing mechanics are volatile. They need a separate reference so workflow documents can describe decision rules without hard-coding numbers that change underneath them.

## June 1, 2026 Transition Snapshot

- Starting June 1, 2026, GitHub Copilot moves from premium-request billing to usage-based billing.
- Usage is billed in GitHub AI Credits.
- 1 GitHub AI Credit = $0.01 USD.
- AI credit consumption is based on token usage: input tokens, output tokens, cached tokens, and, for some model families, cache writes.
- Copilot Chat, local and remote agentic sessions, Copilot CLI, Copilot cloud agent, Copilot Spaces, Spark, and third-party coding agents consume AI credits.
- Code completions and next edit suggestions do not consume AI credits and remain included for paid plans.
- The old fallback behavior after premium requests are exhausted goes away under usage-based billing. Usage is instead governed by included credits and any extra budget you configure.

## Personal Plan Economics

The official late-May 2026 individual-plan figures are:

| Plan | Base price | Base monthly AI credits | Flex allotment | Total included monthly AI credits | Billing behavior |
| --- | --- | --- | --- | --- | --- |
| Copilot Pro | $10 per month | 1,000 | 500 | 1,500 | Monthly plans migrate automatically to usage-based billing on June 1, 2026. |
| Copilot Pro+ | $39 per month | 3,900 | 3,100 | 7,000 | Monthly plans migrate automatically to usage-based billing on June 1, 2026. |

Important planning notes:

- Base credits are the stable part of the plan allowance.
- Flex allotments are explicitly described by GitHub as variable and designed to move with model pricing and platform economics.
- If you exhaust included AI credits, you can either wait for the next monthly reset or set a budget for additional paid usage.
- A $10 additional-usage budget covers 1,000 AI credits.
- If you subscribe, or have subscribed, through GitHub Mobile on iOS or Android, the option to purchase additional AI credits is not available.

## Monthly Vs Annual Personal Plans

Monthly and annual subscribers still need different decision rules.

- Monthly Copilot Pro and Pro+ plans automatically migrate to usage-based billing on June 1, 2026.
- Existing annual Copilot Pro and Pro+ plans do not auto-renew into the new model.
- Annual subscribers can cancel for a prorated refund, switch to a monthly paid plan, or remain on the old premium-request model until the annual term expires.
- If an annual subscriber stays on request-based billing after June 1, model multipliers change materially for several premium models.

That means personal-use documentation still has to account for two systems during the transition window:

- monthly subscribers on AI credits
- annual holdouts on premium-request multipliers until the annual plan ends

## What Actually Burns Credits

For personal workflow design, the practical rule is simple: editor suggestions are cheap because they are unmetered, while chat and agent loops are metered.

These features consume AI credits:

- Copilot Chat
- local agent sessions
- third-party coding agents
- Copilot CLI
- Copilot cloud agent
- Copilot Spaces
- Spark

These do not consume AI credits on paid plans:

- code completions
- next edit suggestions

## What Drives Cost

GitHub's current usage-based billing docs emphasize three levers:

- conversation length and task complexity
- model choice
- agentic features that expand one request into multiple model calls

In practice, a short local chat on a lightweight model can cost a fraction of a credit, while a long multi-file agent session on a frontier model can cost materially more.

## Monitoring And Spending Controls For Personal Use

The current GitHub docs expose several practical controls for individual users:

- In VS Code, you can view current Copilot usage from the status bar Copilot entry.
- On GitHub.com, you can review current usage from the billing overview page.
- GitHub's billing preview flow lets you compare current request-based consumption against projected AI-credit usage.
- You can request a CSV usage report from the preview flow or premium request analytics page.
- The usage report includes `aic_quantity` and `aic_gross_amount`, which are the key fields for estimating spend under the new model.
- You can set a personal budget for additional usage and receive alerts at 75%, 90%, and 100%.

## Practical Cost Rules For Personal Workflow Design

### 1. Prefer unbilled editor surfaces first

If the task is a known local edit, start with completions or next edit suggestions before opening a longer chat or agent session.

### 2. Keep always-on context small

Always-on instructions are injected repeatedly. Under usage-based billing, repeated prompt mass now has a direct token cost.

### 3. Default routine work to low-cost models

Routine exploration, short edits, test scaffolding, and straightforward debugging should default to lighter models whenever output quality remains acceptable.

### 4. Reserve expensive models for ambiguity or leverage

Frontier models only pay for themselves when they reduce retries, unblock hard reasoning, or materially improve quality on risky work.

### 5. Watch output-heavy workflows

Verbose plans, long reviews, giant rewrites, and repeated wide diffs can cost materially more than short focused iterations.

### 6. Treat long agent loops as premium work

Local Agent sessions are often the right tool, but they should be used because the task needs autonomous execution, not because it is available.

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

## Companion Documents

- detailed model catalog: [copilot-model-reference-personal.md](copilot-model-reference-personal.md)
- broad workflow comparison: [copilot-workflow-flows-comparison.md](copilot-workflow-flows-comparison.md)
- local VS Code default playbook: [copilot-local-vscode-workflow-guide.md](copilot-local-vscode-workflow-guide.md)

## Sources

- [Usage-based billing for individuals](https://docs.github.com/en/copilot/concepts/billing/usage-based-billing-for-individuals)
- [Models and pricing for GitHub Copilot](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing)
- [Model multipliers for annual plans staying on request-based billing](https://docs.github.com/en/copilot/reference/copilot-billing/model-multipliers-for-annual-plans)
- [Preparing for your move to usage-based billing](https://docs.github.com/en/copilot/how-tos/manage-and-track-spending/prepare-for-your-move-to-usage-based-billing)
- [Monitoring your GitHub Copilot usage and entitlements](https://docs.github.com/en/copilot/how-tos/manage-and-track-spending/monitor-premium-requests)
- [Plans for GitHub Copilot](https://docs.github.com/en/copilot/get-started/plans)
- [GitHub Copilot is moving to usage-based billing](https://github.blog/news-insights/company-news/github-copilot-is-moving-to-usage-based-billing/)