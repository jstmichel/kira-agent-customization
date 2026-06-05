# Copilot Review TODO

Reviewed scope:

- `copilot/agents`
- `copilot/instructions`
- `copilot/prompts`

Goal of this backlog:

- keep the default VS Code Copilot flow friendly and cheap
- escalate to premium models only when the task genuinely needs it
- reduce unnecessary output tokens
- ensure generated artifacts default to fenced markdown code blocks for copy/paste when they are not being written to disk
- make internal and external handoffs feel seamless
- make handoff button labels coherent and predictable

## P0 - Fix behavior mismatches and UX friction

Status after this pass:

- Done: items 1, 2, 3, 4, 5
- Partially done: item 6, item 10, item 11
- Still open: items 7, 8, 9

### 1. Clarify artifact output defaults versus logical file creation
Why:

- The current rules mix two valid behaviors without clearly defining the default:
  - return an artifact in chat for copy/paste
  - write an artifact directly to disk when that is the logical outcome of the task
- What is missing is a single rule that explains when each behavior should happen.

Evidence:

- `copilot/agents/kira.agent.md:30-31`
- `copilot/prompts/kira-create-adr.prompt.md:19-20`
- `copilot/prompts/kira-create-analysis.prompt.md:19-20`
- `copilot/skills/kira-change-docs/SKILL.md:22-23`

Change:

- Define `artifact` explicitly in shared instructions as any result output that is not a plain answer, such as a plan, ADR, analysis note, commit message, PR draft, story description, ticket draft, or code sample.
- Make fenced markdown block output the default for artifacts that are being returned in chat.
- Allow direct file creation when saving to disk is the logical task outcome, such as ADRs, analysis docs, or repository documentation.
- Keep the rule that if the artifact is not being written to disk, it must be returned in a fenced markdown block.
- Use one shared rule in core instructions so prompts and skills do not restate slightly different versions.

### 2. Make premium escalation explicit, rare, and criteria-based
Why:

- The setup says "prefer the lightest model" but does not define a sharp threshold for when Kira should stay on the cheap path versus hand off to premium agents.
- That leaves room for inconsistent cost behavior in normal use.

Evidence:

- `copilot/instructions/kira-core.instructions.md:14-19`
- `copilot/agents/kira.agent.md:28-31`
- `copilot/agents/kira-architect.agent.md:3-5`
- `copilot/agents/kira-codex.agent.md:3-5`

Change:

- Add a short escalation matrix in `kira-core.instructions.md`:
  - stay on `Kira` for ordinary Q&A, small edits, light planning, drafting, and straightforward validation
  - hand off to `Kira :: Architect` only for cross-cutting design, API/schema/security decisions, or ADR-worthy tradeoffs
  - hand off to `Kira :: Codex` only for repeated failures, non-obvious debugging, or multi-file implementation loops that need deeper reasoning
- Require Kira to briefly say why escalation is needed before handing off.

### 3. Standardize handoff button names across all agents
Why:

- Current labels mix verb styles and casing. That makes the flow feel less polished in Copilot and makes the return path less obvious.

Evidence:

- `copilot/agents/kira.agent.md:8-14`
- `copilot/agents/kira-architect.agent.md:7-13`
- `copilot/agents/kira-codex.agent.md:7-13`

Current examples:

- `Escalate Architecture Review`
- `Escalate Hard Debugging`
- `Back To Kira`
- `Escalate To Codex`
- `Escalate To Architect`

Change:

- Pick one consistent pattern, for example:
  - `Review with Architect`
  - `Debug with Codex`
  - `Return to Kira`
  - `Review with Architect`
  - `Return to Kira`
- Keep title case and the same verb pattern everywhere.

### 4. Tighten Kira's output contract so normal answers stay small
Why:

- Kira's current planning contract is thorough, but it is a bit heavy for day-to-day Copilot use and can increase output tokens even when the user only needs a quick answer or a short plan.

Evidence:

- `copilot/agents/kira.agent.md:34-39`

Change:

- Split Kira outputs into two modes:
  - default compact mode for normal use
  - structured extended mode only when the user asks for a full plan/review
- Make optional sections truly optional instead of always implied.

## P1 - Improve flow, clarity, and consistency

### 5. Add a "default response style" rule for low-verbosity Copilot interaction
Why:

- The core rules say "concise and practical" but do not clearly prohibit extra framing, repeated restatement, or unnecessary headings.
- A stronger default will save tokens and feel more natural in editor chat.

Evidence:

- `copilot/instructions/kira-core.instructions.md:7-10`

Change:

