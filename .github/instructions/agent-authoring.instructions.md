---
applyTo: "copilot/agents/**"
---

# Agent Authoring Rules

These rules apply when creating or modifying any KIRA agent file in `copilot/agents/`.

---

## Required Frontmatter

```yaml
---
name: KIRA :: <Subsystem>
description: "..."   # quoted; must start with what the agent does and include routing triggers
tools: [read, edit, search, execute]  # only tools the agent actually needs
model: <model-name> (copilot)
---
```

Optional frontmatter:
- `argument-hint` — shown in the chat slash command picker
- `model` may be a list when alternatives are acceptable

---

## Required Sections (in this order)

1. **Identity** — One-line diagnostics string in the format:
   `[SUBSYSTEM] ONLINE — <role> | <capabilities>`

2. **Personality & Tone** — KIRA voice. Warm and friendly; addresses the user directly. Include 4–5 example phrases covering: starting work, hitting a blocker, delivering, asking a design question.

3. **Instruction Source of Truth** — Standard hierarchy, in order:
   1. `.github/copilot-instructions.md`
   2. Dynamic discovery under `.github/instructions/` — no hardcoded lists
   3. Personal skill fallbacks (only when no project instructions found)

4. **Purpose / Guidelines / Workflow** — Core functional content of the agent.

5. **Rules** — Hard constraints. No more than 5 bullet points.

---

## Routing Rules

- All subsystems must explicitly surface design decisions to KIRA or to the user — never guess.
- Subsystems that produce output return a structured deliverables list to KIRA when done.
- KIRA :: Architect never writes code. All other subsystems do not perform architectural planning.

---

## Description Anti-patterns

- Do NOT use vague descriptions like "helps with coding" or "handles tasks"
- DO include explicit trigger phrases: `"Use directly or as part of the KIRA system for..."`
- DO quote the description value — descriptions frequently contain colons

---

## Checklist When Adding a New Agent

- [ ] Frontmatter: `name`, `description`, `tools`, `model` present
- [ ] Sections in order: Identity, Personality & Tone, Instruction Source of Truth, workflow, Rules
- [ ] Description quoted and includes trigger phrases
- [ ] `copilot/skills/kira-run-diagnostics/SKILL.md` diagnostics block updated
- [ ] Routing table in `copilot/agents/kira.agent.md` updated
