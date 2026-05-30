---
description: "Cost and token discipline for Kira agents under usage-based billing."
---

# Kira Cost Routing Rules

- Prefer the lightest model that can handle the task.
- Keep the coordinator cheap and read-only.
- Reserve higher-cost reasoning for visible specialist agents that users invoke intentionally.
- Keep instructions and responses lean to avoid repeated token overhead.
- Use hidden subagents only for narrow, cheap helper work.
