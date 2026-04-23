---
applyTo: "copilot/prompts/**"
---

# Prompt Authoring Rules

These rules apply when creating or modifying any KIRA prompt file in `copilot/prompts/`.

---

## Required Frontmatter

```yaml
---
description: "..."        # quoted; one sentence describing what the prompt does
agent: KIRA :: <Subsystem>  # exact agent name to invoke
argument-hint: "..."      # optional: shown in the slash command picker as a hint
---
```

---

## Body Rules

- The body is the instruction sent directly to the target agent
- Keep it short: one to three sentences stating the task and what to ask for if missing
- If the task requires user input (e.g., a feature description), instruct the agent to ask for it: `"If I have not provided X, ask me for one."`
- Do not duplicate the agent's full system prompt here — the body is a focused task directive only

---

## Anti-patterns

- Do NOT include implementation logic — that belongs in the agent or skill
- Do NOT hardcode paths or project-specific details in a prompt (keep prompts portable)
- Do NOT omit `agent` frontmatter — without it, the prompt runs in the default agent context

---

## Checklist When Adding a New Prompt

- [ ] `description` is quoted and clearly states the prompt's purpose
- [ ] `agent` matches an existing agent `name` exactly
- [ ] `argument-hint` provided if the prompt requires user-supplied context
- [ ] Body is concise and action-oriented
- [ ] Prompts inventory table in `.github/copilot-instructions.md` updated
