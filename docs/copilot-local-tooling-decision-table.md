# GitHub Copilot Local Tooling Decision Table

- Date: 2026-05-12
- Status: Working note
- Scope: VS Code-only local development with GitHub Copilot, no cloud agent and no Copilot CLI dispatch

## Current Shortlist

| Tooling Pattern | Fit | Cost Position | Why It Stays In Scope |
| --- | --- | --- | --- |
| Using Ask to copy paste code | 9/9 | Low | Cheapest and simplest local workflow when you want to stay manual. |
| Using custom agent | 8/9 | Low-Medium | Best controlled agentic option if the agent stays narrow and focused. |
| Multiple custom agents with specific roles, selected manually | 7/9 | Medium | Good separation of concerns without automatic orchestration overhead. |
| Using default agent | 6/9 | Medium | Broad and convenient, but less cost-disciplined than a focused custom agent. |
| Orchestration with multiple custom agents, using handoffs in frontmatter | 6/9 | Medium | Best multi-agent structure when you truly need stage separation. |
| Using Plan default | 5/9 | Medium-High | Worth keeping for risky or ambiguous work, even if it is not the cheapest default. |

## Notes

- `handoffs in frontmatter` means explicit custom-agent handoffs declared in agent frontmatter that show a button or redirect path in VS Code.
- `selected manually` means the user explicitly chooses the next agent instead of relying on natural-language routing or frontmatter handoffs.
- Ratings are optimized for cost-minimization in local VS Code use, not for maximum rigor or maximum autonomy.