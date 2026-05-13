# KIRA Token Cost Efficiency — Optimization Todos

Generated: 2026-04-30  
Context: Migration from premium-request billing to token-based billing (input + output).  
Under token billing, every byte injected into context has a direct cost. The root agent body is loaded on every prompt turn; subagent bodies are loaded on every invocation.

---

- Add ticket-intake source detection for planning workflows.
	- Detect GitHub versus Azure DevOps from URL, ID shape, or remote host when possible.
	- Retrieve ticket content with the appropriate CLI or fallback path instead of guessing from a bare identifier.
- Add PR-source detection for review workflows.
	- Detect GitHub versus Azure DevOps from PR URL, PR number plus remote host, or explicit user context.
	- Retrieve PR metadata and diff with the right CLI path before review starts, with a clean fallback when ambiguous.
- Resolve lead-lane tool mismatch for review and git workflows.
	- `Kira` currently keeps review, commit-message drafting, and commit execution in the lead lane.
	- Verify whether these workflows need terminal access in `Kira`, or should be rerouted to a terminal-capable sub-agent instead.
- Resolve planning-lane ticket retrieval mismatch.
	- `Kira :: Plan` is expected to resolve GitHub and Azure ticket references.
	- Verify whether it needs terminal access for CLI retrieval, or whether ticket prompts should stay limited to URLs and pasted ticket content until that is implemented.
- Verify custom-agent terminal tool naming in active VS Code builds.
	- Confirm whether `terminal` is a valid custom-agent tool name in diagnostics.
	- If not, replace it with the documented built-in tool name before relying on command execution in `Kira :: Code`.
- Decide whether commit-drafting prompts should pin a cheap model.
	- `/draft-commit` and `/draft-squash` currently inherit the active model.
	- Either pin them to `GPT-5 mini` or accept the cost variance explicitly.
- Evaluate `GPT-5.4 mini` as a mid-cost review lane.
	- Compare branch and PR review quality against `GPT-5.3-Codex` and `GPT-5.4`.
	- Use it only if it materially lowers cost without losing too many defect findings.
- Evaluate a deeper `/kira` utility prompt.
	- Keep `/kira` as the normal reset prompt.
	- Add a separate stronger-model variant only if a repeatable deeper Kira lane proves useful often enough to justify the cost.
- Coder is too much chatty after implementing code. See [coder-too-much-chatty.md](docs/issues/coder-too-much-chatty.md) for an example details. This might need to run by Kira :: Plan to decide whether it’s a cost issue or a quality issue, and whether it’s worth addressing with prompt engineering or a model change.
- Return to Kira handoff? after plan and code.
- Kira should tell me to involve plan or code asap, not try to implement code herself. See [kira-should-hand-off-to-code.md](docs/issues/kira-should-hand-off-to-code.md) for details.

