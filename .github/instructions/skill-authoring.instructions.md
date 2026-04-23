---
applyTo: "copilot/skills/**"
---

# Skill Authoring Rules

These rules apply when creating or modifying any KIRA skill file in `copilot/skills/`.

---

## Required Frontmatter

```yaml
---
name: kira-<name>          # must match the parent folder name exactly
description: "..."          # quoted; must include "Use when:" with trigger phrases
user-invocable: true|false  # true = appears as /slash command in chat
---
```

---

## Description Rules

- Must be quoted — skill descriptions frequently contain colons
- Must include "Use when:" followed by specific trigger phrases or scenarios
- The `name` value must exactly match the folder name (e.g., folder `kira-plan-gate/` → `name: kira-plan-gate`)

---

## Body Structure

- Lead with a scope statement: portable personal skill, or project-specific
- Use `## Procedure` or `## Workflow` for sequential steps — always numbered
- Use `## Rules` for hard constraints — always bulleted
- Keep files concise — skills are loaded on demand, not persistently in context

---

## Anti-patterns

- Do NOT add `applyTo` to a skill file — skills are loaded on demand, never auto-applied
- Do NOT duplicate logic already present in an agent's system prompt
- Do NOT use prose paragraphs — prefer numbered steps and short bullets
- Do NOT omit the "Use when:" clause from `description` — it is the discovery surface

---

## Checklist When Adding a New Skill

- [ ] Folder name matches `name` frontmatter exactly
- [ ] `description` is quoted and includes "Use when:" triggers
- [ ] `user-invocable` set appropriately
- [ ] Steps are numbered under `## Procedure` or `## Workflow`
- [ ] Skills inventory table in `.github/copilot-instructions.md` updated
- [ ] Referenced in the relevant agent's Instruction Source of Truth fallback list (if applicable)