- Add explicit rules such as:
  - answer directly first
  - do not restate the prompt unless useful
  - prefer short prose over templates unless the task asks for structure
  - use bullets only when they improve scanability
  - keep follow-up suggestions to one short line

### 6. Reduce duplicated artifact rules across prompts and skills
Why:

- The repo repeats similar output guidance in multiple places. That increases maintenance cost and risks drift.

Evidence:

- `copilot/instructions/kira-core.instructions.md:7-10`
- `copilot/instructions/kira-drafting.instructions.md:5-8`
- `copilot/prompts/kira-create-adr.prompt.md:16-22`
- `copilot/prompts/kira-create-analysis.prompt.md:16-22`
- `copilot/skills/kira-change-docs/SKILL.md:38-65`

Change:

- Move the universal artifact rule into core or drafting instructions:
  - "Generated artifacts default to fenced markdown blocks when returned in chat."
  - "If the task outcome is logically a saved document or file, the artifact may be written to disk."
  - "If the artifact is not written to disk, return it in a fenced markdown block."
- Let prompts define only the artifact-specific section structure.

### 7. Clarify the relationship between prompt-driven drafting and agent handoffs
Why:

- `Kira :: Draft` is user-invocable and used inline by Kira, while some drafting prompts route to `Kira :: Architect`. That split makes sense, but the boundaries are not obvious yet.

Evidence:

- `copilot/agents/kira.agent.md:25-31`
- `copilot/agents/kira-draft.agent.md:15-24`
- `copilot/prompts/kira-create-adr.prompt.md:4`
- `copilot/prompts/kira-create-analysis.prompt.md:4`

Change:

- Document a simple rule:
  - use `Kira :: Draft` for wording-only artifacts
  - use `Kira :: Architect` only when the artifact requires an actual design decision
- Consider whether ADR/analysis prompts should stay on Architect or be split into:
  - `Draft ADR from existing decision`
  - `Review decision with Architect`

### 8. Make intake output better aligned with follow-on execution
Why:

- Intake packets are good, but they stop just short of giving Kira a compact execution-ready packet.
- A slightly tighter schema would make handoff from intake to implementation feel more seamless.

Evidence:

- `copilot/agents/kira-intake.agent.md:21-37`
- `copilot/skills/kira-ticket-intake/SKILL.md:39-62`

Change:

- Add fields like:
  - `Decision Needed`
  - `Suggested First Step`
  - `Blocking Unknowns`
- Keep the packet compact and easy to paste into the next step.

## P2 - Nice improvements after the core fixes

### 9. Consider making specialist agents handoff-only in practice
Why:

- `Kira :: Architect`, `Kira :: Codex`, and `Kira :: Draft` are currently `user-invocable: true`.
- For a friendlier Copilot flow, the main entry point should usually be Kira, with specialists appearing as intentional buttons.

Evidence:

- `copilot/agents/kira-architect.agent.md:4`
- `copilot/agents/kira-codex.agent.md:4`
- `copilot/agents/kira-draft.agent.md:4`

Change:

- Decide whether to keep specialists directly invocable.
- If yes, add wording that still nudges users toward starting with Kira.
- If no, change the metadata to make Kira the clear front door.

### 10. Add one short README section that explains the model ladder
Why:

- The folder structure is understandable, but the intended cheap-to-premium path is not visible unless someone reads several files.

Change:

- Document the default flow in 5-8 lines:
  - `Kira` first
  - `Kira :: Intake` for normalization
  - `Kira :: Draft` for cheap text generation
  - `Kira :: Architect` for design decisions
  - `Kira :: Codex` for hard debugging and implementation rescue

### 11. Normalize terminology around "draft", "analysis", "review", and "escalation"
Why:

- Some names describe the artifact, some describe the action, and some describe the cost tier.
- A cleaner vocabulary will make the system easier to learn and easier to extend.

Change:

- Use one naming model consistently:
  - `Draft ...` for text generation
  - `Review ...` for decision support
  - `Debug ...` for deep implementation help
  - `Return to Kira` for every back-handoff

## Recommended implementation order

1. Fix artifact write behavior versus code-block output.
2. Add explicit escalation criteria and compact-response defaults.
3. Rename handoff buttons consistently.
4. Deduplicate shared output rules.
5. Refine intake and drafting boundaries.
6. Document the final model ladder in README.

## Expected result after these changes

- Kira stays friendly and low-cost for normal editor use.
- Premium models are used intentionally instead of casually.
- Outputs are shorter and easier to paste.
- Drafted artifacts consistently appear in fenced markdown blocks.
- Handoffs feel smoother and more predictable in the VS Code Copilot UI.
